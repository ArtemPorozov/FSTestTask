//
//  SearchResultCell.swift
//  ForaSoftTestTaskIOS
//
//  Created by Artem on 05.12.2020.
//  Copyright © 2020 Artem P. All rights reserved.
//

import UIKit

final class SearchResultCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    var album: Result? {
        didSet {
            nameLabel.text = album?.collectionName
            if let albumUrl = album?.artworkUrl100 {
                imageView.sd_setImage(with: URL(string: albumUrl))
            }
            subtitleLabel.text = "\(album!.collectionType!) • \(album!.artistName)"
        }
    }
    
    // MARK: - Private Properties

    private let imageView = UIImageView(cornerRadius: 4)
    private let nameLabel = UILabel(text: "Album Name", font: .boldSystemFont(ofSize: 18))
    private let subtitleLabel = UILabel(text: "Subtitle Label", font: .systemFont(ofSize: 16), numberOfLines: 2)
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(white: 0.3, alpha: 0.3)
        return view
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        
        imageView.constrainWidth(constant: 100)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubviews: [
                nameLabel, subtitleLabel
            ], spacing: 4)
        ])
        stackView.spacing = 16
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
        addSubview(separatorView)
        separatorView.anchor(top: nil, leading: stackView.leadingAnchor, bottom: self.bottomAnchor, trailing: stackView.trailingAnchor)
        separatorView.constrainHeight(constant: 0.5)
    }
    
}
