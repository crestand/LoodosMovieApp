//
//  NetworkManager.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 3.06.2024.
//

import UIKit
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://www.omdbapi.com/?apikey=\(Constants.Network.apiKey)"
    let cache = NSCache<NSString,UIImage>()
    
    
    func searchMovies(for title: String, page: Int = 1, completed: @escaping(Result<MovieSearch, LMError>) -> Void) {
        let parameters: [String: Any] = [
            "s": title,
            "type": "movie",
            "page": page
        ]
        
        AF.request(baseURL, parameters: parameters).validate().responseDecodable(of: MovieSearch.self) { response in
            switch response.result {
            case .success(let searchResult):
                completed(.success(searchResult))
            case .failure(_):
                completed(.failure(.unableToComplete))
            }
        }
    }
    
    
    func getMovieInfo(for movieID: String, completed: @escaping(Result<Movie, LMError>) -> Void) {
        let parameters: [String: Any] = [
            "i": movieID,
            "plot": "full"
        ]
        
        AF.request(baseURL, parameters: parameters).validate().responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let movie):
                completed(.success(movie))
            case .failure(_):
                completed(.failure(.unableToComplete))
            }
        }
    }
    
}
