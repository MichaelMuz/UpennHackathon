//
//  CreateSessionView.swift
//  FuckTest4
//
//  Created by Max Pintchouk on 2/5/23.
//

import SwiftUI

struct EditSessionView: View {
    
    @State public var session_name = ""
    @State public var topicsIn = ""
    @State public var questionsIn = ""
    //@State public var newSessionLevel = ""

    @State private var encodedData: String = "Create Study Session"
    
    @State private var httpData = HttpData()
    
    @State private var postD = EditSessionModel()
    
    @State private var editText: String = "Edit Sessions"
        
    var body: some View {
        
        ZStack {
            Image("Background2 8")
                .resizable()
                .frame(minWidth: 400, minHeight: 900)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                HStack {
                    TextField("Enter your session's name", text: $session_name)
                        .font(Font.custom("Rajdhani-Regular", size: 17))
                        .foregroundColor(.black)
                }
                .frame(width: 350)
                .padding()
                .foregroundColor(.white)
                .background(Color(.systemGray5))
                .cornerRadius(40)
                .padding(.horizontal, 20)
                
                HStack {
                    TextField("Enter Session Topics sep. by commas", text: $topicsIn)
                        .font(Font.custom("Rajdhani-Regular", size: 17))
                        .foregroundColor(.black)
                }
                .frame(width: 350)
                .padding()
                .foregroundColor(.white)
                .background(Color(.systemGray5))
                .cornerRadius(40)
                .padding(.horizontal, 20)
                
                HStack {
                    TextField("Enter list of definitions (X:x_Y:y)", text: $questionsIn)
                        .font(Font.custom("Rajdhani-Regular", size: 17))
                        .foregroundColor(.black)
                }
                .frame(width: 350)
                .padding()
                .foregroundColor(.white)
                .background(Color(.systemGray5))
                .cornerRadius(40)
                .padding(.horizontal, 20)
                
                /*HStack {
                    TextField("Enter Session Topics sep. by commas", text: $newSessionLevel)
                        .font(Font.custom("Rajdhani-Regular", size: 17))
                        .foregroundColor(.black)
                }
                .frame(width: 350)
                .padding()
                .foregroundColor(.white)
                .background(Color(.systemGray5))
                .cornerRadius(40)
                .padding(.horizontal, 20) */
                
                Button(action: {
                    
                    self.postD.postData(session_name: self.session_name, topicsIn: self.topicsIn, questionsIn: self.questionsIn)
                    self.encodedData = "Session Saved"
                }) {
                    HStack {
                        Text(self.encodedData)
                            .font(Font.custom("Rajdhani-Regular", size: 34))
                    }
                    .frame(width: 350)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.systemBlue), Color(.systemMint)]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    .padding(.horizontal, 20)
                }
                
            }
        }
    }
    
}

struct EditSessionView_Previews: PreviewProvider {
    static var previews: some View {
        EditSessionView()
    }
}
