//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Brandon Law on 2020-07-24.
//

import SwiftUI

struct cardTile: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 75))
            .frame(width: 300, height: 175)
            .background(Color(UIColor.systemIndigo))
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

extension View {
    func cardStyle() -> some View {
        self.modifier(cardTile())
    }
}

struct ContentView: View {
    @State private var showResult = false
    @State private var userScore = 0
    @State private var scoreTitle = ""
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        VStack (spacing: 30){
            Text("Your score is: \(self.userScore)")
                .font(.largeTitle)
                .fontWeight(.bold)
                        
            Button (action: {
                self.inputTapped(0)
            }) {
                Text("✊")
                    .cardStyle()
            }
            Button (action: {
                self.inputTapped(1)
            }) {
                Text("✋")
                    .cardStyle()
            }
            Button (action: {
                self.inputTapped(2)
            }) {
                Text("✌️")
                    .cardStyle()
            }
        }.alert(isPresented: $showResult) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(self.userScore)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func inputTapped(_ number: Int) {
        if number == 0 {
            if correctAnswer == 1 {
                scoreTitle = "You lose! The robot chose ✋"
            } else if correctAnswer == 2 {
                scoreTitle = "You win! The robot chose ✌️"
                userScore += 1
            } else {
                scoreTitle = "It's a tie! You both chose ✊"
            }
        } else if number == 1 {
            if correctAnswer == 2 {
                scoreTitle = "You lose! The robot chose ✌️"
            } else if correctAnswer == 0 {
                scoreTitle = "You win! The robot chose ✊"
                userScore += 1
            } else {
                scoreTitle = "It's a tie! You both chose ✋"
            }
        } else {
            if correctAnswer == 0 {
                scoreTitle = "You lose! The robot chose ✊"
            } else if correctAnswer == 1 {
                scoreTitle = "You win! The robot chose ✋"
                userScore += 1
            } else {
                scoreTitle = "It's a tie! You both chose ✌️"
            }
        }
        showResult = true
    }
    
    func askQuestion() {
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
