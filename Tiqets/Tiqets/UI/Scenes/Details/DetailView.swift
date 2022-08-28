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
                                            .fill(Color.ui(.disabled))
                                        Image(systemSymbol: .exclamationmarkArrowTriangle2Circlepath)
                                            .foregroundColor(.ui(.background))
                                    }
                                }
                            }
                        )
                        .frame(height: 300)
                        .clipped()
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(viewModel.sections) { section in
                            switch section.type {
                            case .price(let currency, let value):
                                HStack {
                                    Image(systemSymbol: .walletPass)
                                        .foregroundColor(.text())
                                    Text(currency)
                                        .font(.footnote)
                                        .foregroundColor(.text(.secondary))
                                    
                                    Text(value)
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.text())
                                }
                                
                            case .location(let value):
                                HStack {
                                    Image(systemSymbol: .mappinCircle)
                                        .foregroundColor(.text())
                                    Text(value)
                                        .font(.title2)
                                    .foregroundColor(.text(.secondary))
                                }
                                
                            case .rating(let value):
                                HStack {
                                    Image(systemSymbol: .star)
                                        .foregroundColor(.text())
                                    Text(value)
                                        .foregroundColor(.text(.secondary))
                                    + Text(" / 5")
                                        .bold()
                                    .foregroundColor(.text())
                                }
                                
                            case .dateRange(let startDate, let endDate):
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemSymbol: .arrowLeftToLine)
                                            .foregroundColor(.text())
                                        VStack(alignment: .leading) {
                                            Text("Starts")
                                                .foregroundColor(.text(.secondary))
                                            Text(startDate)
                                                .bold()
                                                .foregroundColor(.text())
                                        }
                                    }
                                    Spacer()
                                    HStack {
                                        Image(systemSymbol: .arrowRightToLine)
                                            .foregroundColor(.text())
                                        VStack(alignment: .leading) {
                                            Text("Ends")
                                                .foregroundColor(.text(.secondary))
                                            Text(endDate)
                                                .bold()
                                                .foregroundColor(.text())
                                        }
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
                HStack {
                    Spacer()
                    Text(
                        viewModel.isFavorite
                        ? "Remove from favorites"
                        : "Add to favorites"
                    )
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    Spacer()
                }
            }
            .allowsHitTesting(!viewModel.favoriteStateIsLoading)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        viewModel.favoriteStateIsLoading
                        ? Color.ui(.disabled)
                        : viewModel.isFavorite
                        ? Color.ui(.danger)
                        : Color.ui(.info)
                    )
                    .loading(isLoading: viewModel.favoriteStateIsLoading)
            )
            .padding()
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color.ui(.background))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: .init(Mock.Offerings.Exhibitions.erraticGrowth,
                                    favoritesProvider: Mock.FavoritesProvider()))
        
        DetailView(viewModel: .init(Mock.Offerings.Venues.moco,
                                    favoritesProvider: Mock.FavoritesProvider()))
    }
}
