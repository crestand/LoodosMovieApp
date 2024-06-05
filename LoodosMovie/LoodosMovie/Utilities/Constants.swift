//
//  Constants.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 5.06.2024.
//

import UIKit

struct Constants {
    
    struct Fonts {
        static let splashScreenFont = UIFont(name: "NordiquePro-Bold", size: 60)
    }
    
    struct Colors {
        static let loodosColor = UIColor(red: 67/256, green: 181/256, blue: 195/256, alpha: 1)
    }
    
    struct Images {
        static let imdbLogo = UIImage(named: "imdb-logo")
        static let moviePlaceholder = UIImage(named: "movie_placeholder")
    }
    
    struct Network {
        static let apiKey = "64e9a403"
    }
}
