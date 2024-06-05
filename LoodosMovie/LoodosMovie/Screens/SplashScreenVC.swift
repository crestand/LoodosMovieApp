//
//  SplashScreenVC.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 3.06.2024.
//

import UIKit
import Firebase

class SplashScreenVC: UIViewController {

    let splashText = LMTitleLabel(textAlignment: .center, fontSize: 40)
    let searchMovieVC = SearchMovieVC()
    let remoteConfig = RemoteConfig.remoteConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        checkNetworkStatus()
        setupRemoteConfigDefaults()
        fetchRemoteConfig()
        configureSplashText()
        
    }
    

    func configureSplashText() {
        view.addSubview(splashText)
        
        splashText.text = RemoteConfig.remoteConfig().configValue(forKey: "splashText").stringValue?.lowercased()
        splashText.textColor = Constants.Colors.loodosColor
        splashText.font = Constants.Fonts.splashScreenFont
        
        NSLayoutConstraint.activate([
            splashText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            splashText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            splashText.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            splashText.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
    }
    
    
    func checkNetworkStatus() {
        if NetworkMonitor.shared.isConnected {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async { self.navigationController?.pushViewController(self.searchMovieVC, animated: true) }
            })
        } else {
            presentGFAlertOnMainThread(title: "Network Error", message: "You are not connected to internet right now. Please try again later.", buttonTitle: "Ok")
        }
    }
    
    
    func setupRemoteConfigDefaults() {
        let defaultValues = [
            "splashText": "N/A" as NSObject
        ]
        remoteConfig.setDefaults(defaultValues)
    }
    
    
    func fetchRemoteConfig() {
        let debugSettings = RemoteConfigSettings()
        debugSettings.minimumFetchInterval = 0
        remoteConfig.configSettings = debugSettings
        
        remoteConfig.fetch(withExpirationDuration: 0) { [weak self] status, error in
            guard let self = self else { return }
            guard error == nil else { return }
            self.remoteConfig.activate()
        }
    }

}
