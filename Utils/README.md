## Example Usage
```swift
Button(action: {
    APIService.shared.getVideoURL(from: "/movie/joker-1/watching.html") { url in
        DispatchQueue.main.async {
            if let url = url {
                videoURL = url
                showPlayer = true
            } else {
                print("Failed to fetch video URL.")
            }
        }
    }
}) {
    Text("Play Video")
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(8)
}
```
