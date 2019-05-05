//
//  SecondViewController.swift
//  Companion
//
//  Created by Nazar NAUMENKO on 5/3/19.
//  Copyright © 2019 Nazar NAUMENKO. All rights reserved.
//

import UIKit

extension SecondViewController {
    func loadImage(string: String) {
        guard let url = URL(string: string) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) {data, response, error in
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async{ self.image.image = image }
            }.resume()
    }
}

extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentInformationCell") as! StudentInformationCell
        //let student = DataController.student!
        
        cell.labelDown.text = "123"
        cell.labelUp.text = "123"
        cell.imageIcon.image = #imageLiteral(resourceName: "background")
        
        
//        switch indexPath.row {
//        case 0:
//            cell.labelUp.text = student.phone
//        case 1:
//            cell.labelUp.text = student.email
//        default:
//            if let location = student.location {
//                cell.labelUp.text = "123"
//            }
//            else {
//                cell.labelUp.text = "Unavailable"
//            }
           // cell.labelUp.text = "123"
            
//        }
        return cell
    }
    
    
}

class SecondViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameSurname: UILabel!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var correctionPoints: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var pool: UILabel!
    
    @IBOutlet weak var loginInformationTable: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = DataController.login
        self.navigationController?.isNavigationBarHidden = false

        let student = DataController.student!
        loadImage(string: student.imageURL)
        nameSurname.text = "\(student.firstName) \(student.lastName)"
        wallet.text = "\(student.wallet)"
        correctionPoints.text = "\(student.correctionPoint)"
        level.text = "\(student.cursusUsers[0].level)"
        pool.text = "\(student.poolMonth) \(student.poolYear)"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
       // DataController.student = nil
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "segueToVC3" else { return }
//        guard let vc = segue.destination as? ThirdViewController else { return }
//        vc.img = image.image
//    }
    
}
