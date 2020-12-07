//
//  SearchResult.swift
//  ForaSoftTestTaskIOS
//
//  Created by Artem on 05.12.2020.
//  Copyright © 2020 Artem P. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
        
    var artistName: String
    var collectionId: Int
    var collectionName: String
    var collectionType: String?
    let artworkUrl100: String
    let trackCount: Int
    let trackName: String?
    let primaryGenreName: String
    let copyright: String?

}
