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
        .searchable(text: $viewModel.searchQuery) { suggestionView() }
        .onSubmit(of: .search, searchArticle)
        .onChange(of: viewModel.searchQuery) { newValue in
            if newValue.isEmpty {
                viewModel.phase = .empty
            }
        }
    }
    
    @ViewBuilder
    private func suggestionView() -> some View {
        ForEach(["Specialized","Tarmac SL7","Sworks","Surfing","sramred"], id: \.self) { text in
            Button(action: {
                viewModel.searchQuery = text
            }) {
                Text(text)
            }
        }
    }
    
    private func searchArticle() {
        
        let searchQuery = viewModel.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        if !searchQuery.isEmpty {
            viewModel.addHistory(text: searchQuery)
        }
        
        Task.init {
            await viewModel.searchArticle()
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
    private func overlayView() -> some View {
        switch viewModel.phase {
        case .empty:
            if !viewModel.searchQuery.isEmpty {
                ProgressView()
            } else if !viewModel.historyTextList.isEmpty {
                SearchHistoryListView(viewModel: viewModel) { tappedSearchText in
                    viewModel.searchQuery = tappedSearchText
                }
            }
            else {
                EmptyPlaceholderView(text: "Type your query to search from NewsAPI", image: .init(systemName: "magnifyingglass"))
            }
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceholderView(text: "No Search results found", image: .init(systemName: "magnifyingglass"))
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: searchArticle)
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
