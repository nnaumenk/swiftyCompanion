//
//  RequestController.swift
//  Companion
//
//  Created by Nazar NAUMENKO on 5/2/19.
//  Copyright © 2019 Nazar NAUMENKO. All rights reserved.
//

import Foundation

class GetStudent: AsyncOperation {
    
    let token: String?
    let login: String
    
    init(token: String?, login: String) {
        self.token = token
        self.login = login
    }
    
    
    func parseStatus(response: URLResponse?) {
        
        print("parseStatus")
        
        guard let response = response else {
            self.state = .finished
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            self.state = .finished
            return
        }
        
        let statusCode = httpResponse.statusCode
        print("status=", statusCode)
        if statusCode == 401 {
            print("Token expired")
            print("Recreation")
            print("token", DataController.token)
            let getToken = GetToken()
            let operationsQueue = OperationQueue()
            print("start")
            operationsQueue.addOperations([getToken], waitUntilFinished: true)
            print("end")
            print("token", DataController.token)
            //self.main()
        }
    }
    
    
    func parseStudent(data: Data?) {
        guard let data = data else {
            self.state = .finished
            return
        }
        guard let student: Student = try? JSONDecoder().decode(Student.self, from: data) else {
            print("student error")
            self.state = .finished
            return
        }
        DataController.student = student
        self.state = .finished
    }
    
    override func main() {
        
        print("selfToken", self.token)
        self.state = .executing
        if isCancelled {
            self.state = .finished
            return
        }
        
        guard let token = self.token else {
            self.state = .finished
            return
        }
        
        guard let url = URL(string: "https://api.intra.42.fr/v2/users/" + login) else {
            self.state = .finished
            return
        }
        print("Start request")
        var requset = URLRequest(url: url)
        requset.httpMethod = "Get"
        requset.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        session.dataTask(with: requset) {data, response, error in
            
            
            guard let response = response else {
                self.state = .finished
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                self.state = .finished
                return
            }
            
            let statusCode = httpResponse.statusCode
            if statusCode == 401
            {
                let getToken = GetToken()
                let operationsQueue = OperationQueue()
                self.state = .ready
                operationsQueue.addOperations([getToken], waitUntilFinished: true)
                print("end")
                print("token", DataController.token)
                self.main()
            }
            
            
            guard let data = data else {
                self.state = .finished
                return
            }
            guard let student: Student = try? JSONDecoder().decode(Student.self, from: data) else {
                print("student error")
                self.state = .finished
                return
            }
            DataController.student = student
            self.state = .finished
            
            
            
            
            
            
            
            
            
            
            
            
//            self.parseStatus(response: response)
//            print("ttoken", DataController.token)
//            self.state = .finished
//            self.parseStudent(data: data)
            
        }.resume()
    }
}

