//
//  RetryView.swift
//  SwiftUI_NewAppWithNewsAPI (iOS)
//
//  Created by park kyung seok on 2021/10/24.
//

import SwiftUI

struct RetryView: View {
    
    let text: String
    let retryAction: () -> ()
    
    var body: some View {
        
        VStack(spacing: 8) {
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
            
            Button(action: retryAction) {
                Text("Try again")
            }
        }
    }
}

struct RetryView_Previews: PreviewProvider {
    static var previews: some View {
        RetryView(text: "", retryAction: {})
    }
}
