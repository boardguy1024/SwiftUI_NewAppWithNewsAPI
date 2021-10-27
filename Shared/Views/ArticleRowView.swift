//
//  ArticleRowView.swift
//  SwiftUI_NewAppWithNewsAPI (iOS)
//
//  Created by park kyung seok on 2021/10/22.
//

import SwiftUI

struct ArticleRowView: View {
    
    @EnvironmentObject var articleBookmarkViewModel: ArticleBookmarkViewModel
    
    let article: Article
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: article.imageURL) { phase in
                switch phase {
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure(_):
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                        Spacer()
                    }
                    
                //The @unknown keyword will trigger a warning in Xcode if you’re dealing with a potentially non-exhaustive switch statement, because of a changed enumeration.
                @unknown default:
                    fatalError()
                }
            }
            .frame(minHeight: 200, maxHeight: 300)
            .background(Color.gray.opacity(0.3))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.headline)
                
                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(2)
                
                HStack {
                    Text(article.captionText)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Button(action: {
                        if articleBookmarkViewModel.isBookmarked(for: article) {
                            articleBookmarkViewModel.removeBookmark(for: article)
                        } else {
                            articleBookmarkViewModel.addBookmark(for: article)    
                        }
                    }) {
                        withAnimation {
                            Image(systemName: articleBookmarkViewModel.isBookmarked(for: article) ? "bookmark.fill" : "bookmark")
                        }
                    }
                    .buttonStyle(.bordered)

                    Button(action: {
                        presentShareSheet(url: article.articleURL)
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .buttonStyle(.bordered)
                    
                }
                
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ArticleRowView(article: Article.previewData[0])
                    .listRowInsets(.init(.zero))
            }
            .listStyle(.plain)
        }
    }
}
