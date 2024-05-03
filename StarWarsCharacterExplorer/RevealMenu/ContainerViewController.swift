//
//  ViewController.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/24/24.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    private let menuVC = MenuViewController()
    private let homeVC = HomeViewController()
    private var navVC: UINavigationController?
    private let coverView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        addChildViewControllers()
        setupOverlayView()
    }
    
    private func addChildViewControllers() {
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    
    private func setupOverlayView() {
        coverView.backgroundColor = .darkGray.withAlphaComponent(0.5)
        coverView.frame = navVC?.view.frame ?? homeVC.view.frame
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMenuButton))
        coverView.addGestureRecognizer(tapGesture)
        coverView.isHidden = true
        coverView.alpha = 0
        homeVC.view.addSubview(coverView)
        
    }
    
    private func hideUnhideCoverView() {
        
    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    @objc func didTapMenuButton() {
        switch menuState {
        case .opened:
            // open side bar
            UIView.animate(
                withDuration: 0.35,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .curveEaseInOut
            ) { [weak self] in
                
                guard let self else { return }
                self.navVC?.view.frame.origin.x = 0
                self.coverView.alpha = 0
                self.coverView.isHidden = true
                self.homeVC.searchBarVC.searchBar.isUserInteractionEnabled = true
                
            } completion: { [weak self] isComplete in
                guard let self else {
                    return
                }
                
                if isComplete {
                    self.menuState = .closed
                }
            }
            
        case .closed:
            // close side bar
            UIView.animate(
                withDuration: 0.35,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .curveEaseInOut
            ) { [weak self] in
                
                guard let self else {
                    return
                }
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - (
                    self.homeVC.view.frame.size.width / 3
                )
                self.coverView.alpha = 1
                self.coverView.isHidden = false
                self.homeVC.searchBarVC.searchBar.isUserInteractionEnabled = false
                
            } completion: { [weak self] isComplete in
                guard let self else {
                    return
                }
                
                if isComplete {
                    self.menuState = .opened
                }
            }
        }
    }
    
}


