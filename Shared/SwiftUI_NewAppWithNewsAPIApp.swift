//
//  SwiftUI_NewAppWithNewsAPIApp.swift
//  Shared
//
//  Created by park kyung seok on 2021/10/22.
//

import SwiftUI

@main
struct SwiftUI_NewAppWithNewsAPIApp: App {
    
    @StateObject var articleBookmarkViewModel = ArticleBookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkViewModel)
        }
    }
}
