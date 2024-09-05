//
// ---------------------------------------------------------------------
// A Swift/Objective-C 123Movies Streaming Site API Implementation
// Made by A0ZHAR (https://github.com/a0zhar)
// Intended to work for TvOS and IOS Apps
// ---------------------------------------------------------------------
//

import Foundation

struct Movie {
    let id: String
    let title: String
    let poster: String
    let description: String
    let imdbScore: Float
    let genres: [String]
    let year: String
    let episodeLength: String
    let quality: String
}
