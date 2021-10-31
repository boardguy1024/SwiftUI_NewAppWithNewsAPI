//
//  SearchHistoryListView.swift
//  SwiftUI_NewAppWithNewsAPI (iOS)
//
//  Created by park kyung seok on 2021/10/31.
//

import SwiftUI

struct SearchHistoryListView: View {
    
    @ObservedObject var viewModel: ArticleSearchViewModel
    
    let onTapHistory: (String) -> ()
    
    var body: some View {
        
        List {
            HStack {
                Text("Recently Searched")
                Spacer()
                Button(action: {
                    viewModel.removeAllHistory()
                }) {
                    Text("Clear")
                }
            }
            
            ForEach(viewModel.historyTextList, id: \.self) { history in
                Button(history) {
                    onTapHistory(history)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        viewModel.removeHistory(text: history)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }

                }
            }
        }
        .listRowSeparator(.hidden)
        .listStyle(.plain)
    }
}

struct SearchHistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchHistoryListView(viewModel: .init(), onTapHistory: { _ in
            
        })

    }
}
