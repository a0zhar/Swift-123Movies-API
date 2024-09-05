//
// ---------------------------------------------------------------------
// A Swift/Objective-C 123Movies Streaming Site API Implementation
// Made by A0ZHAR (https://github.com/a0zhar)
// Intended to work for TvOS and IOS Apps
// ---------------------------------------------------------------------
//

import Foundation
import SwiftSoup

class APIManager {
    static let shared = APIManager()
    private let baseURL = "https://vww.123-movies.com"

    private init() {}

    // Fetch movies list from a given page
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/movies?page=\(page)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let html = String(data: data, encoding: .utf8) else {
                completion(.failure(NSError(domain: "DataError", code: 0, userInfo: nil)))
                return
            }

            do {
                let movies = try self.parseMovies(html: html)
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // Parse HTML to extract movies
    private func parseMovies(html: String) throws -> [Movie] {
        let document = try SwiftSoup.parse(html)
        var movies: [Movie] = []

        let elements = try document.select("div.videosContainer div.featuredItems")
        for element in elements {
            let id = try element.select("a").attr("href") + "watching.html"
            let title = try element.select("span.mli-info h2").text()
            let poster = try element.select("img.lazy").attr("src")
            let imdbScoreText = try element.select("div.jtip-top div.jt-info.jt-imdb").text()
            let imdbScore = Float(imdbScoreText) ?? 0.0
            let year = try element.select("div.jtip-top div.jt-info").eq(1).text()
            let episodeLength = try element.select("div.jtip-top div.jt-info").eq(2).text()
            let quality = try element.select("a span.mli-quality").text().trimmingCharacters(in: .whitespaces)
            let genres = try element.select("div.block").eq(1).select("a").map { try $0.attr("href").split(separator: "/")[4] }

            let movie = Movie(id: id, title: title, poster: poster, description: "", imdbScore: imdbScore, genres: genres, year: year, episodeLength: episodeLength, quality: quality)
            movies.append(movie)
        }

        return movies
    }

    // Fetch video URL
    func getVideoURL(from url: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let html = String(data: data, encoding: .utf8) else {
                completion(.failure(NSError(domain: "DataError", code: 0, userInfo: nil)))
                return
            }

            do {
                let document = try SwiftSoup.parse(html)
                let iframeSrc = try document.select("iframe").first()?.attr("src") ?? ""

                self.getIframeVideoURL(from: iframeSrc) { result in
                    switch result {
                    case .success(let videoURL):
                        completion(.success(videoURL))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // Fetch the actual video URL from the iframe
    private func getIframeVideoURL(from url: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let html = String(data: data, encoding: .utf8) else {
                completion(.failure(NSError(domain: "DataError", code: 0, userInfo: nil)))
                return
            }

            do {
                let document = try SwiftSoup.parse(html)
                let scripts = try document.select("script")
                
                for script in scripts {
                    let contents = try script.html()
                    if contents.contains("sources") {
                        let urls = self.extractUrls(from: contents)
                        let mp4Url = urls.first { $0.contains(".mp4") }
                        if let videoURL = mp4Url {
                            completion(.success(videoURL))
                            return
                        }
                    }
                }
                completion(.failure(NSError(domain: "VideoError", code: 0, userInfo: nil)))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // Helper to extract URLs from JavaScript content
    private func extractUrls(from text: String) -> [String] {
        var urls: [String] = []
        let urlRegex = try! NSRegularExpression(pattern: "https?://[\\w./?=&]+", options: [])
        let matches = urlRegex.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        for match in matches {
            if let range = Range(match.range, in: text) {
                urls.append(String(text[range]))
            }
        }
        return urls
    }
}
