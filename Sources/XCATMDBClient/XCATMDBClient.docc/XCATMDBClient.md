# ``XCATMDBClient``

Get the latest movie updates and information from TMDB API

## Overview

This framework provides models and service for retrieving movies from TMDB API. The ``Movie`` model is a representation of a movie containing metadata such as title, overview, casts that you can use to display using the provided `View` components.

![XCA Movies UI.](overview.png)

With ``MovieStore`` you can fetch list of movies based from different endpoints such as now playing, upcoming, top rated, and popular movies.


## Topics

### Essentials
- <doc:Fetching-Movies>
- <doc:Displaying-Movies>

### Movie UI
- ``MoviePosterView``
- ``MovieBackdropView``

### Service
- ``MovieStore``

### Models
- ``Movie``
- ``MovieCast``
- ``MovieCrew``
- ``MovieGenre``
- ``MovieVideo``
