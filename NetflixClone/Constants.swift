//
//  Constants.swift
//  NetflixClone
//
//  Created by Sanyukta Adhate on 06/02/26.
//

struct Constants {
    let apiKey = "9a7a83ab6ed564c44e09ef91526db920"
    let baseURL = "https://api.themoviedb.org/3"
    let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    //MARK: - API endpoints
    let nowPlaying = "/movie/now_playing"
    let trendingNow = "/trending/movie/day"
    let popularShows = "/movie/popular"
    let topRated = "/movie/top_rated"
    let recommendedForYou = "/movie/upcoming"
}
