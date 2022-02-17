//
//  SwiftUIView.swift
//  
//
//  Created by Alfian Losari on 13/02/22.
//


import SwiftUI

public struct MovieBackdropView: View {
    public let movie: Movie
    
    public init(movie: Movie) {
        self.movie = movie
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            imageView
            Text(movie.title)
                .font(.headline)
                .lineLimit(1)
            Text(movie.yearText)
            Text(movie.durationText)

            Text(movie.ratingText)
                .foregroundColor(.yellow)
        }
        .frame(width: 200, height: 226)
    }
    
    private var imageView: some View {
        ZStack {
            Color.gray.opacity(0.3)
            
            Text(movie.title)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .lineLimit(4)
            
            AsyncImage(url: movie.backdropURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .failure:
                    Text("😵‍💫")
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(16/9, contentMode: .fit)

                        .layoutPriority(-1)
                @unknown default:
                    fatalError()
                }
            }
          
        }
        .cornerRadius(8)
        .shadow(radius: 4)
        
    }
}
