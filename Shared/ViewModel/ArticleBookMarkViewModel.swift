//
//  ArticleBookMarkViewModel.swift
//  SwiftUI_NewAppWithNewsAPI (iOS)
//
//  Created by park kyung seok on 2021/10/27.
//

import SwiftUI

@MainActor
class ArticleBookmarkViewModel: ObservableObject {
    
    static let shared = ArticleBookmarkViewModel()
    
    @Published private(set) var bookmarks: [Article] = []
    private let bookmarkStore = PlistDataStore<[Article]>(filname: "bookmark")
    
    private init() {
        Task.init {
            bookmarks = await bookmarkStore.load() ?? []
        }
    }
    
    private func bookmarkUpdated() {
        Task.init {
            await bookmarkStore.save(bookmarks)
        }
    }
    
    func isBookmarked(for article: Article) -> Bool {
        bookmarks.first { $0.id == article.id } != nil
    }
    
    func addBookmark(for article: Article) {
        guard !isBookmarked(for: article) else { return }
        
        bookmarks.insert(article, at: 0)
        bookmarkUpdated()
    }
    
    func removeBookmark(for article: Article) {
        guard let index = bookmarks.firstIndex(where: { $0.id == article.id }) else { return }
        bookmarks.remove(at: index)
        bookmarkUpdated()
    }
}
