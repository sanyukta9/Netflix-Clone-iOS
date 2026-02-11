//
//  ViewController.swift
//  NetflixClone
//
//  Created by Sanyukta Adhate on 05/02/26.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    let movieManager = MovieManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.backgroundColor = .black
        view.backgroundColor = .black
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        fetchAllMovies()
    }
    
    
    //MARK: - Fetch Movies
    
    let categories: [String] = ["Now Playing", "Trending Now", "Popular Shows", "Top Rated", "Recommended For You"]
        // Store movies for each category
    var moviesForCategories: [[Results]] = [[], [], [], [], []]
    
    
    func fetchAllMovies(){
        let endpoints = [
            Constants().baseURL + Constants().nowPlaying + "?api_key=" + Constants().apiKey,
            Constants().baseURL + Constants().trendingNow + "?api_key=" + Constants().apiKey,
            Constants().baseURL + Constants().popularShows + "?api_key=" + Constants().apiKey,
            Constants().baseURL + Constants().topRated + "?api_key=" + Constants().apiKey,
            Constants().baseURL + Constants().recommendedForYou + "?api_key=" + Constants().apiKey
        ]
        
        //fetch movie for each category
        for(index, endpoint) in endpoints.enumerated() {
            movieManager.fetchMovies(urlString: endpoint) { [weak self] movies in
                guard let self = self else { return }
                    // Store movies in the correct category index
                if let movies = movies {
                    self.moviesForCategories[index] = movies
                    
                        // Reload table view on the MAIN thread
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Y dequeueResusableCell: let cell = UITableViewCell() new scroll new cell, instead resuse old cell
        //set titleLabel for each cell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CategoryTableViewCell",
            for: indexPath
        ) as! CategoryTableViewCell
        cell.label.text = categories[indexPath.row]
        cell.backgroundColor = .black
        cell.movies = moviesForCategories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}
