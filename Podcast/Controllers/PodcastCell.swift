//
//  PodcastCell.swift
//  Podcast
//
//  Created by Oscar Victoria Gonzalez  on 12/16/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {
    
@IBOutlet weak var podcastImageView: UIImageView!
@IBOutlet weak var podcastNameLabel:UILabel!
@IBOutlet weak var artistNameLabel: UILabel!
    
    func configured(for podcast: Podcast) {
        podcastNameLabel.text = podcast.collectionName
        artistNameLabel.text = podcast.artistName
        podcastImageView.getImage(with: podcast.artworkUrl100) { (result) in
            switch result {
            case .failure(let error):
                print("\(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.podcastImageView.image = image
                }
            }
        }
    }
    
    
}
