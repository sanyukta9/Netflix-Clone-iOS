//
//  CategoryTableViewCell.swift
//  NetflixClone
//
//  Created by Sanyukta Adhate on 05/02/26.
//
import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Store the movies for this category
    var movies: [Results] = [] {
        didSet {
            // reload the collection view once movies stored
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //table view cell background
        backgroundColor = .black
        contentView.backgroundColor = .black
        
        //label style
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        //layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        
        //collection view | register programmatic cell - posterImage
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            MovieCollectionViewCell.self,
            forCellWithReuseIdentifier: "MovieCollectionViewCell"
        )
        
    }
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MovieCollectionViewCell",
            for: indexPath
        ) as? MovieCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        // Get the movie for this cell
        let movie = movies[indexPath.item]
        // Load the poster image
        if let posterURL = movie.posterURL {
            cell.loadImage(from: posterURL)
        }
        cell.backgroundColor = .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: collectionView.frame.height - 20)
    }
}
