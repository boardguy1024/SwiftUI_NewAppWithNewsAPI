//
//  ArticleBookMarkViewModel.swift
//  SwiftUI_NewAppWithNewsAPI (iOS)
//
//  Created by park kyung seok on 2021/10/27.
//

import SwiftUI

@MainActor
class ArticleBookmarkViewModel: ObservableObject {
    
    @Published private(set) var bookmarks: [Article] = []
    
    func isBookmarked(for article: Article) -> Bool {
        bookmarks.first { $0.id == article.id } != nil
    }
    
    func addBookmark(for article: Article) {
        guard !isBookmarked(for: article) else { return }
        
        bookmarks.insert(article, at: 0)
    }
    
    func removeBookmark(for article: Article) {
        guard let index = bookmarks.firstIndex(where: { $0.id == article.id }) else { return }
        bookmarks.remove(at: index)
    }
}
