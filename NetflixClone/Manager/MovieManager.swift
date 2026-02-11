//
//  MovieManager.swift
//  NetflixClone
//
//  Created by Sanyukta Adhate on 06/02/26.
//
///urlString = https://api.themoviedb.org/3/trending/movie/day?api_key=9a7a83ab6ed564c44e09ef91526db920
//We using CompletionHandlers here instead of Delegates. Fn that pass as a parameter to another Fn.
//As we have categories array we hv to extract results from different endpoints

import Foundation

class MovieManager {
    
    //fetches movies from TMDB API
    //App -> URLSession -> TMDB Server
    //App <- JSON Data <- TMDB Server
    
    //@escaping - Fn can be called after fetchMovies returns
    func fetchMovies(urlString: String, completion: @escaping ([Results]?) -> Void) {
        let urlString = urlString
        //1. Create a URL from a string
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        //2. Create a URLSession
        let session = URLSession(configuration: .default)
        //3. Give URL session a task to fetch data from the Server (asynchronous)
        let task = session.dataTask(with: url) { (data, response, error) in

        guard let safeData = data, error == nil else { print("No Data Received"); return }
        //4. Parse the JSON data into swift objects
            if let parsedMovies = self.parseJSONData(safeData) {
                print("Successfully fetched \(parsedMovies.count) movies from: \(urlString)")
                completion(parsedMovies)
            }
            else{
                completion(nil)
            }
        }
        //5. Start the task
        task.resume()
    }
    
    func parseJSONData(_ movieData: Data) -> [Results]?{
        do {
            let decodedData = try JSONDecoder().decode(TMDBResponse.self, from: movieData)

//            print("page: \(decodedData.page)")
//            print("total_pages: \(decodedData.total_pages)")
//            print("total_results: \(decodedData.total_results)")
//            if let first = decodedData.results.first {
//                print("first.id: \(first.id)")
//                print("first.overview: \(first.overview)")
//                print("first.posterURL: \(first.posterURL!)")
//                print("first.poster_path: \(first.poster_path!)")
//                print("first.title: \(first.title)")
//            }
            return decodedData.results
        } catch {
            print("Failed to parse JSON: \(error)")
            return nil
        }
    }
}
