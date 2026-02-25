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

class MovieCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Image UI
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false /// will set using autolayout APIs
        return imageView
    }()
    
    
    //MARK: - Init
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
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    func configure(with movie: Results) {
        if let url = movie.posterURL {
            posterImageView.loadImage(from: url)
        } else {
            posterImageView.image = UIImage(systemName: "photo")
        }
    }
    
    //MARK: - Resuse
    // Reset cell when it's being reused
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        posterImageView.backgroundColor = .systemGray
    }
    
    //MARK: - Layout
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Pin to all edges of contentView
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
