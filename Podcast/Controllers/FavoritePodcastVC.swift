//
//  FavoritePodcastVC.swift
//  Podcast
//
//  Created by Oscar Victoria Gonzalez  on 12/16/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class FavoritePodcastVC: UIViewController {
    
@IBOutlet weak var tableView: UITableView!
    
    var favorites = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadFavorites()
    }
    
    func loadFavorites() {
        PodcastAPIClient.getFavorites { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("app error \(appError)")
            case .success(let podcast):
                DispatchQueue.main.async {
                    self?.favorites = podcast.filter{$0.favoritedBy == "Oscar"}
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let podcastDVC = segue.destination as? PodcastDVC,
            let indexPath = tableView.indexPathForSelectedRow else {
                fatalError("error")
        }
        let podcast = favorites[indexPath.row]
        podcastDVC.podcast = podcast
        podcastDVC.firstSegue = false
    }
    
}

extension FavoritePodcastVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteCell else {
            fatalError("error")
        }
        let podcast = favorites[indexPath.row]
        cell.configured(for: podcast)
        return cell
    }
}

extension FavoritePodcastVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
