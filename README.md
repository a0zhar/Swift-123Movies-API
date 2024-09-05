# Swift-Based 123Movies API

If you've been searching for a 123Movies API to use in iOS or tvOS applications but couldn't find one, this project might be what you need. This API is inspired by ChrisMichaelPerezSantiago's [JavaScript API for 123Movies](https://github.com/ChrisMichaelPerezSantiago/123-movies) and is my attempt at recreating it using Swift (and possibly Objective-C).

The goal of this project is to provide developers with an easy-to-use API that can be integrated into Xcode projects, allowing them to build their own movie apps without starting from scratch.

## Purpose
This API is designed to simplify the process of creating movie applications by providing pre-built functionality for fetching video URLs from 123Movies. It's specifically tailored for use in iOS and tvOS apps developed with Xcode.

## Example Usage

Here's a basic example of how you can use this API in your Swift project.
In this example, a button fetches a video URL using the API service and, if successful, displays the video in a player:

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


## Credits
- [A0ZHAR](https://github.com/a0zhar) for Porting/Recreating the API using Swift
- [ChrisMichaelPerezSantiago](https://github.com/ChrisMichaelPerezSantiago) For Creating the JS Api 