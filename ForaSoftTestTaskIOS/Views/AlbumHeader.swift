//
//  AlbumHeader.swift
//  ForaSoftTestTaskIOS
//
//  Created by Artem on 06.12.2020.
//  Copyright © 2020 Artem P. All rights reserved.
//

import UIKit

final class AlbumHeader: UICollectionReusableView {
    
    // MARK: - Public Properties
    
    var song: Result? {
        didSet {
            // grabbing hi-res quality album art
            if let albumUrl600 = song?.artworkUrl100.replacingOccurrences(of: "100x100bb", with: "600x600bb") {
                imageView.sd_setImage(with: URL(string: albumUrl600))
            }
            albumNameLabel.text = song?.collectionName
            genreLabel.text = song?.primaryGenreName
        }
    }
    
    // MARK: - Private Properties

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
        }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    
    private func setupViews() {

        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 48).isActive = true
        imageView.centerXInSuperview()
        imageView.constrainHeight(constant: 250)
        imageView.constrainWidth(constant: 250)

        
        addSubview(albumNameLabel)
        albumNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        albumNameLabel.centerXInSuperview()
        albumNameLabel.constrainHeight(constant: 32)
        albumNameLabel.constrainWidth(constant: 400)
        
        addSubview(genreLabel)
        genreLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 4).isActive = true
        genreLabel.centerXInSuperview()
        genreLabel.constrainHeight(constant: 32)
        genreLabel.constrainWidth(constant: 400)
    }
    
}

