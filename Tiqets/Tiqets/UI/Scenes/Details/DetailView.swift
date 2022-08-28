//
//  DetailView.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import SwiftUI
import Kingfisher
import Core

struct DetailView: View {
    
    @StateObject
    var viewModel: ViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    VStack {
                        ZStack(alignment: .leading) {
                            LinearGradient(colors: [.clear, .clear, .black.opacity(0.9)], startPoint: .top, endPoint: .bottom)
                            VStack(alignment: .leading) {
                                Spacer()
                                Text(viewModel.title)
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                        .background(
                            Group {
                                if let imageURL = viewModel.imageURL {
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
                        )
                        .frame(height: 300)
                        .clipped()
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.sections) { section in
                            switch section.type {
                            case .price(let currency, let value):
                                HStack {
                                    Text(currency)
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                    
                                    Text(value)
                                        .font(.headline)
                                        .bold()
                                }
                                
                            case .location(let value):
                                Text(value)
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                
                            case .rating(let value):
                                Text(value)
                                    .foregroundColor(.gray)
                                + Text(" / 5")
                                    .bold()
                                
                            case .dateRange(let startDate, let endDate):
                                HStack(alignment: .top) {
                                    VStack {
                                        Text("Starts")
                                            .foregroundColor(.gray)
                                        Text(startDate)
                                            .bold()
                                    }
                                    Spacer()
                                    VStack {
                                        Text("Ends")
                                            .foregroundColor(.gray)
                                        Text(endDate)
                                            .bold()
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            Spacer()
            
            Button {
                viewModel.userDidTapFavoriteButton()
            } label: {
                Text(
                    viewModel.isFavorite
                    ? "Remove from favorites"
                    : "Add to favorites"
                )
                .bold()
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            viewModel.favoriteStateIsLoading
                            ? Color.gray
                            : viewModel.isFavorite
                            ? Color.red
                            : Color.blue
                        )
                        .loading(isLoading: viewModel.favoriteStateIsLoading)
                )
            }
            .allowsHitTesting(!viewModel.favoriteStateIsLoading)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: .init(Mock.Offerings.Exhibitions.erraticGrowth,
                                    favoritesProvider: Mock.FavoritesProvider()))
    }
}
