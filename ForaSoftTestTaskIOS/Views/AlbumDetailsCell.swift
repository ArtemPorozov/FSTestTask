//
//  AlbumDetailsCell.swift
//  ForaSoftTestTaskIOS
//
//  Created by Artem on 05.12.2020.
//  Copyright © 2020 Artem P. All rights reserved.
//

import UIKit

final class AlbumDetailsCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    var song: Result? {
        didSet {
            if let trackNumber = song?.trackNumber {
                songNumberLabel.text = String(trackNumber)
            }
            songNameLabel.text = song?.trackName
        }
    }
    
    // MARK: - Private Properties

    private let songNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.constrainHeight(constant: 24)
        label.constrainWidth(constant: 24)
        label.backgroundColor = .white
        return label
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .left
        label.backgroundColor = .white
        return label
    }()
    
    private let stackView = UIStackView(frame: .zero)
    
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
                
        backgroundColor = .white
        
        stackView.addArrangedSubview(songNumberLabel)
        stackView.addArrangedSubview(songNameLabel)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))

        addSubview(separatorView)
        separatorView.anchor(top: nil, leading: stackView.leadingAnchor, bottom: self.bottomAnchor, trailing: stackView.trailingAnchor)
        separatorView.constrainHeight(constant: 0.5)
    }
    
}
