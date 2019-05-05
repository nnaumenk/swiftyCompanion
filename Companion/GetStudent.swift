//
//  RequestController.swift
//  Companion
//
//  Created by Nazar NAUMENKO on 5/2/19.
//  Copyright © 2019 Nazar NAUMENKO. All rights reserved.
//

import Foundation

class GetStudent: AsyncOperation {
    
    let token: String
    let login: String
    
    init(token: String, login: String) {
        self.token = token
        self.login = login
    }
    
    override func main() {
        
        if isCancelled {
            self.state = .finished
            return
        }
        
        guard let url = URL(string: "https://api.intra.42.fr/v2/users/" + login) else {
            self.state = .finished
            return
        }
        var requset = URLRequest(url: url)
        requset.httpMethod = "Get"
        requset.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        session.dataTask(with: requset) {data, response, error in
            print("Got RESPONSE")
            guard let data = data else {
                self.state = .finished
                return
            }
            guard let student: Student = try? JSONDecoder().decode(Student.self, from: data) else {
                self.state = .finished
                return
            }
            DataController.student = student
            self.state = .finished
        }.resume()
    }
}

//func quarryGetUser() {

