//
//  SceneDelegate.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/06.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowscene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowscene)
        
        let nvc = UINavigationController()
        let mainCoordinator = MainCoordinator()
        mainCoordinator.nvc = nvc
        mainCoordinator.start()
        
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
    }

}

