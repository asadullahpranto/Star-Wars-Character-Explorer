//
//  CardViewCell.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 4/5/24.
//

import UIKit

class CardViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    func configure(with starship: Starship) {
        nameLabel.text = starship.name
        modelLabel.text = "Model: " + starship.model
    }

}
