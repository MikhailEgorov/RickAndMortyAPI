//
//  EpisodesDetailsViewController.swift
//  RickAndMortyAPI
//
//  Created by Mikhail Egorov on 02.03.2023.
//

import UIKit

class EpisodesDetailsViewController: UITableViewController {
    
    @IBOutlet var descriptionEpisodeLabel: UILabel!
    
    var episode: Episode!
    var characters: [Character] = [] {
        didSet {
            if characters.count == episode.characters.count {
                characters = characters.sorted { $0.id < $1.id }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCharacter()
        tableView.backgroundColor = UIColor(
            red: 21/255,
            green: 32/255,
            blue: 66/255,
            alpha: 1
        )
        descriptionEpisodeLabel.text = episode.description
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //guard let indexPath = tableView.indexPathForSelectedRow else { return }
        //let character = episode.characters[indexPath.row]
        guard let detailVC = segue.destination as? CharacterDetailsViewController else {return}
        detailVC.character = sender as? Character
    }
    
    private func setCharacter() {
        episode.characters.forEach { characterURL in
            NetworkManager.shared.fetch(Character.self, from: characterURL) { [weak self] result in
                switch result {
                case .success(let character):
                    self?.characters.append(character)
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        episode.characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterTableVCCell", for: indexPath) as! CharacterTableViewCell
        let episodeCharacter = episode.characters[indexPath.row]
        //cell.configure(with: episodeCharacter)
        NetworkManager.shared.fetch(Character.self, from: episodeCharacter) { result in
            switch result {
            case .success(let character):
                cell.configure(with: character)
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        performSegue(withIdentifier: "episidesDetailsSegue", sender: character)
        
    }

}
