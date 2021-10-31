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
    @Published var historyTextList = [String]()
    
    private let newsAPI = NewsAPI.shared
    
    private let historyMaxLimit: Int = 10
    
    func addHistory(text: String) {
        if let index = historyTextList.firstIndex(where:  { $0.lowercased() == text.lowercased()} ) {
            //キーワードが配列に含まれている場合、削除（先頭にinsertするので）
            historyTextList.remove(at: index)
        } else if historyTextList.count - 1 == historyMaxLimit {
            historyTextList.removeFirst()
        }
        
        historyTextList.insert(text, at: 0)
    }
    
    //　履歴のセルをスワイプで削除するために使う
    func removeHistory(text: String) {
        guard let index = historyTextList.firstIndex(where: { $0.lowercased() == text.lowercased() }) else { return }
        historyTextList.remove(at: index)
    }
    
    func removeAllHistory() {
        historyTextList.removeAll()
    }
    
    func searchArticle() async {
        if Task.isCancelled { return }
        
        addHistory(text: self.searchQuery)
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
