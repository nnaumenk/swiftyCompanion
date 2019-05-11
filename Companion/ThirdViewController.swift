//
//  ThirdViewController.swift
//  Companion
//
//  Created by Nazar NAUMENKO on 5/5/19.
//  Copyright © 2019 Nazar NAUMENKO. All rights reserved.
//

import UIKit

extension ThirdViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count", projects.count)
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parentProjectCell") as! ParentProjectCell
        
        let projectUser = projects[indexPath.row]
        cell.name.text = projectUser.project.name
        
        if let mark = projectUser.finalMark { cell.mark.text = String(mark)}
        else { cell.mark.text = projectUser.status }
        
        if let validated = projectUser.validated {
            if validated { cell.mark.textColor = UIColor.green
            }
            else { cell.mark.textColor = UIColor.red }
        } else { cell.mark.textColor = UIColor.yellow }
        return cell
    }
    
    
    
}

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var projectTable: UITableView!
    
    var projects : [ProjectUser]!
    

}
