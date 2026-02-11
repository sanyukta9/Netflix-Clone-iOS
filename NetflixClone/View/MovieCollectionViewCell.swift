//
//  MovieCollectionViewCell.swift
//  NetflixClone
//
//  Created by Sanyukta Adhate on 05/02/26.
//
//IS the poster -
//Not using IBOutlet for PosterImage cuz it can't copied for multiple cells.
//CollectionView needs 10 cells to display
//1st cell: Created from Storyboard → IBOutlet connected
//Cells 2-10: iOS calls dequeueReusableCell. Reused/created but IBOutlet not connected

import UIKit
import Foundation

class MovieCollectionViewCell: UICollectionViewCell {
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false /// will set using autolayout APIs
        return imageView
    }()
    
        // Called when cell is created programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
            // Add imageView to contentView
        contentView.addSubview(posterImageView)
            // make imageView fill the entire cell
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Pin to all edges of contentView
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
        // Reset cell when it's being reused
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        posterImageView.backgroundColor = .systemGray
    }
    
        //MARK: - Load image from URL
    
    func loadImage(from urlString: String) {
        //1. Create a URL from a string
        guard let url = URL(string: urlString) else { print("Invalid URL"); return }
        //2. Create a URLSession
        let session = URLSession.shared
        //3. Give URL session a task to fetch data from the Server (asynchronous)
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let safeData = data, error == nil else {
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
        //4. Parse Converts raw image data into a UIImage
        guard let image = UIImage(data: safeData) else { return }
        /// Update UI on MAIN thread
            DispatchQueue.main.async {
                self?.posterImageView.image = image
                self?.posterImageView.backgroundColor = .clear
            }
        }
        //5. Start the task
        task.resume()
    }
}
