//
//  MovieSearch.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 3.06.2024.
//

import Foundation

struct MovieSearch: Codable {
    var search: [MoviePreview]
    var totalResults: String
    var response: String
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
    
}
