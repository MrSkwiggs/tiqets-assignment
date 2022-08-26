//
//  OfferingsView.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import SwiftUI
import Kingfisher

struct OfferingsView: View {
    @StateObject
    var viewModel: ViewModel
    
    var body: some View {
        List {
            Section("Venues") {
                ForEach(viewModel.venues) { venue in
                    VStack {
                        KFImage(venue.imageURL)
                            .placeholder {
                                ShimmeringView {
                                    Rectangle()
                                }
                            }
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .frame(height: 100)
                }
            }
            
            Section("Exhibitions") {
                ForEach(viewModel.exhibitions) { venue in
                    VStack {
                        
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct OfferingsView_Previews: PreviewProvider {
    static var previews: some View {
        OfferingsView(viewModel: .init())
    }
}
