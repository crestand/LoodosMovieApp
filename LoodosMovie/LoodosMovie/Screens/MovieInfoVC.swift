//
//  MovieInfoVC.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 3.06.2024.
//

import UIKit
import FirebaseAnalytics

class MovieInfoVC: UIViewController {

    let headerView = UIView()
    let moviePlotView = LMBodyLabel(textAlignment: .left)
    let movieInfoItemView = UIView()
    let imdbRatingInfoView = UIView()
    
    var itemViews: [UIView] = []
    var movieID: String!
    
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    
    private let contentView: UIView = {
        let v = UIView()
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieInfo()
        layoutUI()
        configureWiewController()
    }
    
    
    func configureWiewController() {
        view.backgroundColor = .systemBackground
    }
    
    
    func getMovieInfo() {
        NetworkManager.shared.getMovieInfo(for: movieID) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self.add(childVC: LMMovieInfoHeaderVC(movie: movie), to: self.headerView)
                    self.add(childVC: LMMovieInfoItemVC(movie: movie), to: self.movieInfoItemView)
                    self.moviePlotView.text = movie.plot
                }
                
                self.logEvent(movie: movie)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                DispatchQueue.main.async { self.navigationController?.popViewController(animated: true) }
                
            }
        }
    }
    
    
    func layoutUI() {
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        configurePlotLabel()
        
        itemViews = [headerView, moviePlotView, movieInfoItemView, imdbRatingInfoView]
        
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ])
        }
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 250),
            
            movieInfoItemView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            movieInfoItemView.heightAnchor.constraint(equalToConstant: 100),
            
            moviePlotView.topAnchor.constraint(equalTo: movieInfoItemView.bottomAnchor, constant: 20),
            moviePlotView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            moviePlotView.heightAnchor.constraint(lessThanOrEqualToConstant: 450),
            

        ])
    }
    
    
    func configurePlotLabel() {
        moviePlotView.numberOfLines = 0
        moviePlotView.backgroundColor = .secondarySystemBackground
        moviePlotView.layer.masksToBounds = true
        moviePlotView.layer.cornerRadius = 16
        moviePlotView.setPadding(paddingTop: 10, paddingBottom: 10, paddingLeft: 20, paddingRight: 20)
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    

    func logEvent(movie: Movie) {
        Analytics.logEvent("movie_selected", parameters: [
            "movie_title": movie.title,
            "movie_id": movie.imdbID,
            
          AnalyticsParameterContentType: "cont",
        ])
    }
    

}
