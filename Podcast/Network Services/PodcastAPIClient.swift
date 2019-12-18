//
//  PodcastAPIClient.swift
//  Podcast
//
//  Created by Oscar Victoria Gonzalez  on 12/16/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct PodcastAPIClient {
    static func getPodcast(searchQuery: String, completion: @escaping (Result <[Podcast],AppError>)->()) {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "show"
        
        let endpointURLString = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(searchQuery)"
        
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
                    let thePodcast = podcast.results
                    completion(.success(thePodcast))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
    static func postPodcast(podcast: Podcast, completion: @escaping (Result <Bool, AppError>)-> ()) {
        
        let endpointURLString = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        
        do {
            let data = try JSONEncoder().encode(podcast)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    print("app error \(appError)")
                case .success:
                    completion(.success(true))
                }
            }
        } catch {
            completion(.failure(.encodingError(error)))
        }
        
    }
    
    
    static func getFavorites(completion: @escaping (Result <[Podcast],AppError>)->()) {
        let endpointURLString = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        
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
                    let podcast = try JSONDecoder().decode([Podcast].self, from: data)
                    completion(.success(podcast))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
}
