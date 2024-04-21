//
//  CharacterTableViewCell.swift
//  RickAndMortyAPI
//
//  Created by Mikhail Egorov on 04.03.2023.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    //var character: Character!
    
    
    @IBOutlet var characterImageView: CharacterImageView!
    @IBOutlet var labelView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with character: Character? ) {
        labelView.text = character?.name
        characterImageView.fetchImage(from: character?.image ?? "")
        
        /*let imageCharacter = character?.image
        ImageManager.shared.fetchImage(from: imageCharacter) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }*/
    }
}
