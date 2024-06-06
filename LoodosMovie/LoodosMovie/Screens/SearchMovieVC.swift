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
    var lastSearchText: String = ""
    
    private let sharedTransitionAnimator = SharedTransitionAnimator()
    private var selectedIndexPath: IndexPath? = nil
    
    
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
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
            self.dismissLoadingView()
            switch result {
                
            case .success(let searchResult):
                self.handleSuccess(with: searchResult.search)
                
            case .failure(let error):
                self.handleFailure(with: error)
            }
        }
    }

    
    private func handleSuccess(with newMovies: [MoviePreview]) {
        if newMovies.count < 10 { self.hasMoreMovie = false }
        self.movies.append(contentsOf: newMovies)
        if self.movies.isEmpty { return }
        self.updateData(on: self.movies)
    }

    
    private func handleFailure(with error: LMError) {
        self.presentGFAlertOnMainThread(title: "Things went wrong", message: error.rawValue, buttonTitle: "Ok")
        self.clearPage()
    }
    
    
    func clearPage() {
        movies.removeAll()
        page = 1
        searchText = ""
        updateData(on: movies)
    }
}


extension SearchMovieVC: UINavigationControllerDelegate {
    func navigationController(
      _ navigationController: UINavigationController,
      animationControllerFor operation: UINavigationController.Operation,
      from fromVC: UIViewController,
      to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is Self, toVC is MovieInfoVC {
            sharedTransitionAnimator.transition = .push
            return sharedTransitionAnimator
        }
        if toVC is Self, fromVC is MovieInfoVC {
            sharedTransitionAnimator.transition = .pop
            return sharedTransitionAnimator
        }
        return nil
    }
}


extension SearchMovieVC: SharedTransitioning {
    var sharedFrame: CGRect {
        guard let selectedIndexPath,
              let cell = collectionView.cellForItem(at: selectedIndexPath),
              let frame = cell.frameInWindow else { return .zero }
        return frame
    }
}


extension SearchMovieVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchBarText = searchBar.text?.lowercased(), !searchBarText.isEmpty, !searchText.elementsEqual(searchBarText) {
            lastSearchText = searchText
            searchText = searchBarText
            page = 1
            movies.removeAll(keepingCapacity: true)
            getMovies(title: searchText, page: page)
        }

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
        selectedIndexPath = indexPath
        let movie = movies[indexPath.item]
        let destVC = MovieInfoVC()
        destVC.movieID = movie.imdbID
        self.navigationController?.pushViewController(destVC, animated: true)
    }
}
