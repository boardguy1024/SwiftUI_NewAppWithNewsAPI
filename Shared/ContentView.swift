//
//  ContentView.swift
//  Shared
//
//  Created by park kyung seok on 2021/10/22.
//

import SwiftUI

// you need to reg https://newsapi.org/account
//my api key is : fdc8ae44401848a3835bb7a1d9673671

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
       
        Button(action: {
            let data = Article.previewData
            print(data)
        }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
