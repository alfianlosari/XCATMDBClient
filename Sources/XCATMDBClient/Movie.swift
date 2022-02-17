//
//  Movie.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 23/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
    
    let results: [Movie]
}


/// Representation of a Movie
///
/// The model provides the metadata for a movie such as: ``title``,  ``overview``,  ``cast``.
///
/// Example of showing movie title and overview using SwiftUI
/// ```swift
/// ForEach(movies) { movie in
///     VStack {
///         movie.title
///         movie.overview
///     }
/// }
/// ```
public struct Movie: Decodable, Identifiable, Hashable {

    /// Unique Id of the movie
    public let id: Int
    
    /// Title of the movie (e.g The Godfather)
    public let title: String
    let backdropPath: String?
    let posterPath: String?
    
    /// A short summary of the story
    public let overview: String
    let voteAverage: Double
    let voteCount: Int
    
    let runtime: Int?
    let releaseDate: String?
    
    let genres: [MovieGenre]?
    let credits: MovieCredit?
    let videos: MovieVideoResponse?
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    /// Image backdrop URL of the movie
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    /// Image poster URL of the movie
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    /// Star rating text of the movie
    public var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
    
    /// Release year of the movie
    public var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    /// Duration of the movie
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return String(runtime) + "seconds"
    }
    
    /// Casts of the movie
    public var cast: [MovieCast]? {
        credits?.cast
    }
    
    var crew: [MovieCrew]? {
        credits?.crew
    }
    
    /// Director(s) of the movie
    var directors: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "director" }
    }
    
    /// Producer(s) of the movie
    var producers: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "producer" }
    }
    
    var screenWriters: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "story" }
    }
    
    /// YouTube trailers of the movie
    var youtubeTrailers: [MovieVideo]? {
        videos?.results.filter { $0.youtubeURL != nil }
    }
    
}

public extension Movie {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// Genre of the movie
public struct MovieGenre: Decodable {
    
    public let name: String
}

struct MovieCredit: Decodable {
    
    public let cast: [MovieCast]
    public let crew: [MovieCrew]
}

/// Cast of the movie containing character name and actor real name
public struct MovieCast: Decodable, Identifiable {
    public let id: Int
    public let character: String
    public let name: String
}

/// Crew of the movie containing real name and job description
public struct MovieCrew: Decodable, Identifiable {
    public let id: Int
    public let job: String
    public let name: String
}

struct MovieVideoResponse: Decodable {
    
    let results: [MovieVideo]
}

/// Video Trailer of a movie containing the name and YouTube URL
public struct MovieVideo: Decodable, Identifiable {
    
    public let id: String
    public let key: String
    public let name: String
    public let site: String
    
    public var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}

