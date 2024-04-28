//
//  ViewController.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/24/24.
//

import UIKit
import Alamofire
import Combine

class ViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, CharacterInfo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CharacterInfo>
    
    private lazy var dataSource = makeDataSource()
    
    var cancellable = Set<AnyCancellable>()
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = CharacterListViewModel()
    private lazy var datasource = makeDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        getCharacterList()
       
        viewModel.$characterList
            .sink { value in
                
                if let value = value?.list{
                    self.applySnapshot(with: value)
                }
            }
            .store(in: &cancellable)
    }

    private func setupViews() {
        tableView.delegate = self
        tableView.dataSource = datasource
        tableView.register(UINib(nibName: CharacterListCell.className, bundle: nil), forCellReuseIdentifier: CharacterListCell.reuseID)
    }
    
    private func getCharacterList() {
        viewModel.getCharacterList()
        if let list = viewModel.characterList?.list {
            applySnapshot(with: list)
        }
        
    }

}

// tableView dataSoruce methods

extension ViewController {
    func makeDataSource() -> DataSource {
        // 1
        let dataSource = DataSource(
            tableView: tableView,
            cellProvider: { (tableView, indexPath, item) ->
                UITableViewCell? in
                
                let cellID = UUID()
                
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: CharacterListCell.reuseID,
                    for: indexPath) as? CharacterListCell
                cell?.characterLabel.text = item.name
                return cell
            })
    
        return dataSource
    }
    
    func applySnapshot(with characterList: [CharacterInfo], isAnimated: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(characterList)
        
        datasource.apply(snapshot, animatingDifferences: isAnimated)
    }
}

// tableView delegate methods
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

