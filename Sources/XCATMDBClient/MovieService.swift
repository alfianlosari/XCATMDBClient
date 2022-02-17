//
//  MovieService.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 23/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation

/// A protocol to Retrieve and Search Movies
public protocol MovieService {
    
    /// Fetch list of movies from an endpoint
    /// - Parameter endpoint: ``MovieListEndpoint``
    /// - Returns: Array of ``Movie``
    func fetchMovies(from endpoint: MovieListEndpoint) async throws -> [Movie]

    
    /// Fetch a single movie given an id
    /// - Parameter id: Integer value of a movie from TMDB API
    /// - Returns: instance ``Movie``
    func fetchMovie(id: Int) async throws -> Movie
    
    /// Search list of movies given using the query keywords
    /// - Parameter query: Query string
    /// - Returns: Array of ``Movie``
    func searchMovie(query: String) async throws -> [Movie]

}

public enum MovieListEndpoint: String, CaseIterable, Identifiable {
    
    public var id: String { rawValue }
    
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    
    public var description: String {
        switch self {
            case .nowPlaying: return "Now Playing"
            case .upcoming: return "Upcoming"
            case .topRated: return "Top Rated"
            case .popular: return "Popular"
        }
    }
}

public enum MovieError: Error, CustomNSError {
    
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    public var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    
    public var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}

