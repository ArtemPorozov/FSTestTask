//
//  AlbumDetailsController.swift
//  ForaSoftTestTaskIOS
//
//  Created by Artem on 05.12.2020.
//  Copyright © 2020 Artem P. All rights reserved.
//

import UIKit
import SDWebImage

final class AlbumDetailsController: BaseListController {
            
    // MARK: - Private Properties

    private let collectionId: Int
    private var songs = [Result]()
    
    private let detailCellId = "detailCellId"
    private let headerId = "headerId"
    private let footerId = "footerId"
    
    // MARK: - Initializers

    // dependency injection constructor
    init(collectionId: Int) {
        self.collectionId = collectionId
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        setupViews()
        fetchData()
    }
    
    // MARK: - Private Methods
    
    private func registerCells() {
        collectionView.register(AlbumDetailsCell.self, forCellWithReuseIdentifier: detailCellId)
        collectionView.register(AlbumHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(AlbumFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
    }
    
    private func setupViews() {
        collectionView.backgroundColor = .white
    }
    
    private func fetchData() {
                        
        Service.shared.fetchSongs(collectionId: collectionId) { (result, error) in
            
            if error != nil {
                print("Failed to fetch albums:", error?.localizedDescription as Any)
                return
            }
            
            self.songs = result?.results ?? []
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }

    // MARK: - Collection View Data Source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count - 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AlbumDetailsCell
        cell.song = self.songs[indexPath.item + 1]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AlbumHeader
            header.song = songs.first
            return header
            
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath) as! AlbumFooter
            footer.song = songs.first
            return footer
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
}


extension AlbumDetailsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // header and footer

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 48)
    }
    
}
