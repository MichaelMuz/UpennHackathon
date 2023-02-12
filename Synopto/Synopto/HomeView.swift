//
//  HomeView.swift
//  FuckTest4
//
//  Created by Max Pintchouk on 2/5/23.
//

import SwiftUI
import Foundation


import SwiftUI
import Foundation

struct HomeView: View {
    @State var value: String = ""
    @State private var encodedData: String = ""
    @State public var httpData = HttpData()
    
    var body: some View {
        ZStack {
            Image("Background1")
                .resizable()
                .frame(minWidth: 400, minHeight: 900)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("SynoptoTrans1024")
                    .resizable()
                    .frame(width: 300.0, height: 300.0)
                    .padding(.vertical, 20)
                
                Button(action: {
                    print("Loading...")
                    self.presentCreateSessionView()
                }) {
                    HStack {
                        Text("Create Study Session")
                            .font(Font.custom("Rajdhani-Regular", size: 34))
                    }
                    .frame(width: 350)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.systemBlue), Color(.systemMint)]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    .padding(.horizontal, 20)
                }
                .padding(.bottom)
                Button(action: {
                    print("Loading...")
                    self.presentExistingSessionView()
                }) {
                    HStack {
                        Text("Active Study Sessions")
                            .font(Font.custom("Rajdhani-Regular", size: 34))
                    }
                    .frame(width: 350)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.systemBlue), Color(.systemMint)]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    .padding(.horizontal, 20)
                }
                .padding(.bottom)
                
                Button(action: {
                    print("Loading...")
                    self.presentQuestionView()
                }) {
                    HStack {
                        Text("Ask Me A Question")
                            .font(Font.custom("Rajdhani-Regular", size: 34))

                    }
                    .frame(width: 350)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.systemBlue), Color(.systemMint)]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    .padding(.horizontal, 20)
                }
                .padding(.bottom)
                
                Button(action: {
                    print("Loading...")
                    self.presentPortfolioView()
                }) {
                    HStack {
                        Text("View Portfolio")
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
    
    private func presentCreateSessionView() {
        let createSessionView = CreateSessionView()
        let hostingController = UIHostingController(rootView: createSessionView)
        UIApplication.shared.windows.first?.rootViewController?.present(hostingController, animated: true, completion: nil)
    }
    
    private func presentExistingSessionView() {
        let existingSessionView = ExistingSessionView()
        let hostingController = UIHostingController(rootView: existingSessionView)
        UIApplication.shared.windows.first?.rootViewController?.present(hostingController, animated: true, completion: nil)
    }
    
    private func presentQuestionView() {
        let questionView = QuestionView()
        let hostingController = UIHostingController(rootView: questionView)
        UIApplication.shared.windows.first?.rootViewController?.present(hostingController, animated: true, completion: nil)
    }
    
    private func presentPortfolioView() {
        let portfolioView = PortfolioView()
        let hostingController = UIHostingController(rootView: portfolioView)
        UIApplication.shared.windows.first?.rootViewController?.present(hostingController, animated: true, completion: nil)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

