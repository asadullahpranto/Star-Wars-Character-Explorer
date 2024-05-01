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
    
    private var pageNumber = 1
    private var isNetworkCallOngoing = false
    
    @IBOutlet weak var tableView: UITableView!
    private var spinnerFooterView: UIView?
    
    var viewModel = CharacterListViewModel()
    private lazy var datasource = makeDataSource()
    
    private var characterList = [CharacterInfo]() {
        didSet {
            self.applySnapshot(with: characterList, isAnimated: false)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
       
        viewModel.$characterList
            .receive(on: DispatchQueue.main)
            .sink { value in
                if let value = value {
                    self.tableView.hideLoadingFooter()
                    self.isNetworkCallOngoing = false
                    self.characterList.append(contentsOf: value.list)
                }
            }
            .store(in: &cancellable)
        loadCharacterList()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    private func setupViews() {
//        navigationController?.isNavigationBarHidden = true
        
        tableView.delegate = self
        tableView.dataSource = datasource
        tableView.register(UINib(nibName: CharacterListCell.className, bundle: nil), forCellReuseIdentifier: CharacterListCell.reuseID)
    }
    
    private func loadCharacterList() {
        tableView.showLoadingFooter()
        if !isNetworkCallOngoing {
            isNetworkCallOngoing = true
            viewModel.getCharacterList(from: pageNumber)
            pageNumber += 1
        }
    }

}

// tableView dataSoruce methods
extension ViewController {
    
    func makeDataSource() -> DataSource {
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastSection = tableView.numberOfSections - 1
        let lastRow = tableView.numberOfRows(inSection: lastSection) - 1
        
        if indexPath.section == lastSection && indexPath.row == lastRow {
           loadCharacterList()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        title = "People"
//        let vc = RegisterViewController()
        let detailVC = CharacterDetailVC()
        detailVC.personDetail = characterList[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        tableView.showLoadingFooter()
//    }    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        tableView.hideLoadingFooter()
//    }
}

