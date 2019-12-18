//
//  PodcastDVC.swift
//  Podcast
//
//  Created by Oscar Victoria Gonzalez  on 12/16/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class PodcastDVC: UIViewController {
    
    var podcast: Podcast?
    var firstSegue = Bool()
    var favoritesPodcast: Podcast?
    
    var name: String?
    
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNumberLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    func updateUI() {
        if firstSegue {
//            favoriteButton.isEnabled = true
            guard let podcast = podcast else {
                fatalError("could not find podcast. Check model,")
            }
            collectionNameLabel.text = podcast.collectionName
            artistNameLabel.text = podcast.artistName
            trackNumberLabel.text = podcast.trackId.description
            //        genresLabel.text = podcast.genres[0]
            podcastImageView.getImage(with: podcast.artworkUrl600) { (result) in
                switch result {
                case .failure(let appError):
                    print("app error \(appError)")
                case .success(let image):
                    DispatchQueue.main.async {
                        self.podcastImageView.image = image
                    }
                }
            }
        } else {
//            favoriteButton.isEnabled = false
//            favoriteButton.isHidden = true
            guard let podcast = podcast else {
                fatalError("could not find podcast. Check model,")
            }
            
            FavoritesAPIClient.theFavorites(trackId: podcast.trackId) { (result) in
                switch result {
                case .failure(let error):
                    print("error \(error)")
                case .success(let podcasts):
                    DispatchQueue.main.async {
                        self.artistNameLabel.text = podcasts.artistName
                        self.collectionNameLabel.text = podcasts.collectionName
                        self.podcastImageView.getImage(with: podcasts.artworkUrl600) { (result) in
                            switch result {
                            case .failure(let error):
                                print("error \(error)")
                            case .success(let image):
                                DispatchQueue.main.async {
                                    self.podcastImageView.image = image
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        
        print("button pressed")
        
        guard let somePodcast = favoritesPodcast else {
            fatalError()
        }
        
        let favPodcast = Podcast(trackId: somePodcast.trackId, artistName: somePodcast.artistName, collectionName: somePodcast.collectionName, trackName: somePodcast.trackName, artworkUrl600: somePodcast.artworkUrl600, trackCount: somePodcast.trackCount, favoritedBy: "Oscar")
        
        PodcastAPIClient.postPodcast(podcast: favPodcast) { (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success:
                print("Success")
            }
        }
    }
    
    
    
    
}


