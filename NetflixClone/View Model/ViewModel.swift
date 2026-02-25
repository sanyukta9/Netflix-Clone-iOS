//
//  ViewModel.swift
//  NetflixClone
//
//  Created by Sanyukta Adhate on 25/02/26.
//
import Foundation

class ViewModel {
        //MARK: - Fetch Movies
    
    let categories: [String] = ["Now Playing", "Trending Now", "Popular Shows", "Top Rated", "Recommended For You"]
        // Store movies for each category
    private(set) var moviesForCategories: [[Results]] = [[], [], [], [], []]
    
        //MARK: - MVVM Bindings. VC tells.
    var isMoviesUpdated : (() -> ())?
    var isError: ((String) -> (Void))?
    
        //MARK: - Computed Properties
    var categoriesCount: Int { categories.count }
    func movies(at index: Int) -> [Results] { return moviesForCategories[index] }
    func categoryTitle(at index: Int) -> String { return categories[index] }
    
        //MARK: - Business logic
    func fetchAllMovies(){
        let endpoints = [
            Constants.baseURL + Constants.nowPlaying + "?api_key=" + Constants.apiKey,
            Constants.baseURL + Constants.trendingNow + "?api_key=" + Constants.apiKey,
            Constants.baseURL + Constants.popularShows + "?api_key=" + Constants.apiKey,
            Constants.baseURL + Constants.topRated + "?api_key=" + Constants.apiKey,
            Constants.baseURL + Constants.recommendedForYou + "?api_key=" + Constants.apiKey
        ]
        
            //fetch movie for each category
        let group = DispatchGroup()
        for(index, endpoint) in endpoints.enumerated() {
            group.enter()
            MovieManager.shared.fetchMovies(urlString: endpoint) { [weak self] response in
                DispatchQueue.main.async { [weak self] in
                    defer { group.leave() }   // run no matter what
                    guard let self else { return }
                    if let movies = response {
                        self.moviesForCategories[index] = movies
                    } else {
                        self.isError?("Failed to load category \(index)")
                    }
                }
            }
        }
            // Reload table view on the MAIN thread
        group.notify(queue: .main) { [weak self] in
            self?.isMoviesUpdated?()
        }
    }
}
