//
//  ContentView.swift
//  Shared
//
//  Created by park kyung seok on 2021/10/22.
//

import SwiftUI

// you need to reg https://newsapi.org/account
//my api key is : fdc8ae44401848a3835bb7a1d9673671

struct ContentView: View {
    var body: some View {
        
        TabView {
            NewsTabView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            BookmarkTabView()
                .tabItem {
                    Label("Bookmark", systemImage: "bookmark")
                }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
