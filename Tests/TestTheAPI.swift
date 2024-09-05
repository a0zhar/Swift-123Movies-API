//
// ---------------------------------------------------------------------
// A Swift/Objective-C 123Movies Streaming Site API Implementation
// Made by A0ZHAR (https://github.com/a0zhar)
// Intended to work for TvOS and IOS Apps
// ---------------------------------------------------------------------
//
import Foundation

// Create an instance of the APIClient
let apiClient = APIClient()

// Fetch movies from the API
apiClient.getMovies(page: 1) { result in
    switch result {
    case .success(let movies):
        print("Movies:", movies)
    case .failure(let error):
        print("Error fetching movies:", error)
    }
}

// Fetch TV series from the API
apiClient.getTVSeries(page: 1) { result in
    switch result {
        case .success(let tvShows):
            print("TV Shows:", tvShows)
        case .failure(let error):
            print("Error fetching TV series:", error)
        default: break
    }
}

// Fetch video URL from the API
let videoURL = "https://vww.123-movies.com/episode/vikings-1x1/watching.html"
apiClient.getVideoURL(for: videoURL) { result in
    switch result {
        case .success(let url):
            print("Video URL:", url)
        case .failure(let error):
            print("Error fetching video URL:", error)
        default: break
    }
}
