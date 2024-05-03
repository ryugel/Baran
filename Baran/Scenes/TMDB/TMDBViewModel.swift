//
//  TMDBViewModel.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

import Foundation
import Combine

class TMDBViewModel: ObservableObject {
    @Published var trendings: [TMDB] = []
    @Published var topRated: [TMDB] = []
    @Published var popular: [TMDB] = []
    @Published var upcoming: [TMDB] = []
    @Published var airing: [TMDB] = []
    private var cancellables: Set<AnyCancellable> = []

    func fetchTMDBData(tmdbUrl: TMDBURL) {

        guard let url = tmdbUrl.url else {
                  print("Invalid URL for : \(tmdbUrl)")
                  return
              }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: TMDBMResponse.self, decoder: JSONDecoder())
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] tmdb in
                switch tmdbUrl {
                case .trending:
                    self?.trendings = tmdb
                case .topRated:
                    self?.topRated = tmdb
                case .popular:
                    self?.popular = tmdb
                case .upcoming:
                    self?.upcoming = tmdb
                case .airing:
                    self?.airing = tmdb
                }
            })
            .store(in: &cancellables)
    }

}
enum TMDBURL {
    case trending
    case topRated
    case popular
    case upcoming
    case airing

    private var apiKey: String {
        guard let apiKey = ProcessInfo.processInfo.environment["MOVIEDB_API_KEY"] else {
            return "API key not set. Please set the MOVIEDB_API_KEY environment variable."
        }
        return apiKey
    }

    var url: URL? {
        var urlString: String
        switch self {
        case .trending:
            urlString = "https://api.themoviedb.org/3/trending/movie/week?api_key=\(apiKey)"
        case .topRated:
            urlString = "https://api.themoviedb.org/3/tv/top_rated?api_key=\(apiKey)"
        case .popular:
            urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
        case .upcoming:
            urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)"
        case .airing:
             urlString = "https://api.themoviedb.org/3/tv/on_the_air?api_key=\(apiKey)"
        }
        return URL(string: urlString)
    }

}

class YoutubeViewModel: ObservableObject {
    @Published  var trailers: [YouTubeItem] = []
    private var cancellables: Set<AnyCancellable> = []
    private var apiKey: String {
        guard let apiKey = ProcessInfo.processInfo.environment["YOUTUBE_API_KEY"] else {
            return "API key not set. Please set the Youtube_API_KEY environment variable."
        }
        return apiKey
    }

    func fetchTrailer(query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "https://youtube.googleapis.com/youtube/v3/search?q=\(query)&key=\(apiKey)") else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: YouTubeData.self, decoder: JSONDecoder())
            .map(\.items)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
                    print("Failure: \(failure)")
                }
            }, receiveValue: { [weak self] item in
                if let firstTrailer = item.first {
                                   self?.trailers = [firstTrailer]
                               } else {
                                   print("No trailers found.")
                               }
            })
            .store(in: &cancellables)

    }
}
