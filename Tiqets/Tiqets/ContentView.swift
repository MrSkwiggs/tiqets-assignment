//
//  ContentView.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 25/08/2022.
//

import SwiftUI
import Networking

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                TiqetsAPI.Offerings.getAll.perform { response in
                    print(response)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
