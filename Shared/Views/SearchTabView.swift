//
//  SearchTabView.swift
//  SwiftUI_NewAppWithNewsAPI (iOS)
//
//  Created by park kyung seok on 2021/10/30.
//

import SwiftUI

struct SearchTabView: View {
    
    @StateObject var viewModel = ArticleSearchViewModel()
     
    var body: some View {
        
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView())
                .navigationTitle("Search")
        }
        .searchable(text: $viewModel.searchQuery)
        .onSubmit(of: .search) {
            Task.init {
                await viewModel.searchArticle()
            }
        }
        .onChange(of: viewModel.searchQuery) { newValue in
            if newValue.isEmpty {
                viewModel.phase = .empty
            }
        }
    }
    
    private var articles: [Article] {
        if case .success(let articles) = viewModel.phase {
            return articles
        } else {
            return []
        }
    }
    
    @ViewBuilder
    func overlayView() -> some View {
        switch viewModel.phase {
        case .empty:
            if !viewModel.searchQuery.isEmpty {
                ProgressView()
            } else {
                EmptyPlaceholderView(text: "Type your query to search from NewsAPI", image: .init(systemName: "magnifyingglass"))
            }
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceholderView(text: "No Search results found", image: .init(systemName: "magnifyingglass"))
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: {
                Task.init {
                    await viewModel.searchArticle()
                }
            })
        default:
            EmptyView()
        }
    }
}

struct SearchTabView_Previews: PreviewProvider {
    
    @StateObject static var viewModel = ArticleBookmarkViewModel.shared
    static var previews: some View {
        SearchTabView()
            .environmentObject(viewModel)
    }
}
