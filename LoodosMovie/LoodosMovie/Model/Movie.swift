//
//  Movie.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 3.06.2024.
//

import Foundation

struct Movie: Codable {
    
    var title, year, rated, released: String
    var runtime, genre, director, writer: String
    var actors, plot, language, country: String
    var awards: String
    var poster: String
    var ratings: [Rating]
    var metascore, imdbRating, imdbVotes, imdbID: String
    var type, dvd, boxOffice, production: String
    var website, response: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
    
    
    
    struct Rating: Codable {
        var source, value: String
        
        enum CodingKeys: String, CodingKey {
            case source = "Source"
            case value = "Value"
        }
    }
}
