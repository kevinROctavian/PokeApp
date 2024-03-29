//
//  APIResponse.swift
//  PokeApp
//
//  Created by Kevin Renata on 08/07/23.
//

import Foundation

public enum ApiResponse<T> {
    case success(HTTPURLResponse, T)
    case failure(HTTPURLResponse?, ApiError)

    public var result: Result<T, ApiError> {
        switch self {
        case .success(_, let value):
            return .success(value)
        case .failure(_, let error):
            return .failure(error)
        }
    }
}

public enum ApiError: Error {
    var localizedDescription: String {
        switch self {
        case .network(errorMessage: let error):
            return error
        case .generic:
            return "error"
        }
    }
    case network(errorMessage: String)
    case generic
}
