//
//  LMError.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 3.06.2024.
//

import Foundation

enum LMError: String, Error{
    case invalidURL = "This URL created an invalid request. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
