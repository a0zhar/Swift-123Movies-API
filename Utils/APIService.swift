//
// ---------------------------------------------------------------------
// A Swift/Objective-C 123Movies Streaming Site API Implementation
// Made by A0ZHAR (https://github.com/a0zhar)
// Intended to work for TvOS and IOS Apps
// ---------------------------------------------------------------------
//
import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = "https://vww.123-movies.com"

    func getVideoURL(from endpoint: String, completion: @escaping (URL?) -> Void) {
        let url = URL(string: baseURL + endpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching video URL: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let videoData = json["data"] as? [String: Any],
                   let videoURLString = videoData["video"] as? String,
                   let videoURL = URL(string: videoURLString) {
                    completion(videoURL)
                } else {
                    completion(nil)
                }
            } catch {
                print("JSON parsing error: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
