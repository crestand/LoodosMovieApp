//
//  LMMovieInfoItemVC.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 4.06.2024.
//

import UIKit

class LMMovieInfoItemVC: UIViewController {

    var movie: Movie!

    let stackView = UIStackView()
    let itemInfoViewOne = LMDirectorInfoView()
    let itemInfoViewTwo = LMMovieRatingInfoView()
    
    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewBackground()
        layoutUI()
        configureStackView()
        itemInfoViewOne.set(director: movie.director)
        itemInfoViewTwo.setRating(imdbRating: movie.imdbRating)
    }
    
    
    private func configureViewBackground() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }

    
    private func layoutUI() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor),
               
        ])
    }

}
