//
//  Constants.swift
//  NetflixClone
//
//  Created by Sanyukta Adhate on 06/02/26.
//

struct Constants {
    static let apiKey = "9a7a83ab6ed564c44e09ef91526db920"
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    //MARK: - API endpoints
    static let nowPlaying = "/movie/now_playing"
    static let trendingNow = "/trending/movie/day"
    static let popularShows = "/movie/popular"
    static let topRated = "/movie/top_rated"
    static let recommendedForYou = "/movie/upcoming"
}
