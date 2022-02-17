# Displaying Movie in UI with Provided SwiftUI Views

Display poster or backdrop image of a movie with related information

## Overview

The framework provides 2 SwiftUI Views that you can use to display image and related information of a ``Movie``. The view contains information such as title, release year, duration, and star ratings.

## Dispaying Movie with Poster image

![movie poster UI](movie_poster.png)
To display movie with poster image, you can simply declare an instance of ``MoviePosterView`` passing a ``Movie`` in your SwiftUI View.

```swift
MoviePosterView(movie: myMovie)
```

## Dispaying Movie with Backdrop image

![movie backdrop UI](movie_backdrop.png)
To display movie with backdrop image, you can simply declare an instance of ``MovieBackdropView`` passing a ``Movie`` in your SwiftUI View.

```swift
MovieBackdropView(movie: myMovie)
```
