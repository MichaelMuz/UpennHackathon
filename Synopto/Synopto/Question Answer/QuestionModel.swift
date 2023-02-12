//
//  PortfolioModel.swift
//  FuckTest4
//
//  Created by Max Pintchouk on 2/6/23.
//

import Foundation

class QuestionModel: ObservableObject {
    
    // EDITED TO MATCH JSON FORMAT FROM GET REQUEST
    private struct Returned: Codable {
        var question: String
        //var answer: String
        //var results: [Result]
    }
    
    //struct Result: Codable, Hashable {
        //var name: String
        //var url: String
    //}
    
    @Published var urlString: String = "http://100.26.154.173/ask_question/"
    @Published var question: String = ""
    //@Published var answer: String = ""
   // @Published var creaturesArray: [Result] = []
    
    func getData(suburl: String) async {
        print("Accessing URL: \(urlString + suburl)")
        
        guard let url = URL(string: (urlString + suburl)) else {
            print("Error, cant make url: \(urlString + suburl)")
            return
        }
        
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("error could not decode json data")
                return
            }
            self.question = returned.question
            print(self.question)
            //self.answer = returned.answer
            //self.urlString = returned.next
            //self.creaturesArray = returned.results
        }
        catch {
            print("Some other error")
        }
    }
}
