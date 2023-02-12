//
//  PortfolioView2.swift
//  FuckTest4
//
//  Created by Max Pintchouk on 2/9/23.
//

import SwiftUI

struct PortfolioView2: View {
    
    @StateObject public var pData = PortfolioModel()
    //@State public var session_name = ""
   // @State public var detail = Int.random(in: 1..<9)
    @Binding var session_name: String
    
    var body: some View {
        
        ZStack {
            Image("Background2 2")
                .resizable()
                .frame(minWidth: 400, minHeight: 900)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                HStack {
                    if session_name.contains("_") {
                        let session_name = session_name.replacingOccurrences(of: "_", with: " ")
                    }
                    Text("\(session_name)")
                        .font(Font.custom("Rajdhani-Regular", size: 20))
                        .foregroundColor(.white)
                }
                .frame(width: 350)
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.systemBlue), Color(.systemMint)]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
                .padding(.horizontal, 20)
                
                AsyncImage(url: URL(string: pData.url))
                
                //AsyncImage(url: URL(string: pData.url))
                //.padding()
                /* AsyncImage(url: URL(string: pData.url2))
                 .padding()
                 AsyncImage(url: URL(string: pData.url3))
                 .padding()
                 AsyncImage(url: URL(string: pData.url4))
                 .padding()
                 AsyncImage(url: URL(string: pData.url5))
                 .padding()
                 AsyncImage(url: URL(string: pData.url6))
                 .padding()
                 AsyncImage(url: URL(string: pData.url7))
                 .padding()
                 AsyncImage(url: URL(string: pData.url8))
                 .padding()
                 AsyncImage(url: URL(string: pData.url9))
                 .padding()*/
            }
            .task {
                await pData.postData(session_name: session_name)
            }
        }
    }
}

struct PortfolioView2_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView2(session_name: .constant("some-value"))
    }
}
