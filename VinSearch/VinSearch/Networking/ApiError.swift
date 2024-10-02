//
//  ApiError.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import Foundation

enum ApiError: LocalizedError {
    case invalidResponse
    case serverError(Int)
    case invalidRequestError(String)
    case transportError(String)
    case unknownError

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response"
        case .serverError(let code):
            return "Server error. Code: \(code)"
        case .invalidRequestError(let message):
            return "Invalid request: \(message)"
        case .transportError(let message):
            return "\(message)"
        case .unknownError:
            return "Unknown error"
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .invalidResponse:
            return "Please report this error"
        case .serverError:
            return "Please report this error"
        case .invalidRequestError:
            return "Check input data"
        case .transportError:
            return "Check your internet connection"
        case .unknownError:
            return "Unknown error"
        }
    }
}
