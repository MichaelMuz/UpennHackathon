//
//  QuestionSpecificModel.swift
//  FuckTest4
//
//  Created by Max Pintchouk on 2/8/23.
//

import Foundation


class QuestionSpecificModel: ObservableObject {
    
    private struct Postresponse: Codable {
        var question: String
        var user_answer: String
        var is_correct: Bool
        var true_answer: String
    }
    
    @Published var urlString: String = "http://100.26.154.173/answer_question"
    @Published var user_answer: String = ""
    @Published var question: String = ""
    @Published var is_correct: Bool = false
    @Published var checker: Bool = false
    @Published var true_answer: String = "" {
        didSet {
            print("this thing changed")
            checker = true
        }
    }
    
    func postData(session_name: String, question: String, user_answer: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        /*let topics = topicsIn.components(separatedBy: "_")
         
         let qBefore = questionsIn.components(separatedBy: "_")
         let questionsA = qBefore.map{ q in
         return q.components(separatedBy: ":")
         }
         
         var subsublist = [[String: Any]]()
         for qa in questionsA {
         let sublist = ["question": qa[0], "answer": qa[1]]
         subsublist.append(sublist)
         }*/
                        
        let body: [String: Any] = ["session_name": session_name, "question": question, "answer": user_answer]
        
        let finalData = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, res, err) in
            do {
                
                if let data = data {
                    let result = try JSONDecoder().decode(Postresponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.user_answer = result.user_answer
                        self.question = result.question
                        self.true_answer = result.true_answer
                        self.is_correct = result.is_correct
                    }
                    
                    
                    
                } else {
                    print("No Data")
                }
            } catch (let error){
                print("error: ", error.localizedDescription)
            }
            
        }.resume()
        
    }
}
