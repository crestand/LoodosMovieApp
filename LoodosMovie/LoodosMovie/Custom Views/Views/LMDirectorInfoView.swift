//
//  LMDirectorInfoView.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 4.06.2024.
//

import UIKit

class LMDirectorInfoView: UIView {

    let directedByLabel = LMSecondaryTitleLabel(fontSize: 18)
    let directorLabel = LMTitleLabel(textAlignment: .left, fontSize: 20)
   
    var directorName: String!
    
    
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
        directedByLabel.text = "Directed by"
        directorLabel.numberOfLines = 2
    }
    
    
    func addSubviews() {
        addSubview(directedByLabel)
        addSubview(directorLabel)
    }
    
    
    func layoutUI() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            directedByLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -5),
            directedByLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            directedByLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            directedByLabel.heightAnchor.constraint(equalToConstant: 20),

            directorLabel.topAnchor.constraint(equalTo: directedByLabel.bottomAnchor, constant: 5),
            directorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            directorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            directorLabel.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    
    func set(director: String) {
        directorName = director
        directorLabel.text = directorName
    }

}
