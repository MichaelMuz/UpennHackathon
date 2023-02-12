//
//  QuestionView.swift
//  FuckTest4
//
//  Created by Max Pintchouk on 2/5/23.
//

import SwiftUI



struct PortfolioView: View {
    
    @State private var encodedData: String = ""
    
    @State private var httpData = HttpData()
    @StateObject var esData = ExistingSessionModel()
    @StateObject var pData = PortfolioModel()


    @State public var session_name = ""
    @State public var detail: Int = 5
    @State private var esText: String = "Ask Me A Question"
    @State public var suburl: String = ""

    
    var body: some View {
        ZStack {
            Image("Background2")
                .resizable()
                .frame(minWidth: 400, minHeight: 900)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                /* VStack {
                 Text(encodedData)
                 .onAppear {
                 self.httpData.fetchData(from: "http://100.26.154.173/ask_question") { result in
                 switch result {
                 case .success(let data):
                 self.encodedData = data
                 case .failure(let error):
                 print("Error: \(error)")
                 }
                 }
                 }
                 } */
                NavigationView {
                    VStack(alignment: .leading) {
                        ForEach(esData.sessions, id: \.self) { session in
                            
                            NavigationLink (destination: PortfolioView2(session_name: .constant(session)), label: {
                                HStack {
                                    Text("View NFT: \(session)")
                                        .font(Font.custom("Rajdhani-Regular", size: 24))
                                }
                                .frame(width: 350)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color(.systemGray3))
                                .cornerRadius(40)
                                .padding(.horizontal, 20)
                            }).simultaneousGesture(TapGesture().onEnded{
                                //self.pData.postData(session_name: self.session_name, detail: self.detail)
                                //print(pData.url)
                            })
                        }
                    }
                }
                
                .task {
                    await esData.getData()
                }
            }
            
        }
    }
    
    
    struct ExistingSessionView_Previews: PreviewProvider {
        static var previews: some View {
            ExistingSessionView()
        }
    }
}
