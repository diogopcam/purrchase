//
//  TabBarController.swift
//  purrchase
//
//  Created by Diogo Camargo on 13/05/25.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad(){
        super.viewDidLoad()
        setupTabs()
        setupTabBarAppearance()
    }
    
    private func setupTabs() {
        let listsVC = ListsVC(controller: ProductListController())
        
        let listsNav = UINavigationController(rootViewController: listsVC)
        listsNav.title = "List"
        listsNav.tabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "list.bullet"), tag: 0)
        
        
        let pantryVC = PantryVC(controller: PantryController())
        let pantryNav = UINavigationController(rootViewController: pantryVC)
        pantryNav.title = "Pantry"
        pantryNav.tabBarItem = UITabBarItem(title: "Pantry", image: UIImage(systemName: "bag.fill"), tag: 1)
        
        let inspirationVC = InspirationVC()
        let inspirationNav = UINavigationController(rootViewController: inspirationVC)
        inspirationNav.title = "Inspiration"
        inspirationNav.tabBarItem = UITabBarItem(title: "Inspiration", image: UIImage(systemName: "sparkles"), tag: 2)
        
        let profileVC = ProfileVC()
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.title = "Inspiration"
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 3)

        viewControllers = [listsNav, pantryNav, inspirationNav, profileNav]
    }
    
    private func setupTabBarAppearance() {
        
        tabBar.tintColor = .textAndIcons /// selecionado
        tabBar.unselectedItemTintColor = .gray /// não selecionado
            
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
                
            appearance.stackedLayoutAppearance.selected.iconColor = .textAndIcons
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.textAndIcons]
                
            appearance.stackedLayoutAppearance.normal.iconColor = .gray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
            
            tabBar.standardAppearance = appearance
            
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
            }
        }
    }
}
