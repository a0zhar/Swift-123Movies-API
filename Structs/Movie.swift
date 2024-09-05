//
// ---------------------------------------------------------------------
// A Swift/Objective-C 123Movies Streaming Site API Implementation
// Made by A0ZHAR (https://github.com/a0zhar)
// Intended to work for TvOS and IOS Apps
// ---------------------------------------------------------------------
//

import Foundation

//
// Define a struct to represent a Movie
struct Movie {
    let id: String             // Unique identifier or URL for the movie
    let title: String          // The title of the movie
    let poster: String         // URL or path to the poster image of the movie
    let description: String    // Brief description of the movie
    let imdbScore: Float       // IMDb score of the movie (using Float for the score)
    let genres: [String]       // Array of genres associated with the movie
    let year: String           // Release year of the movie
    let episodeLength: String  // Length of the movie in minutes
    let quality: String        // Quality of the movie (e.g., HD, SD)
}
