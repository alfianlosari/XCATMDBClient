# ``XCATMDBClient/Movie``

Representation of a movie

## Overview

The model provides information for amovie such as: ``title`` and ``overview``
 
Example of showing movie title and overview using SwiftUI
```swift
ForEach(movies) { movie in
    VStack {
        movie.title
        movie.overview
    }
}
```

## Topics

### Fetching movies from Movie Store

- <doc:Fetching-Movies>
