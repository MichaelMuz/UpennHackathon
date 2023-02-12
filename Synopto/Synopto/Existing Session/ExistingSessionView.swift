//
//  QuestionView.swift
//  FuckTest4
//
//  Created by Max Pintchouk on 2/5/23.
//

import SwiftUI



struct ExistingSessionView: View {
    
    @State private var encodedData: String = ""
    
    @State private var httpData = HttpData()
    @StateObject var esData = ExistingSessionModel()

    @State private var esText: String = "Ask Me A Question"
    @State public var suburl: String = ""

    
    var body: some View {
        ZStack {
            Image("Background2 5")
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
                            
                            if session.contains("_") {
                                let sesison = session.replacingOccurrences(of: "_", with: " ")
                            }
                            
                            NavigationLink (destination: ViewSessionView(suburl: $suburl), label: {
                                HStack {
                                    Text("View \(session)")
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
