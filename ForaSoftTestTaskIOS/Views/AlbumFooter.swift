//
//  AlbumFooter.swift
//  ForaSoftTestTaskIOS
//
//  Created by Artem on 06.12.2020.
//  Copyright © 2020 Artem P. All rights reserved.
//

import UIKit

final class AlbumFooter: UICollectionReusableView {
    
    // MARK: - Public Properties
    
    var song: Result? {
        didSet {
            copyrightLabel.text = song?.copyright
        }
    }
    
    // MARK: - Private Properties

    private let copyrightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16)
        return label
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
        addSubview(copyrightLabel)
        copyrightLabel.anchor(top: self.topAnchor,
                              leading: self.leadingAnchor,
                              bottom: nil,
                              trailing: nil,
                              padding: .init(top: 4, left: 16, bottom: 0, right: 0),
                              size: .init(width: 400, height: 32))
    }
    
}
