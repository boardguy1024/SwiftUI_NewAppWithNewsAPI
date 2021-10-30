//
//  ArticleSearchViewModel.swift
//  SwiftUI_NewAppWithNewsAPI (iOS)
//
//  Created by park kyung seok on 2021/10/30.
//

import SwiftUI

@MainActor
class ArticleSearchViewModel: ObservableObject {
    
    @Published var phase: DataFetchPhase<[Article]> = .empty
    @Published var searchQuery: String = ""
    private let newsAPI = NewsAPI.shared
    
    func searchArticle() async {
        if Task.isCancelled { return }
        
        let searchQeury = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQeury.isEmpty { return }
        
        do {
            let articles = try await newsAPI.search(for: searchQeury)
            phase = .success(articles)
        } catch {
            phase = .failure(error)
        }
    }
}
