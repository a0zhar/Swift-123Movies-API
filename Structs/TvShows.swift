//
// ---------------------------------------------------------------------
// A Swift/Objective-C 123Movies Streaming Site API Implementation
// Made by A0ZHAR (https://github.com/a0zhar)
// Intended to work for TvOS and IOS Apps
// ---------------------------------------------------------------------
//

import Foundation

// Define a struct to represent a TV show
struct TVShow: Identifiable, Codable {
    var id: String              // Unique identifier or URL
    var title: String           // The title of the TV show
    var poster: URL             // URL for the poster image
    var description: String     // Brief description of the TV show
    var imdbScore: Double       // IMDb score of the show
    var genres: [String]        // Array of genres
    var year: String            // Release year
    var episodeLength: String   // Length of an episode
    var episodes: [Episode]     // Array of Episode structs representing individual episodes

    // Define a nested struct for the episode
    struct Episode: Identifiable, Codable {
        var id: String
        var title: String
        var url: String
    }

    // CodingKeys enum to map JSON keys to struct properties
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case poster
        case description
        case imdbScore = "imdb_score"
        case genres
        case year
        case episodeLength = "episode_length"
        case episodes
    }
}
