//
//  BookmarkTabView.swift
//  SwiftUI_NewAppWithNewsAPI (iOS)
//
//  Created by park kyung seok on 2021/10/27.
//

import SwiftUI

struct BookmarkTabView: View {
    
    @EnvironmentObject var articleBookmarkViewModel: ArticleBookmarkViewModel
    @State var searchText: String = ""
    
    var body: some View {
        
        NavigationView {
            ArticleListView(articles: searchedArticles)
                // overlay、ViewBuilderを使わず Zstack {}でもViewの表示は可能
                .overlay(overlayView(isEmpty: articleBookmarkViewModel.bookmarks.isEmpty))
                .navigationTitle("Saved Articles")

        }
        // NavigationBarにTextFieldを表示
        .searchable(text: $searchText)
    }
    
    private var searchedArticles: [Article] {
        if searchText.isEmpty {
            return articleBookmarkViewModel.bookmarks
        } else {
            return articleBookmarkViewModel.bookmarks
                .filter {
                    $0.title.lowercased().contains(searchText.lowercased()) ||
                    $0.descriptionText.lowercased().contains(searchText.lowercased())
                }
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
