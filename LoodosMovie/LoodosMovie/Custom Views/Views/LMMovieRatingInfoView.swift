//
//  LMMovieRatingInfoView.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 4.06.2024.
//

import UIKit

class LMMovieRatingInfoView: UIView {

    let imdbLogoImageView = UIImageView()
    let ratingLabel = LMTitleLabel(textAlignment: .left, fontSize: 20)
   
    var imdbRating: String!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layoutUI()
        configureUIElements()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUIElements() {
        imdbLogoImageView.image = UIImage(named: "imdb-logo")
    }
    
    
    func addSubviews() {
        addSubview(ratingLabel)
        addSubview(imdbLogoImageView)
    }
    
    
    func layoutUI() {
        imdbLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        imdbLogoImageView.contentMode = .scaleAspectFill
            
        NSLayoutConstraint.activate([
         
            imdbLogoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imdbLogoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20),
            imdbLogoImageView.widthAnchor.constraint(equalToConstant: 48),
            imdbLogoImageView.heightAnchor.constraint(equalToConstant: 48),
            
            ratingLabel.topAnchor.constraint(equalTo: imdbLogoImageView.bottomAnchor),
            ratingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ratingLabel.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    
    func setRating(imdbRating: String) {
        self.imdbRating = imdbRating
        ratingLabel.text = self.imdbRating
    }

}
