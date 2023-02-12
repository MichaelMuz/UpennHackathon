//
//  PortfolioModel.swift
//  FuckTest4
//
//  Created by Max Pintchouk on 2/6/23.
//

import Foundation

@MainActor
class PortfolioModel: ObservableObject {
    
    private struct Postresponse: Codable {
        var url: String
    }
    
    // EDITED TO MATCH JSON FORMAT FROM GET REQUEST
    /*private struct Returned: Codable {
        var url1: String
        var url2: String
        var url3: String
        var url4: String
        var url5: String
        var url6: String
        var url7: String
        var url8: String
        var url9: String
        //var next: String
        //var results: [Result]
    }*/
    
    /*struct Result: Codable, Hashable {
        var name: String
        var url: String
    } */
    
    @Published var urlString: String = "http://100.26.154.173/view_pictures"
    @Published var url: String = ""
    /*@Published var url1: String = ""
    @Published var url2: String = ""
    @Published var url3: String = ""
    @Published var url4: String = ""
    @Published var url5: String = ""
    @Published var url6: String = ""
    @Published var url7: String = ""
    @Published var url8: String = ""
    @Published var url9: String = ""*/
    //@Published var creaturesArray: [Result] = []
    
    /*func getData() async {
        print("Accessing URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Error, cant make url: \(urlString)")
            return
        }
        
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("error could not decode json data")
                return
            }
            self.url1 = returned.url1
            self.url2 = returned.url2
            self.url3 = returned.url3
            self.url4 = returned.url4
            self.url5 = returned.url5
            self.url6 = returned.url6
            self.url7 = returned.url7
            self.url8 = returned.url8
            self.url9 = returned.url9
        }
        catch {
            print("Some other error")
        }
    }*/
    
    func postData(session_name: String) async {
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
        
        let body: [String: Any] = ["session_name": session_name]
        
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
                        self.url = result.url
                        
                        print(self.url)
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
