//
//  BookmarkTabView.swift
//  SwiftUI_NewAppWithNewsAPI (iOS)
//
//  Created by park kyung seok on 2021/10/27.
//

import SwiftUI

struct BookmarkTabView: View {
    
    @EnvironmentObject var articleBookmarkViewModel: ArticleBookmarkViewModel
    
    var body: some View {
        
        NavigationView {
            ArticleListView(articles: articleBookmarkViewModel.bookmarks)
                // overlay、ViewBuilderを使わず Zstack {}でもViewの表示は可能
                .overlay(overlayView(isEmpty: articleBookmarkViewModel.bookmarks.isEmpty))
                .navigationTitle("Saved Articles")

        }
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholderView(text: "No saved articles", image: Image(systemName: "bookmark"))
        }
    }
}

struct BookmarkTabView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkTabView()
    }
}
