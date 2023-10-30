//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by MacBook on 29.10.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State
    private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    
    @State
    private var correctAnswer = Int.random(in: 0...2)
    
    @State
    private var scoreTitle = ""
    
    @State
    private var showAlert = false
    
    @State
    private var score = 0
    
    @State
    private var gameProgress = 0
    
    @State
    private var gameEnded = false
    
    
    var body: some View {
        
        ZStack{
            RadialGradient(stops:[
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ],center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing:15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                            
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){item in
                        Button(action: {
                            flagTapped(item)
                        }, label: {
                            Image(countries[item])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        })
                        

                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showAlert){
            Button("Continue", action: {
                askQuestion()
            })
        } message:{
            Text("Question \(gameProgress)/8")
            Text("Your score is \(score)")
        }
        .alert("Game ended", isPresented: $gameEnded){
            Button("Restart?", action:{
                restartGame()
            })
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func incGameProgress(){
        gameProgress += 1
    }
    
    func flagTapped(_ number:Int){
        
        incGameProgress()
        
        scoreTitle = (number == correctAnswer) ? "Correct" : "Incorrect! That's the flag of \(countries[number])"
        score += (number == correctAnswer) ? 1 : 0
        showAlert = gameProgress < 8
        gameEnded = gameProgress >= 8
        
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func restartGame(){
        score = 0
        gameProgress = 0
        askQuestion()
    }
    
}

#Preview {
    ContentView()
}
