//
//  Article.swift
//  SwiftUI_NewAppWithNewsAPI (iOS)
//
//  Created by park kyung seok on 2021/10/22.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct Article {
    let source: Source
    
    let title: String
    let url: String
    let publishedAt: Date
    
    let author: String?
    let description: String?
    let urlToImage: String?
    
    var authorText: String {
        author ?? ""
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    var captionText: String {
        "\(source.name) ・ \(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
    
    var articleURL: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let url = urlToImage else { return nil }
        return URL(string: url)!
    }
}

extension Article: Codable { }
extension Article: Equatable { }
extension Article: Identifiable {
    var id: String { url }
}

extension Article {
    
    static var previewData: [Article] {
        let previewDataUrl = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataUrl)
        
        let jsonDecoder = JSONDecoder()
        
        // ios8601: ISOで定められた日付と時刻の表記に関する国際規格
        // 例) 2021-06-27T11:05:07Z
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(NewsAPIResponse.self, from: data)
        return apiResponse.articles ?? []
    }
    
}



struct Source {
    let name: String
}

extension Source: Codable { }
extension Source: Equatable { }
