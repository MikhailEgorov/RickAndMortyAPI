//
//  CharacterDetailsViewController.swift
//  RickAndMortyAPI
//
//  Created by Mikhail Egorov on 02.03.2023.
//

import UIKit

class CharacterDetailsViewController: UIViewController {

    var character: Character!
    
    @IBOutlet var detaleImageView: CharacterImageView!
    
    @IBOutlet var descritionLabel: UILabel!
    override func viewDidLoad() {
    super.viewDidLoad()
        descritionLabel.text = character.description
        detaleImageView.fetchImage(from: character.image)
        /*ImageManager.shared.fetchImage(from: self.character.image) { result in
            switch result {
            case .success(let imageData):
                self.detaleImageView.image = UIImage(data: imageData)
                print(imageData)
            case .failure(let error):
                print(error)
            }
        }*/
        
    }
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let episodesVC = (segue.destination as? UINavigationController)?.topViewController as! Episodes
        episodesVC.character = character
    }

}
