//
//  MovieStore.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 23/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation
//#if os(Linux)
//import FoundationNetworking
//#endif

/// Retrieve and Search Movies from TMDB API
///
/// You can fetch list of movies based on a ``MovieListEndpoint``, fetch a movie metadata passing and `id`, and search movies related to query keywords.
///
/// It uses the new `Async/Await` concurrency in Swift 5.5 to perform the fetch data operation from TMDB API. Make sure to invoke one of the public method in an `async` context.

public class MovieStore: MovieService {
        
    private let apiKey: String
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    /// Initialize MovieStore instance passing the TMDB API Key
    /// - Parameter apiKey: API Key provided from [TMDB API](https://tmdb.org)
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func fetchMovies(from endpoint: MovieListEndpoint) async throws -> [Movie] {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
            throw MovieError.invalidEndpoint
        }
        let movieResponse: MovieResponse = try await self.loadURLAndDecode(url: url)
        return movieResponse.results
    }
    
    public func fetchMovie(id: Int) async throws -> Movie {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            throw MovieError.invalidEndpoint
        }
        return try await self.loadURLAndDecode(url: url, params: [
            "append_to_response": "videos,credits"
        ])
    }
    
    public func searchMovie(query: String) async throws -> [Movie] {
        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
            throw MovieError.invalidEndpoint
        }
        let movieResponse: MovieResponse = try await self.loadURLAndDecode(url: url, params: [
            "language": "en-US",
            "include_adult": "false",
            "region": "US",
            "query": query
        ])
        
        return movieResponse.results
    }
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil) async throws -> D {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw MovieError.invalidEndpoint
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            throw MovieError.invalidEndpoint
        }
        let (data, response) = try await urlSession.data(from: finalURL)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw MovieError.invalidResponse
        }
        
        return try self.jsonDecoder.decode(D.self, from: data)
    }
}
