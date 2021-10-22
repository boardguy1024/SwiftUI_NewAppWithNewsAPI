//
//  ArticleListView.swift
//  SwiftUI_NewAppWithNewsAPI (iOS)
//
//  Created by park kyung seok on 2021/10/22.
//

import SwiftUI

struct ArticleListView: View {
    
    let articles: [Article]
    
    var body: some View {
        
        List {
            ForEach(articles) { article in
                ArticleRowView(article: article)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.init(.zero))
            
        }
        .listStyle(.plain)
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(articles: Article.previewData)
    }
}
