//
//  Service.swift
//  ForaSoftTestTaskIOS
//
//  Created by Artem on 05.12.2020.
//  Copyright © 2020 Artem P. All rights reserved.
//

import Foundation

class Service {
    
     // singleton
    static let shared = Service()
    
    private init() {}
    
    func fetchAlbums(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=album"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchSongs(collectionId: Int, completion: @escaping (SearchResult?, Error?) -> ()) {
        
        let urlString = "https://itunes.apple.com/lookup?id=\(collectionId)&entity=song"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }

    // add response
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                completion(nil, error)
                print(error as Any)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                
                completion(objects, nil)
                
            } catch let jsonError {
                completion(nil, jsonError)
            }
        }.resume()
    }
    
}
