//
//  Episodes.swift
//  RickAndMortyAPI
//
//  Created by Mikhail Egorov on 02.03.2023.
//

import UIKit

class Episodes: UITableViewController {

    var character: Character!
    var episodes: [Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        tableView.backgroundColor = UIColor(
            red: 21/255,
            green: 32/255,
            blue: 66/255,
            alpha: 1
        )
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 32/255,
            blue: 66/255,
            alpha: 0.7
        )
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.barTintColor = .white
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        character.episode.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodesCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let episodeURL = character.episode[indexPath.row]
        content.textProperties.color = .white
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 18)
        NetworkManager.shared.fetch(Episode.self, from: episodeURL) { [weak self] result in
            switch result {
            case .success(let episode):
                self?.episodes.append(episode)
                content.text = episode.name
                cell.contentConfiguration = content
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        performSegue(withIdentifier: "episodesSegue", sender: episode)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let episodeDetailsVC = segue.destination as! EpisodesDetailsViewController
        episodeDetailsVC.episode = sender as? Episode
    }
}
