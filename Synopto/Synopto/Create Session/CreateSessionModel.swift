//
//  EditSessionModel.swift
//  FuckTest4
//
//  Created by Max Pintchouk on 2/6/23.
//

import Foundation
//import networkListener


class CreateSessionModel {
    
    private struct Session: Codable {
        var session_name: String
        var topics: [String]
        var Subq: [Subq]
        
       /* private enum CodingKeys: String, CodingKey {
            case session_name = "session_name"
            case topics = "topics"
            case question = "Subq"
        }*/
        
        public struct Subq: Codable {
            var quesion: String
            var answer: String
        }
    }
    
    
    
    
    @Published var urlString: String = "https://webhook.site/15ea0e09-dd7b-495e-8242-d9b4ba81c6aa"

    
    func postData(session_name: String, topicsIn: String, questionsIn: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let topics = topicsIn.components(separatedBy: "_")
        
        let qBefore = questionsIn.components(separatedBy: "_")
        let questionsA = qBefore.map{ q in
            return q.components(separatedBy: ":")
        }
        
        var sublist = [Session.Subq]()
        for qa in questionsA {
            sublist.append(Session.Subq(quesion: qa[0], answer: qa[1]))
        }
                
        let session = Session(session_name: session_name, topics: topics, Subq: sublist)
        
       // let body: [String: Any] = ["session_name": session_name, "topics": topics, "questions": sublist]
       // let finalData = try! JSONSerialization(withJSONObject: body)
        
        let jsonEncoder = JSONEncoder()
        //jsonEncoder.outputFormatting = .prettyPrinted
            
        
        let encodeSession: Data = Data()

        do {
            let encodeSession = try jsonEncoder.encode(session)
            let endcodeStringSession = String(data: encodeSession, encoding: .utf8)!
            print(endcodeStringSession)
            //networkListener.requestPost(endpoint: urlString, data: encodeSession , headerValue: nil)
        } catch {
            print(error)
        }
        
        //let finalData = try! JSONSerialization.data(withJSONObject: session)
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = encodeSession
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, res, err) in
            do {
            
                if let data = data {
                    let result = try JSONDecoder().decode(Session.self, from: data)
                    print(result)
                

                } else {
                    print("No Data")
                }
            } catch (let error){
                print("error: ", error.localizedDescription)
            }
            
        } .resume()
    }
    
}
