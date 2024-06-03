//
//  SearchMovieVC.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 3.06.2024.
//

import UIKit

class SearchMovieVC: UIViewController {
    
    enum Section { case main }
    
    var movies: [MoviePreview] = []
    var page = 1
    var hasMoreMovie = true
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,MoviePreview>!
    var searchText: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        configureDataSource()
        configureSearchController()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    func configureViewController() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayout(in: view, withCol: 2))
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,MoviePreview>(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
            cell.set(movie: movie)
            return cell
        })
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a movie"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    
    func updateData(on movies: [MoviePreview]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MoviePreview>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    
    func getMovies(title: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.searchMovies(for: title, page: page) { [weak self] result in
            guard let self = self else { return }
            dismissLoadingView()
            switch result {
                
            case .success(let searchResult):
                if searchResult.search.count < 10 { self.hasMoreMovie = false}
                self.movies.append(contentsOf: searchResult.search)
                
                
                if self.movies.isEmpty {
                    
                    return
                }
                self.updateData(on: self.movies)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Things went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
}


extension SearchMovieVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchText.elementsEqual(searchBar.text?.lowercased() ?? "") {
            return
        }
        searchText = searchBar.text?.lowercased() ?? ""
        page = 1
        movies.removeAll(keepingCapacity: true)
        getMovies(title: searchText, page: page)
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        print("cancel clicked")
    }
    
}


extension SearchMovieVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreMovie else { return }
            page += 1
            getMovies(title: searchText, page: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let activeArray = isSearching ? filteredFollowers : followers
//        let follower = activeArray[indexPath.item]
//        
//        let destVC = UserInfoVC()
//        destVC.username = follower.login
//        let navController = UINavigationController(rootViewController: destVC)
//        present(navController, animated: true)
    }
}
