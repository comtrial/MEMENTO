//
//  SceneDelegate.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/06.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // MARK: SwiftUI migration
        let mainViewController = UIHostingController(rootView: MainView())
//        
//        
        
        
//        let mainViewController = UINavigationController()
//        let mainCoordinator = MainCoordinator()
//        mainCoordinator.navigationController = mainViewController
//        mainCoordinator.start()
        
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
    }

}

