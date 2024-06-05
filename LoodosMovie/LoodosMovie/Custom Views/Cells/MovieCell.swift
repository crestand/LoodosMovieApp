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
        layer.borderWidth = 1
        layer.cornerRadius = 16
        layer.borderColor = UIColor.black.cgColor

        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 16/9),
        ])
    }
}
