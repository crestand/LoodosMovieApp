//
//  LMRatingInfoVC.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 4.06.2024.
//

import UIKit

class LMRatingInfoVC: UIViewController {

    let imdbLogoImageView = UIImageView()
    let ratingLabel = LMTitleLabel(textAlignment: .left, fontSize: 20)
   
    var imdbRating: String!
    
    
    init(imdbRating: String) {
        super.init(nibName: nil, bundle: nil)
        self.imdbRating = imdbRating
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
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 18
        view.layer.masksToBounds = true
        ratingLabel.text = imdbRating
        
        imdbLogoImageView.image = Constants.Logos.imdbLogo
    }
    
    
    func addSubviews() {
        view.addSubview(ratingLabel)
    }
    
    
    func layoutUI() {
        let padding: CGFloat = 20
        imdbLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imdbLogoImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -5),
            imdbLogoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            imdbLogoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            imdbLogoImageView.heightAnchor.constraint(equalToConstant: 20),
            
            ratingLabel.topAnchor.constraint(equalTo: imdbLogoImageView.bottomAnchor, constant: 5),
            ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ratingLabel.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}
