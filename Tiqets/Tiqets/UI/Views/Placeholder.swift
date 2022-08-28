//
//  Placeholder.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import SwiftUI

struct ShimmerConfiguration {
    let gradient: Gradient
    let initialLocation: (start: UnitPoint, end: UnitPoint)
    let finalLocation: (start: UnitPoint, end: UnitPoint)
    let duration: TimeInterval
    let opacity: Double
    
    static let `default` = ShimmerConfiguration(
        gradient: Gradient(stops: [
            .init(color: Color.clear, location: 0),
            .init(color: Color.gray.opacity(0.3), location: 0.3),
            .init(color: Color.gray.opacity(0.3), location: 0.7),
            .init(color: Color.clear, location: 1),
        ]),
        initialLocation: (start: UnitPoint(x: -1, y: 0.5), end: .leading),
        finalLocation: (start: .trailing, end: UnitPoint(x: 2, y: 0.5)),
        duration: 2,
        opacity: 0.6
    )
}


struct ShimmeringView<Content: View>: View {
    private let content: () -> Content
    private let configuration: ShimmerConfiguration
    
    @State private var startPoint: UnitPoint
    @State private var endPoint: UnitPoint
    
    init(configuration: ShimmerConfiguration = .default, @ViewBuilder content: @escaping () -> Content) {
        self.configuration = configuration
        self.content = content
        _startPoint = .init(wrappedValue: configuration.initialLocation.start)
        _endPoint = .init(wrappedValue: configuration.initialLocation.end)
    }
    
    var body: some View {
        ZStack {
            content()
            LinearGradient(
                gradient: configuration.gradient,
                startPoint: startPoint,
                endPoint: endPoint
            )
            .opacity(configuration.opacity)
            .onAppear {
                withAnimation(Animation.linear(duration: configuration.duration).repeatForever(autoreverses: false)) {
                    startPoint = configuration.finalLocation.start
                    endPoint = configuration.finalLocation.end
                }
            }
        }
    }
}

struct ShimmerModifier: ViewModifier {
    let configuration: ShimmerConfiguration
    public func body(content: Content) -> some View {
        ShimmeringView(configuration: configuration) { content }
    }
}

extension View {
    
    func shimmer(configuration: ShimmerConfiguration = .default) -> some View {
        modifier(ShimmerModifier(configuration: configuration))
    }
    
    @ViewBuilder
    func loading(isLoading: Bool, with shimmer: Bool = true) -> some View {
        if isLoading {
            if shimmer { self.loadingWithShimmer } else { self.loadingWithoutShimmer }
        } else {
            self
        }
    }
    
    @ViewBuilder
    private var loadingWithoutShimmer: some View {
        self
            .redacted(reason: .placeholder)
            .disabled(true)
    }
    
    @ViewBuilder
    private var loadingWithShimmer: some View {
        self.shimmer()
            .redacted(reason: .placeholder)
            .disabled(true)
    }
}


struct ShimmerPreviews: PreviewProvider {
    
    struct MockedView: View {
        
        let data = ["One ", "Two", "Three"]
        
        var body: some View {
            List(data, id: \.self) { item in
                Text(item)
                    .frame(width: .infinity)
                    .loading(isLoading: true)
            }
        }
    }
    
    static var previews: some View {
        Group {
            MockedView()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
            
            MockedView()
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
        }
    }
}
