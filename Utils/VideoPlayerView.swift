//
// ---------------------------------------------------------------------
// A Swift/Objective-C 123Movies Streaming Site API Implementation
// Made by A0ZHAR (https://github.com/a0zhar)
// Intended to work for TvOS and IOS Apps
// ---------------------------------------------------------------------
//
import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let url: URL

    var body: some View {
        VideoPlayer(player: AVPlayer(url: url))
            .onAppear {
                // Autoplay video when view appears
                AVPlayer(url: url).play()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
