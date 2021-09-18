//
//  ContentView.swift
//  AnimeQuotes
//
//  Created by 0rientd on 18/09/21.
//

import SwiftUI

struct ContentView: View {
    @State private var animeName = String()
    @State private var characterName = String()
    @State private var animeQuote = String()
    
    @State private var defaultColor = Color.black
    
    var body: some View {
        ZStack {
            Color(red: 0.8, green: 0.4, blue: 0.4, opacity: 1)
                .ignoresSafeArea()
            
            VStack {
                Text("Anime Quotes")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                
                Text("Desenvolvido por dev.0rientd")
                    .foregroundColor(Color.white)
                    .colorMultiply(self.defaultColor)
                    .onAppear(perform: {
                        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                            self.defaultColor = Color.purple
                        }
                    })

                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 350, height: 110, alignment: .center)
                        .foregroundColor(.black)
                        .opacity(0.45)
                        .shadow(radius: 10)
                    
                    VStack {
                        Text("Anime")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(.bottom, 15)

                        Text(animeName)
                            .bold()
                            .foregroundColor(.white)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .frame(width: 330)
                        
                    }
                }

                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 350, height: 110, alignment: .center)
                        .foregroundColor(.black)
                        .opacity(0.45)
                        .shadow(radius: 10)
                    
                    VStack {
                        Text("Character")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(.bottom, 15)

                        Text(characterName)
                            .bold()
                            .foregroundColor(.white)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .frame(width: 330)
                        
                    }
                }

                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 350, height: 300, alignment: .center)
                        .foregroundColor(.black)
                        .opacity(0.45)
                        .shadow(radius: 10)
                    
                    VStack {
                        Text("Quote")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(.bottom, 5)

                        ScrollView {
                            Text(animeQuote)
                                .foregroundColor(.white)
                            
                        }
                        .frame(maxWidth: 330, maxHeight: 210, alignment: .center)
                    }
                }

                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 7.0)
                        .frame(width: 100, height: 40, alignment: .center)
                        .foregroundColor(.green)
                        .opacity(0.4)
                        .shadow(radius: 10)
                        .shadow(radius: 10)
                 
                    Button("Update") {
                        let url = URL(string: "https://animechan.vercel.app/api/random")
                        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                            if data != nil {
                                let jsonDecoder = JSONDecoder()
                                
                                do {
                                    let tempContent = try jsonDecoder.decode(animeQuoteResponse.self, from: data!)
                                    self.animeName = tempContent.anime
                                    self.characterName = tempContent.character
                                    self.animeQuote = tempContent.quote
                                    
                                } catch {
                                    print("Error in: \(error.localizedDescription)")
                                
                                }
                            }
                        }
                        
                        task.resume()
                    }
                    .padding()
                    .accentColor(.white)
                    
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 11")
    }
}
