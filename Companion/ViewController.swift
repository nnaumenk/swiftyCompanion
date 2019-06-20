//
//  ViewController.swift
//  Companion
//
//  Created by Nazar NAUMENKO on 5/2/19.
//  Copyright © 2019 Nazar NAUMENKO. All rights reserved.
//

import UIKit
import CoreGraphics

extension ViewController {
    
    func getStudent() -> Bool {
        let login = loginTextField.text!
        
        if login.isEmpty { return false }
        if login.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            print("inapropriate characters")
            return false
        }
        
        DataController.login = login.lowercased()
        
        let getStudent = GetStudent(token: DataController.token, login: DataController.login)
        let operationsQueue = OperationQueue()
        operationsQueue.addOperations([getStudent], waitUntilFinished: true)
        
        guard let status = DataController.statusCode else {
            print("Internet problem")
            return false
        }
        if status == 401 {
            print("status")
            let getToken = GetToken()
            let operationsQueue2 = OperationQueue()
            print(1)
            operationsQueue2.addOperations([getToken], waitUntilFinished: true)
            print(2)
            
            let getStudent = GetStudent(token: DataController.token, login: DataController.login)
            let operationsQueue3 = OperationQueue()
            operationsQueue3.addOperations([getStudent], waitUntilFinished: true)
            print("status =", DataController.statusCode as Any)
        }
        
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
        let getToken = GetToken()
        getToken.main()
        
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

















