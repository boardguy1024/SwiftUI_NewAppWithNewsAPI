//
//  NewsTabView.swift
//  SwiftUI_NewAppWithNewsAPI (iOS)
//
//  Created by park kyung seok on 2021/10/24.
//

import SwiftUI

struct NewsTabView: View {
    
    @StateObject var viewModel = ArticleNewsViewModel()
    
    private var articles: [Article] {
        if case let .success(articles) = viewModel.phase {
            return articles
        } else {
            return []
        }
    }
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
            
            // onAppear、onChangeを使わず idのパラメータにbinding対象のvalueが変更したらクロージャーがコールされる
                .task(id: viewModel.fetchTaskToken, {
                    await loadArticles()
                })
            // Zstackの代わりにViewをoverlayできる
                .overlay(overlayView)
                .refreshable {
                    // tokenをrefreshすることで上記の .task(id: viewModel.fetchTaskTokenのtokenが更新されることにより、actionが実行される
                    refreshTask()
                }
                .refreshable {
                    await loadArticles()
                }
            //                .onAppear {
            //                    loadArticles()
            //                }
            //                .onChange(of: viewModel.selectedCategory) { _ in
            //                    loadArticles()
            //                }
                .navigationTitle(viewModel.fetchTaskToken.category.text)
                .navigationBarItems(trailing: menu)
        }
        
    }
    
    @ ViewBuilder
    private var overlayView: some View {
        
        switch viewModel.phase {
        case .empty:
            ProgressView()
        case .success(let article) where article.isEmpty:
            EmptyPlaceholderView(text: "No Articles", image: nil)
        case .failure(let error):
            RetryView(text: error.localizedDescription) {
                refreshTask()
            }
        default:
            EmptyView()
        }
    }
    
    private var menu: some View {
        Menu {
            Picker("Category", selection: $viewModel.fetchTaskToken.category) {
                ForEach(Category.allCases) {
                    Text($0.text).tag($0)
                }
            }
        } label: {
            Image(systemName: "fiberchannel")
                .imageScale(.large)
        }
    }
    
    private func refreshTask() {
        // tokenをrefresh - ここではtokenをDate型として使っている
        viewModel.fetchTaskToken = .init(category: viewModel.fetchTaskToken.category, token: Date())
    }
    
    private func loadArticles() async {
        await viewModel.loadArticles()
    }
}


struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView(viewModel: ArticleNewsViewModel(articles: Article.previewData))
    }
}
