//
//  QuestionView.swift
//  FuckTest4
//
//  Created by Max Pintchouk on 2/5/23.
//

import SwiftUI



struct QuestionView: View {
    
    @State private var encodedData: String = ""
    
    @State private var httpData = HttpData()
    @StateObject var esData = ExistingSessionModel()
    @State public var suburl: String = ""
    @State private var qText: String = "Ask Me A Question"

    
    var body: some View {
        
        ZStack {
            Image("Background2 3")
                .resizable()
                .frame(minWidth: 400, minHeight: 900)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                NavigationView {
                    VStack(alignment: .leading) {
                        ForEach(esData.sessions, id: \.self) { session in
                            
                            NavigationLink (destination: QuestionSpecificView(suburl: $suburl), label: {
                                HStack {
                                    Text(session)
                                        .font(Font.custom("Rajdhani-Regular", size: 24))
                                }
                                .frame(width: 350)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color(.systemGray3))
                                .cornerRadius(40)
                                .padding(.horizontal, 20)
                            }).simultaneousGesture(TapGesture().onEnded{
                                self.suburl = session
                            })
                            /* Button(action: {
                                
                            }) {
                                HStack {
                                    Text(session)
                                        .font(Font.custom("Rajdhani-Regular", size: 34))
                                }
                                .frame(width: 350)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color(.systemGray3))
                                .cornerRadius(40)
                                .padding(.horizontal, 20)
                            } */
                            
                        }
                        HStack {
                            Text("Choose a Session")
                                .font(Font.custom("Rajdhani-Regular", size: 24))
                        }
                        .frame(width: 350)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(.systemBlue), Color(.systemMint)]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                        .padding(.horizontal, 20)
                    }
                }
                
                .task {
                    await esData.getData()
                }
            }
            
            
        }
    }
    
    
    struct QuestionView_Previews: PreviewProvider {
        static var previews: some View {
            QuestionView()
        }
    }
}
