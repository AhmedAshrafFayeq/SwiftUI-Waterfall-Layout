//
//  ContentView.swift
//  SwiftUI-WaterfallLayout
//
//  Created by Ahmed Fayek on 12/27/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let cards: [Card] = [
        .init(title: "Kick Boxing", imageName: "kickBoxing"),
        .init(title: "Boxing", imageName: "boxing"),
        .init(title: "Morning", imageName: "morning"),
        .init(title: "Fitness", imageName: "fitness"),
        .init(title: "Pilates", imageName: "pilates"),
        .init(title: "Intervals", imageName: "intervals"),
        .init(title: "Yoga", imageName: "yoga"),
        .init(title: "Run", imageName: "running")
    ]
    
    var leftCards: [Card]{
        cards.enumerated()
            .filter{ $0.offset % 2 == 0 }
            .map{$0.element}
    }
    var rightCards: [Card]{
        cards.enumerated()
            .filter{ $0.offset % 2 != 0 }
            .map{$0.element}
    }
    
    var visibleLeftCards: [Card] {
        if cards.count % 2 != 0 {
            let slice = Array(leftCards[0..<leftCards.count - 1])
            return Array(slice)
        }else{
            return leftCards
        }
    }
    
    var visibleRightCards: [Card] {
        if cards.count % 2 != 0, let lastLeftCard = leftCards.last{
            return rightCards + [lastLeftCard]
        }else{
            return rightCards
        }
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                HStack(spacing: 16) {
                    VStack{
                        ForEach(Array(visibleLeftCards.enumerated()), id: \.element) { offset, card in
                            CardView(card: card)
                                .frame(height: offset % 2 == 0 ? 320 : 200)
                            
                        }
                    }
                    VStack{
                        ForEach(Array(visibleRightCards.enumerated()), id: \.element) { offset, card in
                            CardView(card: card)
                                .frame(height: offset % 2 != 0 ? 320 : 200)
                        }
                    }
                }.padding()
                
            }.navigationBarTitle("Categories")
                .navigationBarItems(leading: Button(action: {
                    // What to perform
                }) {
                    // How the button looks like
                    Image(systemName: "arrow.left")
                    },trailing: Button(action: {
                        // What to perform
                    }) {
                        // How the button looks like
                        Image(systemName: "magnifyingglass")
                })
        }.accentColor(.primary)
        
    }
}

struct Card: Hashable{
    let title: String
    let imageName: String
}

struct CardView: View {
    var card: Card
    var body: some View {
        GeometryReader{ proxy in
            ZStack{
                Image(self.card.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: proxy.size.width,
                        height: proxy.size.height
                ).clipped()
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).fill(Color(.gray).opacity(0.4)))
                Text(self.card.title.uppercased())
                    .font(.title)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(4)
                    .foregroundColor(.white)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            ContentView()
        }.accentColor(.primary)
    }
}
