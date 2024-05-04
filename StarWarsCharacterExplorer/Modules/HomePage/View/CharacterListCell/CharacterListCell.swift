//
//  CharacterListCell.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/28/24.
//

import UIKit

class CharacterListCell: UITableViewCell {
    
    @IBOutlet weak var characterLabel: UILabel!
    static let reuseID = "cellReuseIdentifier"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
