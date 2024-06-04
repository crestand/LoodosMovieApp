//
//  MovieCell.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 3.06.2024.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let reuseID = "MovieCell"
    let movieImageView = LMMovieImageView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(movie: MoviePreview) {
        movieImageView.downloadImage(from: movie.poster)
    }
    
    
    private func configure() {
        addSubview(movieImageView)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 1.77),
        ])
    }
}
