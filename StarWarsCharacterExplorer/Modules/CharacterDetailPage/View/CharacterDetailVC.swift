//
//  CharacterDetailVC.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 1/5/24.
//

import UIKit

class CharacterDetailVC: UIViewController {

    @IBOutlet weak var abbreviationNameHolder: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abbreviationName: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var skinColorLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    var personDetail: CharacterInfo?
    
    
    @IBOutlet weak var birthGenderStack: UIStackView!
    @IBOutlet weak var colorStack: UIStackView!
    @IBOutlet weak var heightWeightStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupPersonData()
    }
    
    private func setupViews() {
        abbreviationNameHolder.layer.cornerRadius = abbreviationNameHolder.frame.width / 2
        abbreviationNameHolder.layer.masksToBounds = true
        heightWeightStack.alignment = .leading
        colorStack.alignment = .leading
        birthGenderStack.alignment = .leading
    }
    
    private func setupPersonData() {
        if let personDetail {
            nameLabel.text = personDetail.name
            abbreviationName.text = personDetail.name.getNameComponents()
            heightLabel.text = "Height: " +  personDetail.height
            massLabel.text = "Weight: " +  personDetail.mass
            hairColorLabel.text = "Hair: " +  personDetail.hairColor
            skinColorLabel.text = "Skin: " +  personDetail.skinColor
            eyeColorLabel.text = "Eye: " +  personDetail.eyeColor
            birthYearLabel.text = "Birth Year: " +  personDetail.birthYear
            genderLabel.text = "Gender: " +  personDetail.gender
        }
    }
}
