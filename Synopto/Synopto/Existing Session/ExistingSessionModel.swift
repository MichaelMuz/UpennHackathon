//
//  PortfolioModel.swift
//  FuckTest4
//
//  Created by Max Pintchouk on 2/6/23.
//

import Foundation

@MainActor
class ExistingSessionModel: ObservableObject {
    
    // EDITED TO MATCH JSON FORMAT FROM GET REQUEST
    private struct Returned: Codable {
        var user_id: Int
        var sessions: [String]
        //var results: [Result]
    }
    
    //struct Result: Codable, Hashable {
        //var name: String
        //var url: String
    //}
    
    @Published var urlString: String = "http://100.26.154.173/get_sessions"
    @Published var user_id = 1
    @Published var sessions: [String] = []
    
    func getData() async {
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
            self.user_id = returned.user_id
            self.sessions = returned.sessions
            //self.creaturesArray = returned.results
        }
        catch {
            print("Some other error")
        }
    }
}
