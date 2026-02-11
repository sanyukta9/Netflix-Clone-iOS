//
//  Results.swift
//  NetflixClone
//
//  Created by Sanyukta Adhate on 06/02/26.
//

struct Results: Codable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    //computed property
    //https://image.tmdb.org/t/p/w500/wDWwtvkRRlgTiUr6TyLSMX8FCuZ.jpg
    var posterURL: String? {
        guard let posterPath = poster_path else { return nil }
        return Constants().imageBaseURL + posterPath
    }
}
