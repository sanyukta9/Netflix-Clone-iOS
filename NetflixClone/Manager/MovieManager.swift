//    
//      MovieManager.swift
//      NetflixClone
//    
//      Created by Sanyukta Adhate on 06/02/26.
//    
//    urlString = https://api.themoviedb.org/3/trending/movie/day?api_key=9a7a83ab6ed564c44e09ef91526db920
//    We using CompletionHandlers here instead of Delegates. Fn that pass as a parameter to another Fn.
//    As we have categories array we hv to extract results from different endpoints

import UIKit

class MovieManager {
        //Singelton Pattern
    static let shared = MovieManager()
    private init() {}
    
        //fetches movies from TMDB API
        //App -> URLSession -> TMDB Server
        //App <- JSON Data <- TMDB Server
    
        //MARK: - Movie Data
    
        //@escaping - Fn can be called after fetchMovies returns
    func fetchMovies(urlString: String, completion: @escaping ([Results]?) -> Void) {
            //1. Create a URL from a string
        guard let url = URL(string: urlString) else { print("Invalid URL"); completion(nil); return }
            //2. URL session which brings data from internet server. DataTask sends async req on BG thread
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
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

    //MARK: - Load image from URL

extension UIImageView {
    func loadImage(from urlString: String) {
            //1. Create a URL from a string
        guard let url = URL(string: urlString) else { image = UIImage(systemName: "photo"); return }
            //2. URL session which brings image from internet server. DataTask sends async req on BG thread
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response , error in
            guard let data, let image = UIImage(data: data) else { return }
                //3. Update UI on main thread
            DispatchQueue.main.async {
                self?.image = image
            }
        }
            //4. Start the task (without this req never starts)
        task.resume()
    }
}
