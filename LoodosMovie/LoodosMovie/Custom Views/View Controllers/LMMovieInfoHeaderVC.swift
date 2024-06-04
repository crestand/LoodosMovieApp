//
//  LMMovieInfoHeaderVC.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 3.06.2024.
//

import UIKit

class LMMovieInfoHeaderVC: UIViewController {

    let movieImageView = LMMovieImageView(frame: .zero)
    let movieBackgroundImage = LMMovieImageView(frame: .zero)
    let movieTitle = LMTitleLabel(textAlignment: .left, fontSize: 24)
    let yearRuntimeLabel = LMSecondaryTitleLabel(fontSize: 18)
    let directedByLabel = LMSecondaryTitleLabel(fontSize: 18)
    let directorLabel = LMTitleLabel(textAlignment: .left, fontSize: 20)
   
    var movie: Movie!
    
    
    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
    }
    
    
    func configureUIElements() {
        movieImageView.downloadImage(from: movie.poster)
        movieBackgroundImage.image = movieImageView.image
        movieBackgroundImage.addBlurEffect()
        movieBackgroundImage.clipsToBounds = false
        movieTitle.text = movie.title
        yearRuntimeLabel.text = "\(movie.year) - \(movie.runtime)"
        directedByLabel.text = "Directed by"
        directorLabel.text = movie.director

    }
    
    
    func addSubviews() {
        view.addSubview(movieBackgroundImage)
        view.addSubview(movieImageView)
        view.addSubview(movieTitle)
        view.addSubview(yearRuntimeLabel)
        view.addSubview(directedByLabel)
        view.addSubview(directorLabel)
    }
    
    
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12

        movieTitle.numberOfLines = 0

        NSLayoutConstraint.activate([
        
            movieBackgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            movieBackgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieBackgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            movieBackgroundImage.heightAnchor.constraint(equalTo: movieBackgroundImage.widthAnchor, multiplier: 1.77),
            
            movieImageView.bottomAnchor.constraint(equalTo: movieBackgroundImage.bottomAnchor, constant: -10),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            movieImageView.widthAnchor.constraint(equalToConstant: 130),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 1.77),
            
            
            yearRuntimeLabel.centerYAnchor.constraint(equalTo: movieImageView.centerYAnchor, constant: -30),
            yearRuntimeLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: textImagePadding),
            yearRuntimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            yearRuntimeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            movieTitle.topAnchor.constraint(equalTo: yearRuntimeLabel.bottomAnchor, constant: 10),
            movieTitle.bottomAnchor.constraint(lessThanOrEqualTo: movieImageView.bottomAnchor),
            movieTitle.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: textImagePadding),
            movieTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
         
            directedByLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: textImagePadding),
            directedByLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            directedByLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            directedByLabel.heightAnchor.constraint(equalToConstant: 20),
            
            directorLabel.topAnchor.constraint(equalTo: directedByLabel.bottomAnchor, constant: 5),
            directorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            directorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            directorLabel.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    

}
