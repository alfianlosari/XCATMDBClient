# Getting Started with MovieStore

Fetch and search movies from TMBD API 

## Overview

With MovieStore, you can fetch list of movies based on a ``MovieListEndpoint``, fetch a ``Movie`` metadata passing and `id`, and search movies related to query keywords.

``MovieStore`` uses the new `Async/Await` concurrency in Swift 5.5 to perform the fetch data operation from TMDB API. Make sure to invoke one of the public method in an async context.

## Initialization

To fetch data from TMDB API, you need to initialize ``MovieStore`` passing the API key parameter which you can get from [TMDB API](https://tmdb.org)

```swift
let movieStore = MovieStore(apiKey: "YOUR_API_KEY")
```

## Fetching List of Movies From an Endpoint

To fetch list of movies, you need to pass the ``MovieListEndpoint`` instance to the ``MovieStore/fetchMovies(from:)`` method. 
```swift
// switch to an async task if you are in sync context
Task {
    do {
        let nowPlayingMovies = await movieStore.fetchMovies(from: .nowPlaying)
    } catch {
        print(error.localizedDescription)
    }
}
```

## Fetch A Movie Passing an ID 

To fetch a movie, you need to pass the integer value of `id` to the ``MovieStore/fetchMovie(id:)`` method.

In this example, we pass `238` which is the id of [The Godafther Part 1](https://www.themoviedb.org/movie/238-the-godfather) in TMDB. 
```swift
// switch to an async task if you are in sync context
Task {
    do {
        let theGodfatherPartOne = await movieStore.fetchMovie(id: 238)
    } catch {
        print(error.localizedDescription)
    }
}
```

## Search Movies Passing Query Text

To search list of movies related to a keywords, you can use ``MovieStore/searchMovie(query:)`` method passing the `query`. 

In this example, we pass `Avengers`. The returned list can contain movies containing `Avengers` in title (e.g Age of Ultron, Infinity War, Endgame)
```swift
// switch to an async task if you are in sync context
Task {
    do {
        let avengers = await movieStore.searchMovie(query: "Avengers")
    } catch {
        print(error.localizedDescription)
    }
}
```
