//
//  Card.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import SwiftUI
import Kingfisher
import SFSafeSymbols

struct Card: View {
    
    let imageURL: URL?
    
    let title: String
    let currency: String
    let price: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                if let imageURL = imageURL {
                    KFImage(imageURL)
                        .placeholder { _ in
                            ShimmeringView {}
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                        Image(systemSymbol: .exclamationmarkArrowTriangle2Circlepath)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(height: 200)
            .clipped()
            
            HStack {
                Text(title)
                    .font(.title)
                    .foregroundColor(.primary)
                Spacer()
                HStack(spacing: 4) {
                    Text(currency)
                        .foregroundColor(.gray)
                        .font(.footnote)
                    Text(price)
                        .bold()
                        .foregroundColor(.primary)
                }
            }
            .padding()
        }
        .cornerRadius(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1),
                        radius: 8,
                        x: 0,
                        y: 4)
        )
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(imageURL: nil,
             title: "Test",
             currency: "EUR",
             price: "9.90")
        .frame(width: 300)
        .padding()
        .previewLayout(.sizeThatFits)
        
        Card(imageURL: URL(string: "https://aws-tiqets-cdn.imgix.net/images/content/9d3735fc2e334bc3a3b68822a2e801b4.jpg?w=315&h=210&dpr=2&q=40&fit=crop")!,
             title: "Test",
             currency: "EUR",
             price: "9.90")
        .frame(width: 300)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
