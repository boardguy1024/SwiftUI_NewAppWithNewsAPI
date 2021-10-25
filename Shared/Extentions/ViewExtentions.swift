//
//  ViewExtentions.swift
//  SwiftUI_NewAppWithNewsAPI (iOS)
//
//  Created by park kyung seok on 2021/10/24.
//

import SwiftUI

extension View {
    
    func presentShareSheet(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
}
