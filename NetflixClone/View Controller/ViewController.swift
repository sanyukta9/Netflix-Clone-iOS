//
//  ViewController.swift
//  NetflixClone
//
//  Created by Sanyukta Adhate on 05/02/26.
//

import UIKit

class ViewController: UIViewController {
    private let viewModel = ViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupTableView()
        setupBindings()
        viewModel.fetchAllMovies()
    }
    
    func setupTableView() {
        tableView.backgroundColor = .black
        view.backgroundColor = .black
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupBindings() {
        viewModel.isMoviesUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.isError = { message in
            print("Error: \(message)")
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categoriesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Y dequeueResusableCell: let cell = UITableViewCell() new scroll new cell, instead resuse old cell
        //set titleLabel for each cell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CategoryTableViewCell",
            for: indexPath
        ) as! CategoryTableViewCell
        
        cell.label.text = viewModel.categoryTitle(at: indexPath.row)
        cell.movies = viewModel.movies(at: indexPath.row)
        cell.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}
