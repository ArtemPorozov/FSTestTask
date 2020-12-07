//
//  SceneDelegate.swift
//  ForaSoftTestTaskIOS
//
//  Created by Artem on 04.12.2020.
//  Copyright © 2020 Artem P. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = UINavigationController(rootViewController: AlbumSearchController())
            window?.makeKeyAndVisible()
        }
    }

}
