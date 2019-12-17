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
    
    var name: String?
    
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNumberLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    func updateUI() {
        guard let podcast = podcast else {
            fatalError("could not find podcast. Check model,")
        }
        collectionNameLabel.text = podcast.collectionName
        artistNameLabel.text = podcast.artistName
        trackNumberLabel.text = podcast.trackId.description
        genresLabel.text = podcast.genres[0]
        podcastImageView.getImage(with: podcast.artworkUrl60) { (result) in
            switch result {
            case .failure(let appError):
                print("app error \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.podcastImageView.image = image
                }
            }
        }
    }
    
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        
        print("button pressed")
        
        guard let somePodcast = podcast else {
            fatalError()
        }

//        guard let trackId = trackNumberLabel,
//            let podcast = podcast,
//            let collectionName = collectionNameLabel,
//            let artworkUrl600 = podcastImageView else {
//                return
//        }
        
        
        let favPodcast = FavoritePodcast(trackId: somePodcast.trackId, favoritedBy: "Oscar", collectionName: somePodcast.collectionName, artworkUrl600: somePodcast.artworkUrl60)
        
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


