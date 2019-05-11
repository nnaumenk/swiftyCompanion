//
//  GetToken.swift
//  Companion
//
//  Created by Nazar NAUMENKO on 5/11/19.
//  Copyright © 2019 Nazar NAUMENKO. All rights reserved.
//

import Foundation

class GetToken: AsyncOperation {
    
    let uid: String
    let secret: String
    let grantType: String
  
    override init() {
        self.uid = "990f3ad71fc7d2130681e6b5b73f48c43c5f1dba4b239853f9a1c2efd17dc116"
        self.secret = "cc1ac6f86f61e96795af75120f028079a3ec0f5083b037c3eb6ce84e1c702b01"
        self.grantType = "grant_type=client_credentials&client_id=\(uid)&client_secret=\(secret)"
        
    }
    
    override func main() {
        self.state = .executing
        DataController.token = nil
        print("OK")
        if isCancelled {
            self.state = .finished
            return
        }
        print("OK2")
        
        guard let url = URL(string: "https://api.intra.42.fr/oauth/token?") else {
            self.state = .finished
            return
        }
        print("OK3")
        var requset = URLRequest(url: url)
        requset.httpMethod = "POST"
        requset.httpBody = grantType.data(using: .utf8)
        let session = URLSession.shared
        print("session")
        session.dataTask(with: requset) {data, response, error in
            print("OK4")
            guard let data = data else {
                self.state = .finished
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                self.state = .finished
                return
            }
            guard let dictionary = json as? NSDictionary else {
                self.state = .finished
                return
            }
            guard let token = dictionary["access_token"] as? String else {
                self.state = .finished
                return
            }
            DataController.token = token
            print("token=", DataController.token!)/////
        }.resume()
    }
}
