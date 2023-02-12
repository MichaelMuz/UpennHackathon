//
//  ViewSessionView.swift
//  FuckTest4
//
//  Created by Max Pintchouk on 2/8/23.
//

import SwiftUI

struct ViewSessionView: View {
    
    @StateObject var vData = ViewSessionModel()
    @Binding var suburl: String

    var body: some View {
        ZStack {
            Image("Background2 7")
                .resizable()
                .frame(minWidth: 400, minHeight: 900)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    Text("\(self.suburl)")
                        .font(Font.custom("Rajdhani-Regular", size: 34))
                }
                .frame(width: 350)
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.systemBlue), Color(.systemMint)]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
                .padding(.horizontal, 20)
                
                ForEach(vData.topics, id: \.self) { topic in
                    
                        HStack {
                            Text("Topic: \(topic)")
                                .font(Font.custom("Rajdhani-Regular", size: 24))
                        }
                        .frame(width: 350)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(.systemGray))
                        .cornerRadius(40)
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(.leading)
                }
                
                ForEach(vData.questions, id: \.self) { question in
                 
                 HStack {
                     Text("Definition: \(question.question): \(question.answer)")
                 .font(Font.custom("Rajdhani-Regular", size: 24))
                 }
                 .frame(width: 350)
                 .padding()
                 .foregroundColor(.white)
                 .background(Color(.systemGray))
                 .cornerRadius(40)
                 .padding(.horizontal, 20)
                 .multilineTextAlignment(.leading)
                 
                 }
            }
                .task {
                    await vData.getData(suburl: suburl)
                }
            
        }
    }
}

struct ViewSessionView_Previews: PreviewProvider {
    static var previews: some View {
        ViewSessionView(suburl: .constant("some-value"))
    }
}
