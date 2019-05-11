//
//  ViewController.swift
//  Companion
//
//  Created by Nazar NAUMENKO on 5/2/19.
//  Copyright © 2019 Nazar NAUMENKO. All rights reserved.
//

import UIKit
import CoreGraphics

//extension ViewController {
//    func getToken() {
//        let uid = "990f3ad71fc7d2130681e6b5b73f48c43c5f1dba4b239853f9a1c2efd17dc116"
//        let secret = "cc1ac6f86f61e96795af75120f028079a3ec0f5083b037c3eb6ce84e1c702b01"
//        let grantType = "grant_type=client_credentials&client_id=\(uid)&client_secret=\(secret)"
//
//        guard let url = URL(string: "https://api.intra.42.fr/oauth/token?") else { return }
//        var requset = URLRequest(url: url)
//        requset.httpMethod = "POST"
//        requset.httpBody = grantType.data(using: .utf8)
//        let session = URLSession.shared
//        session.dataTask(with: requset) {data, response, error in
//            guard let data = data else { return }
//            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else { return }
//            print("json", json)
//            guard let dictionary = json as? NSDictionary else { return }
//            guard let token = dictionary["access_token"] as? String else { return }
//            DataController.token = token
//            print("token=", DataController.token!)/////
//            }.resume()
//    }
//}

extension ViewController {
    func getStudent() -> Bool{
        let login = loginTextField.text!
        
        if login.isEmpty { return false }
        if login.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            print("inapropriate characters")
            return false
        }
        
        DataController.login = login
        guard let token = DataController.token else { return false }
        let getStudent = GetStudent(token: token, login: login)
        let operationsQueue = OperationQueue()
        operationsQueue.addOperations([getStudent], waitUntilFinished: true)
        if DataController.student == nil {
            print("no student with such login")
            return false
        }
        return true
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let getToken = GetToken()
        //getToken.main()
        
        DataController.token = "123"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func buttonSearchPressed(_ sender: UIButton) {
        if getStudent() {
            print("SEGUE")
            self.performSegue(withIdentifier: "segueToVC2", sender: nil)
        }
    }
    
    @IBAction func enterPressed(_ sender: UITextField) {
        if getStudent() {
            print("SEGUE")
            self.performSegue(withIdentifier: "segueToVC2", sender: nil)
        }
    }
}

















