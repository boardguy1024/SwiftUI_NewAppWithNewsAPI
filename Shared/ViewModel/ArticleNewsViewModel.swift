//
//  ArticleNewsViewModel.swift
//  SwiftUI_NewAppWithNewsAPI (iOS)
//
//  Created by park kyung seok on 2021/10/24.
//

import SwiftUI

enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}


struct FetchTaskToken: Equatable {
    var category: Category
    var token: Date
}

@MainActor
class ArticleNewsViewModel: ObservableObject {
    
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var fetchTaskToken: FetchTaskToken
    private let newsAPI = NewsAPI.shared
    
    init(articles: [Article]? = nil, selectedCategory: Category = .general) {
        
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.fetchTaskToken = .init(category: selectedCategory, token: Date())
    }
    
    func loadArticles() async {
        // 初期起動時に Task.isCancelled == trueになるため .failureが流れないようにguardを設定
        guard Task.isCancelled == false else { return }
        self.phase = .empty
        do {
            let articles = try await newsAPI.fetch(from: fetchTaskToken.category)
            phase = .success(articles)
        } catch {
            phase = .failure(error)
        }
    }
    
}
