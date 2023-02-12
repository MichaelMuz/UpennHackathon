//
//  EditSessionModel.swift
//  FuckTest4
//
//  Created by Max Pintchouk on 2/6/23.
//

import Foundation


class EditSessionModel {
    
    private struct Session: Codable {
        var session_name: String
        var topics: [String]
        var questions: [Subq]
        
        /*private enum CodingKeys: String, CodingKey {
            case session_name = "session_name"
            case topics = "topics"
            case question = "Subq"
        }*/
    }
    
    struct Subq: Codable {
        var quesion: String
        var answer: String
    }
    
    @Published var urlString: String = "http://100.26.154.173/edit_create_session"
    
    func postData(session_name: String, topicsIn: String, questionsIn: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let topics = topicsIn.components(separatedBy: "_")
        
        let qBefore = questionsIn.components(separatedBy: "_")
        let questionsA = qBefore.map{ q in
            return q.components(separatedBy: ":")
        }
        
        var subsublist = [[String: Any]]()
        for qa in questionsA {
            let sublist = ["question": qa[0], "answer": qa[1]]
            subsublist.append(sublist)
        }
        
        let body: [String: Any] = ["session_name": session_name, "topics": topics, "questions": subsublist]
        
        let finalData = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, res, err) in
            do {
            
                if let data = data {
                    //let result = try JSONDecoder().decode(Session.self, from: data)
                    //print(result)
                    print(data)
                

                } else {
                    print("No Data")
                }
            } catch (let error){
                print("error: ", error.localizedDescription)
            }
        
        }.resume()
        
    }
    
}
