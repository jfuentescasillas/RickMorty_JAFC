//
//  RMTabBarController.swift
//  RickAndMorty_JAFC
//
//  Created by jfuentescasillas on 16/07/23.
//


import UIKit


final class RMTabBarController: UITabBarController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
    }
    
    
    // MARK: - Private Methods
    private func setupTabs() {
        // Create the ViewControllers and set automatic large titles on them
        let charsVC   = RMCharacterViewController()
        charsVC.title = "Characters List"
        charsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let locationsVC   = RMLocationViewController()
        locationsVC.title = "All Locations"
        locationsVC.navigationItem.largeTitleDisplayMode = .automatic

        let episodesVC   = RMEpisodeViewController()
        episodesVC.title = "Episodes List"
        episodesVC.navigationItem.largeTitleDisplayMode = .automatic

        let settingsVC   = RMSettingsViewController()
        settingsVC.title = "App Settings"
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic

        // Configure the navigation controllers tabBarItems for each VC
        let nav1: UINavigationController = UINavigationController(rootViewController: charsVC)
        let nav2: UINavigationController = UINavigationController(rootViewController: locationsVC)
        let nav3: UINavigationController = UINavigationController(rootViewController: episodesVC)
        let nav4: UINavigationController = UINavigationController(rootViewController: settingsVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Characters",
                                       image: UIImage(systemName: "person"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Locations",
                                       image: UIImage(systemName: "globe"),
                                       tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Episodes",
                                       image: UIImage(systemName: "tv"),
                                       tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Settings",
                                       image: UIImage(systemName: "gear"),
                                       tag: 4)
        
        // Making titles large
        let navigators: [UINavigationController] = [nav1, nav2, nav3, nav4]
        
        for nav in navigators {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(navigators, animated: true)
    }
}
