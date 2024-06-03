//
//  MoviePreview.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 3.06.2024.
//

import Foundation

struct MoviePreview: Codable, Hashable {
    var title: String
    var year: String
    var imdbID: String
    var type: String
    var poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
