# Getting Started with Movie Store

Fetch and search movies from TMDB API

## Overview

With ``MovieStore``, you can fetch list of movies based on ``MovieListEndpoint``.

## Fetching List of Movies from an Endpoint

To fetch list of movies, you need to pass ``MovieListEndpoint`` instance to the ``MovieStore/fetchMovies(from:)`` method.

```swift
// Switch to an async task if you are in sync context
Task {
    do {
        let nowPlayingMovies = await movieStore.fetchMovies(from: .nowPlaying)
    } catch {
        print(error.localizedDescription)
    }
}
```

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
