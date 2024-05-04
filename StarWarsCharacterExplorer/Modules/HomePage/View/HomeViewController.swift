//
//  HomeViewController.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 2/5/24.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, CharacterInfo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CharacterInfo>
    
    @IBOutlet weak var tableView: UITableView!
    private var spinnerFooterView: UIView?
    
    private lazy var dataSource = makeDataSource()
    private var viewModel = CharacterListViewModel()
    var searchBarVC = UISearchController(searchResultsController: nil)
    
    var cancellable = Set<AnyCancellable>()
    
    private var nextPage: String?
    private var isNetworkCallOngoing = false
    
    weak var delegate: SlideMenuDelegate?
    
    private var characterList = [CharacterInfo]() {
        didSet {
            self.applySnapshot(with: characterList, isAnimated: false)
        }
    }
    
    private var dbCharacterList = [Characters]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "SW Character Explorer"
        
        setupTableView()
        setupSearchBar()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: #selector(didTapMenuButton))
        
        bindViewModelToView()
        loadCharacterList(for: viewModel.firstPageUrl)
        
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = dataSource
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.register(UINib(nibName: CharacterListCell.className, bundle: nil), forCellReuseIdentifier: CharacterListCell.reuseID)
    }
    
    private func setupSearchBar() {
        searchBarVC = UISearchController(searchResultsController: nil)
        searchBarVC.delegate = self
        searchBarVC.searchBar.delegate = self
        self.navigationItem.searchController = searchBarVC
    }
    
    private func bindViewModelToView() {
        viewModel.$characterList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self else { return }
                if let value = value {
                    self.tableView.hideLoadingFooter()
                    self.isNetworkCallOngoing = false
                    self.nextPage = value.nextPage
                    self.characterList.append(contentsOf: value.list)
                }
            }
            .store(in: &cancellable)
        viewModel.$charListFromDB
            .receive(on: DispatchQueue.main)
            .sink { [weak self] charList in
                self?.dbCharacterList = charList
            }
            .store(in: &cancellable)
    }
    
    private func loadCharacterList(for url: String) {
        if Reachability.isConnectedToNetwork() {
            if !isNetworkCallOngoing {
                tableView.showLoadingFooter()
                isNetworkCallOngoing = true
                
                viewModel.getCharacterList(from: url)
            }
        } else {
            viewModel.getCharListFromDB()
        }
        
    }
    
    @objc private func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
}

// tableView dataSoruce methods
extension HomeViewController {
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            tableView: tableView,
            cellProvider: { (tableView, indexPath, item) ->
                UITableViewCell? in
                
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
        
        dataSource.apply(snapshot, animatingDifferences: isAnimated)
    }
}

// tableView delegate methods
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastSection = tableView.numberOfSections - 1
        let lastRow = tableView.numberOfRows(inSection: lastSection) - 1
        
        if indexPath.section == lastSection && indexPath.row == lastRow {
            
            if let nextPage, Reachability.isConnectedToNetwork() {
                tableView.showLoadingFooter()
                loadCharacterList(for: nextPage)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSection = tableView.numberOfSections - 1
        let lastRow = tableView.numberOfRows(inSection: lastSection) - 1
        
        if indexPath.section == lastSection && indexPath.row == lastRow {
            tableView.hideLoadingFooter()
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
    
}

extension HomeViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
