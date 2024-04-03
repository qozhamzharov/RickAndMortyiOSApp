//
//  RMRequest.swift
//  RIckAndMorty
//
//  Created by kozhamzharov on 02.04.2024.
//

import Foundation

/// Object that represents a singlet API call
final class RMRequest {
    //Base URL
    //Endpoint
    //Path components
    //Query parameters
    // https://rickandmortyapi.com/api/character/2
    
    /// API constants
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    private let endpoint: RMEndpoint
    
    /// Path components for API, if any
    private let pathComponents: Set<String>
    
    /// Query  arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    // Consstructed url for the api request in string format
    private var urlString: String {
        var string = Constants.baseURL
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            string += "/"
            pathComponents.forEach({
                string += "\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "/"
            //name = value&name = value
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil}
                return "\($0.name) = \(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired http method
    public let httpMethod = "GET"
    
    // MARK: - Public
    
    /// Construct request
    /// - Parameters:
    ///  - endpoint: Target endpoint
    ///  - pathComponents: Collection of Path components
    ///  - queryParameters: Collection of query parameters
    
    public init(endpoint: RMEndpoint, pathComponents: Set<String> = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}
