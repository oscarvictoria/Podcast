//
//  FavoritesAPIClient.swift
//  Podcast
//
//  Created by Oscar Victoria Gonzalez  on 12/17/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct FavoritesAPIClient {
    static func theFavorites(trackId: Int, completion: @escaping (Result <Podcast, AppError>)->()) {
        
        let endpointURLString = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(trackId.description)"
            
            guard let url = URL(string: endpointURLString) else {
                completion(.failure(.badURL(endpointURLString)))
                return
            }
            
            let request = URLRequest(url: url)
            
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    print("error \(appError)")
                case .success(let data):
                    do {
                        let podcast = try JSONDecoder().decode(ApplePodcast.self, from: data)
                        completion(.success(podcast.results.first!))
                    } catch {
                        completion(.failure(.decodingError(error)))
                    }
                }
            }
            
        }
    }



