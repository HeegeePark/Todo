//
//  AppDelegate.swift
//  Todo
//
//  Created by 박희지 on 2/14/24.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let configuration = Realm.Configuration(schemaVersion: 2) { migration, oldSchemaVersion in
            
            
            // MyListModel 테이블 추가
            // TodoModel에 MyListModel todos 프로퍼티(렘 리스트)의 링킹 오브젝트 컬럼 추가
            if oldSchemaVersion < 1 {
                print("Schema version 0 -> 1")
            }
            
            // MyListModel 테이블 color 컬럼 타입 변경(String -> Int)
            if oldSchemaVersion < 2 {
                print("Schema version 0 -> 1")
            }
        }
        
        Realm.Configuration.defaultConfiguration = configuration
                
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

