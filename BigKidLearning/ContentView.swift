//
//  ContentView.swift
//  BigKidLearning
//
//  Created by Joshua Rosado Olivencia on 9/4/24.
//
// creating a learning game of choosing for my 4 year old daughter

// give 2 - 3 options for user to select

// Numbers
// Colors
// Letters



import SwiftUI

struct ContentView: View {

    @State private var learningTypes = ["Colors", "Numbers", "Letters"]
    @State private var selectedLearningType = "Colors"
    
    
    
    @State private var colors = ["Red", "Blue", "Yellow", "Green", "Purple", "Orange", "Black","Pink", "White", "Brown"].shuffled()
    @State private var  numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20].shuffled()
    @State private var  letters = ["A", "B","C","CH" ,"D", "E", "F", "G", "H", "I","J", "K","L", "LL","M","N","Ñ", "O", "P", "Q","R", "RR","S", "T", "U", "V", "W", "X", "Y", "Z"].shuffled()
    
    @State private var correctColor = Int.random(in: 0...2)
//    @State private var correctNumber = Int.random(in: 0...2)
//    @State private var  correctLetter = Int.random(in: 0...2)
    
    @State private var showScore = false
    @State private var startingGame = true
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    @State private var rounds = 0
    @State private var wrongSelectedOption = 0
    
    @State private var gameOver = false
    
    
    
    
    var body: some View {
        ZStack {
            ZStack{
           Section{
               // BG simulating the blue sky
                    LinearGradient(colors: [.gray.opacity(0.3), .blue.opacity(0.5)], startPoint: .bottomLeading, endPoint: .top)
                        .ignoresSafeArea()
                }
                Section{
                    // Simulation of the sun over the bg
                    RadialGradient(stops:[
                        .init(color:Color(.yellow) , location: 0.1),
                        .init(color: Color(.clear), location: 0.3)
                    ],center: .bottomLeading, startRadius: 150, endRadius: 700)
                        .ignoresSafeArea()
                }
            }
            VStack{
                Text("BigKidLearning")
                    .foregroundStyle(.white)
                    .font(.largeTitle.weight(.heavy))
                    .fontDesign(.rounded)
                    .padding(.bottom,25)
                
                
                
                HStack(spacing: 55){
                    
                    VStack{
                        Text("Which \(selectedLearningType) is")
                            .foregroundStyle(.secondary)
                            .font(.title3.bold())
                            .padding(.top)
                        
                        Text("\(colors[correctColor])")
                            .foregroundStyle(.black)
                            .font(.title.weight(.heavy))
                            .fontDesign(.rounded)
                            .bold()
                            .padding(.bottom)
                             
                    }
                    VStack{
                        // Showing 3 colors at a time
                        ForEach(0..<3){ number in
                            Button {
                                optionSelected(number)
                                
                            }label: {
                                Image(colors[number])
                                    .frame(width: 125, height: 125)
                                    .padding(.top, 20)
                                    .clipShape(.circle)
                                    .shadow(radius: 5)
                                
                                
                            }
                            
                        }
                    }
                    
                }
                
                .frame(maxWidth: .infinity, maxHeight: 500.0)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .padding(.horizontal)
                
                Text("Score: \(currentScore)").padding(.top, 25).padding(.bottom, -5).font(.largeTitle).bold().fontDesign(.rounded).foregroundStyle(.secondary)
                
                
                // Selection for learning type
                Picker("Learning Type", selection: $selectedLearningType){
                    ForEach(learningTypes, id: \.self){
                        Text("\($0)")
                        
                    }
                }
                .pickerStyle(.segmented).background(.secondary.opacity(0.2))
                .frame(minWidth: 200, maxWidth: 300)
                .padding()

            }
            
        }
        // alert for every time an option is selected and showing the result
        .alert("\(scoreTitle) ", isPresented: $showScore){
            Button("Continue", action: gameLimit)
        } message: {
            Text("Your score is \(currentScore)")
        }
        
        // alert for when the game reach up to the last round
        .alert("Game Over ",isPresented: $gameOver ) {
            Button("Restart", action: resetGame)
        } message: {
            Text(" Score \(currentScore) / 10")
        }
        
//        .alert("Start Game", isPresented: $startingGame){
//            Button("Start", action: selectingGame(gameType: <#T##Int#>))
//        }
    }
    
    
    func selectingGame(gameType: Int) -> String{
        for games in 0..<learningTypes.count{
            
            if gameType == games{
                return learningTypes[gameType]
            }
        }
        return ""
    }
    
    
    // Testing if the option selected is correct or incorrect
    // and if incorrect, show name of the incorrect option selected
    func optionSelected(_ number: Int){
        rounds += 1 // counting rounds
        wrongSelectedOption = number
        if number == correctColor{
            scoreTitle = "Correct"
            currentScore += 1
        } else {
            scoreTitle = "Incorrect, that's \(colors[wrongSelectedOption]) "
        }
        showScore = true
    }
    
    // LIMIT THE GAME TO 10 QUESTIONS
    func gameLimit(){
        for _ in 1..<11{
            if rounds < 10{ // if rounds is less than 10
                askQuestion() // keep playing
            } else if rounds == 10{ // when reach to round 10
                gameOver = true // game over
                
                
            }
        }
        
    }
    
    
    // Func to keep asking question. Rounds
    func askQuestion(){
        colors.shuffle()
        correctColor = Int.random(in: 0...2)
    }

    // restart game
    func resetGame(){
        currentScore = 0
        
    }
}

#Preview {
    ContentView()
}
