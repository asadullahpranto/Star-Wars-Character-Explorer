//
//  CharacterDetailVC.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 1/5/24.
//

import UIKit
import Combine

class CharacterDetailVC: UIViewController {
    
    @IBOutlet weak var starshipsLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
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
    @IBOutlet weak var birthGenderStack: UIStackView!
    @IBOutlet weak var colorStack: UIStackView!
    @IBOutlet weak var heightWeightStack: UIStackView!
    
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var planetNameLabel: UILabel!
    private var cancellables = Set<AnyCancellable>()
    var personDetail: CharacterInfo?
    private let viewModel = CharacterDetailViewModel()
    private var starships = [Starship]()
    private var planet: Planet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupPersonData()
        bindViewModel()
    }
    
    private func setupViews() {
        abbreviationNameHolder.layer.cornerRadius = abbreviationNameHolder.frame.width / 2
        abbreviationNameHolder.layer.masksToBounds = true
        heightWeightStack.alignment = .leading
        colorStack.alignment = .leading
        birthGenderStack.alignment = .leading
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: CardViewCell.className, bundle: nil), forCellWithReuseIdentifier: CardViewCell.className)
    }
    
    private func setupPersonData() {
        if let personDetail {
            nameLabel.text = personDetail.name
            abbreviationName.text = personDetail.name.getNameComponents()
            heightLabel.text = "Height: " +  personDetail.height.capitalized
            massLabel.text = "Weight: " +  personDetail.mass.capitalized
            hairColorLabel.text = "Hair: " +  personDetail.hairColor.capitalized
            skinColorLabel.text = "Skin: " +  personDetail.skinColor.capitalized
            eyeColorLabel.text = "Eye: " +  personDetail.eyeColor.capitalized
            birthYearLabel.text = "Birth Year: " +  personDetail.birthYear.capitalized
            genderLabel.text = "Gender: " +  personDetail.gender.capitalized
            
            starshipsLabel.text = "Starships(" + "\(personDetail.starships.count)" + ")"
            
            viewModel.getPlanetDetail(for: personDetail.homeworld)
            viewModel.getStarshipsDetail(for: personDetail.starships)
        }
    }
    
    private func bindViewModel() {
        // Subscribe to the publisher
        viewModel.$allStarship
            .sink { [weak self] starships in
                guard let self else { return }
                
                if let starships {
                    self.starships = starships
                    self.collectionView.reloadData()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$planet
            .receive(on: DispatchQueue.main)
            .sink { [weak self] planet in
                guard let self else { return }
                
                self.planet = planet
                self.planetNameLabel.text = "Name: " + (planet?.name.capitalized ?? "")
                self.populationLabel.text = "Population: " + (planet?.population ?? "")
            }
            .store(in: &cancellables)
    }
}

// datasource
extension CharacterDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return starships.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewCell.className, for: indexPath) as! CardViewCell
        cell.configure(with: starships[indexPath.item])
        return cell
    }
    
    
}

extension CharacterDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: self.collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
}
