//
//  FavoriteCell.swift
//  Podcast
//
//  Created by Oscar Victoria Gonzalez  on 12/17/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

@IBOutlet weak var favoriteImageView: UIImageView!
@IBOutlet weak var collectionNameLabel: UILabel!
@IBOutlet weak var name: UILabel!

    func configured(for podcast: Podcast) {
        collectionNameLabel.text = podcast.collectionName
        name.text = podcast.favoritedBy
        favoriteImageView.getImage(with: podcast.artworkUrl600) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("app error \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.favoriteImageView.image = image
                }
                
            }
        }
    }
 
}

