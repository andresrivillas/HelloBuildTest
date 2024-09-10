//
//  HBError.swift
//  HelloBuildTest
//
//  Created by Andres Rivillas on 10/09/24.
//

import Foundation

enum HBError: String, Error {
    case  invalid = "Invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
