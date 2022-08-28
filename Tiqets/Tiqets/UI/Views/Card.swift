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
    
    let isFavorite: Bool
    let userPressedFavoriteButton: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
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
                                .fill(Color.ui(.disabled))
                            Image(systemSymbol: .exclamationmarkArrowTriangle2Circlepath)
                                .foregroundColor(.ui(.highlight))
                        }
                    }
                }
                .frame(height: 200)
                .clipped()
                
                Button {
                    userPressedFavoriteButton()
                } label: {
                    Image(systemSymbol: isFavorite ? .heartFill : .heart)
                        .padding(20)
                        .foregroundColor(
                            isFavorite
                            ? .ui(.accent)
                            : .static(.light)
                        )
                }
            }
            
            HStack {
                Text(title)
                    .font(.title)
                    .foregroundColor(.text())
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                Spacer()
                HStack(spacing: 4) {
                    Text(currency)
                        .foregroundColor(.text(.secondary))
                        .font(.footnote)
                    Text(price)
                        .bold()
                        .foregroundColor(.text())
                }
            }
            .padding()
        }
        .cornerRadius(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.ui(.highlight))
                .shadow(color: .ui(.shadow),
                        radius: 8,
                        x: 0,
                        y: 4)
        )
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Card(imageURL: nil,
                 title: "Test",
                 currency: "EUR",
                 price: "9.90",
                 isFavorite: true) {}
                .frame(width: 300)
                .padding()
                .previewLayout(.sizeThatFits)
            
            Card(imageURL: URL(string: "https://aws-tiqets-cdn.imgix.net/images/content/9d3735fc2e334bc3a3b68822a2e801b4.jpg?w=315&h=210&dpr=2&q=40&fit=crop")!,
                 title: "Test",
                 currency: "EUR",
                 price: "9.90",
                 isFavorite: false) {}
                .frame(width: 300)
                .padding()
                .previewLayout(.sizeThatFits)
        }
        .background(
            Color.ui(.background)
        )
    }
}
