//
// ---------------------------------------------------------------------
// A Swift/Objective-C 123Movies Streaming Site API Implementation
// Made by A0ZHAR (https://github.com/a0zhar)
// Intended to work for TvOS and IOS Apps
// ---------------------------------------------------------------------
//

import SwiftUI

struct ContentView: View {
    @State private var urlString: String = ""
    @State private var showPlayer: Bool = false
    @State private var videoURL: URL?

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter Video URL", text: $urlString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.URL)
                    .autocapitalization(.none)

                Button(action: {
                    if let url = URL(string: urlString) {
                        videoURL = url
                        showPlayer = true
                    }
                }) {
                    Text("Play Video")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .sheet(isPresented: $showPlayer) {
                if let videoURL = videoURL {
                    VideoPlayerView(url: videoURL)
                }
            }
        }
    }
}
