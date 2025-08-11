//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by loku on 10/08/2025.
//

import SwiftUI

struct ContentView: View {

    @State private var showingScore = false

    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland",
        "Spain", "UK", "Ukraine", "US",
    ].shuffled()

    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var bestScore = 0
    @State private var selectedFlag = ""

    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(
                        color: Color(red: 0.1, green: 0.2, blue: 0.45),
                        location: 0.3
                    ),
                    .init(
                        color: Color(red: 0.76, green: 0.15, blue: 0.26),
                        location: 0.3
                    ),
                ],
                center: .top,
                startRadius: 200,
                endRadius: 500
            )
            .ignoresSafeArea()
            VStack(spacing: 100) {
                VStack {
                    Text("Guess the flag!")
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.bold))
                        .padding(.bottom, 20)
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))

                }
                VStack(spacing: 40) {
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(for: number)
                        } label: {
                            Image(countries[number])
                                .shadow(radius: 5)
                        }
                    }
                    VStack {
                        Text("Score: \(score)")
                            .foregroundStyle(.white)
                            .padding(.bottom, 5)
                        Text("Best score: \(bestScore)")
                            .foregroundStyle(.white)
                            .font(.headline)
                    }
                }
            }
        }
        .alert("You lost !", isPresented: $showingScore) {
            Button("Continue") {
                if score > bestScore {
                    bestScore = score
                }
                score = 0
                randomizeFlags()
            }
        } message: {
            Text(
                "This flag was \(selectedFlag)\nYour score is \(score)"
            )
        }
    }

    func randomizeFlags() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

    func flagTapped(for number: Int) {
        if number == correctAnswer {
            score += 1
            randomizeFlags()
        } else {
            selectedFlag = countries[number]
            showingScore = true
        }
    }
}

#Preview {
    ContentView()
}
