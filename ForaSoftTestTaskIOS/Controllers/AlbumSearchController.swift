//
//  AlbumSearchController.swift
//  ForaSoftTestTaskIOS
//
//  Created by Artem on 05.12.2020.
//  Copyright © 2020 Artem P. All rights reserved.
//

import UIKit
import SDWebImage

final class AlbumSearchController: BaseListController {
    
    // MARK: - Private Properties

    private let cellId = "cellId"
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    private let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter album name to start searching"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private var albumResults = [Result]()
    private var albumResultsSorted = [Result]()
    
    private var timer: Timer?

    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        setupViews()
        setupSearchBar()
    }
    
    // MARK: - Private Methods

    private func registerCells() {
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func setupViews() {
        collectionView.backgroundColor = .white
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 16, bottom: 0, right: 16))
        enterSearchTermLabel.centerXInSuperview()
    }

    private func setupSearchBar() {
        // read about
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    
    // MARK: - Collection View Delegate

    // perform navigation
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionId = albumResultsSorted[indexPath.item].collectionId
        let appDetailController = AlbumDetailsController(collectionId: collectionId)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    // MARK: - Collection View Data Source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        enterSearchTermLabel.isHidden = albumResultsSorted.count != 0
        return albumResultsSorted.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
//        cell.appResult = appResults[indexPath.item]
        
        let album = albumResultsSorted[indexPath.item]

        cell.nameLabel.text = album.collectionName
        cell.imageView.sd_setImage(with: URL(string: album.artworkUrl100))
        cell.subtitleLabel.text = "\(album.collectionType!) • \(album.artistName)"
        
        return cell
    }
    
}


extension AlbumSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 132)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


extension AlbumSearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
        // introduce some delay before performing the search
        // throttling the search
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            Service.shared.fetchAlbums(searchTerm: searchText) { (result, error) in
                
                if error != nil {
                    print("Failed to fetch apps:", error as Any)
                    return
                }
                
                self.albumResults = result?.results ?? []
                
                // add sorting
                self.albumResultsSorted = self.albumResults.sorted { $0.collectionName < $1.collectionName }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
}
