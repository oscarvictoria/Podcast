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
        tableView.delegate = self
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let podcastDVC = segue.destination as? PodcastDVC,
            let indexPath = tableView.indexPathForSelectedRow else {
                fatalError("error")
        }
        let podcast = podcasts[indexPath.row]
        podcastDVC.podcast = podcast
    }

}

extension PodcastVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as? PodcastCell else {
            fatalError("error")
        }
        let podcast = podcasts[indexPath.row]
        cell.configured(for: podcast)
        
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

extension PodcastVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
