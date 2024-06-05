//
//  LMMovieImageView.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 3.06.2024.
//

import UIKit
import Alamofire

class LMMovieImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let placeholderImage = UIImage(named: "")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 16
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        AF.request(url).responseData { [weak self] response in
            guard let self = self else { return }
            if response.error == nil {
                guard let data = response.data else { return }
                guard let image = UIImage(data: data) else { return }
                self.cache.setObject(image, forKey: cacheKey)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
