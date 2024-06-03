//
//  SearchMovieVC.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 3.06.2024.
//

import UIKit

class SearchMovieVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemRed
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    

}
