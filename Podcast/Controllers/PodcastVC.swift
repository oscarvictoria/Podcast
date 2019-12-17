//
//  ViewController.swift
//  Podcast
//
//  Created by Oscar Victoria Gonzalez  on 12/16/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class PodcastVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var podcasts = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        loadPodcast()
    }
    
    func loadPodcast() {
        PodcastAPIClient.getPodcast(searchQuery: "swift") { (result) in
            switch result {
            case .failure(let appError):
                print("error \(appError)")
            case .success(let podcast):
                self.podcasts = podcast
            }
        }


}

}

extension PodcastVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath)
        let podcast = podcasts[indexPath.row]
        cell.textLabel?.text = podcast.collectionName
        return cell
    }
}

extension PodcastVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        PodcastAPIClient.getPodcast(searchQuery: searchText) { (result) in
                  switch result {
                  case .failure(let appError):
                      print("error \(appError)")
                  case .success(let podcast):
                      self.podcasts = podcast
                  }
              }
        
    }
}
