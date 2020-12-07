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
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
        }()
    
    var albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    var genreLabel: UILabel = {
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

