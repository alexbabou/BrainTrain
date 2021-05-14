//
//  ContentView.swift
//  BrainTrain
//
//  Created by Alex Babou on 5/14/21.
//

import SwiftUI

struct blueButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

extension View {
    func blueButton() -> some View {
        self.modifier(blueButtonStyle())
    }
}

struct ContentView: View {
    private let handOptions = ["Rock", "Paper", "Scissors"]
    @State private var cpuHand = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var response = " "
    
    func testAnswer(number: Int) {
        if shouldWin == true {
            if cpuHand == 0 && number == 1 ||
                cpuHand == 1 && number == 2 ||
                cpuHand == 2 && number == 0 {
                winOrLose(result: true)
            } else {
                winOrLose(result: false)
            }
        } else {
            if !(cpuHand == 0 && number == 1) &&
                !(cpuHand == 1 && number == 2) &&
                !(cpuHand == 2 && number == 0) &&
                !(cpuHand == number) {
                winOrLose(result: true)
            } else {
                winOrLose(result: false)
            }
        }
        cpuHand = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func winOrLose(result: Bool) {
        if result {
            score += 1
            response = "Good Job"
        } else {
            score -= 1
            response = "Better luck next time"
        }
    }
    
    var body: some View {
        VStack (spacing: 30) {
            Text("Player Score: \(score)").font(.title3)
            VStack {
                Group { Text("App's move: ") + Text("\(handOptions[cpuHand])").bold() }
                if shouldWin {
                    Text("You should win")
                } else {
                    Text("You should lose")
                }
            }
            HStack {
                Button(action: { testAnswer(number: 0) }) {
                    Image(systemName: "cube.fill").blueButton()
                }
                Button(action: { testAnswer(number: 1) }) {
                    Image(systemName: "doc.fill").blueButton()
                }
                Button(action: { testAnswer(number: 2) }) {
                    Image(systemName: "scissors").blueButton()
                }
            }
            Text("\(response)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
