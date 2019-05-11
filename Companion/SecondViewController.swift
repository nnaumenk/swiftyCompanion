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

extension SecondViewController {
    func showMainInformation() {
        
        loadImage(string: student.imageURL)
        nameSurname.text = "\(student.firstName) \(student.lastName)"
        wallet.text = "\(student.wallet)"
        correctionPoints.text = "\(student.correctionPoint)"
        level.text = "\(student.cursusUsers[0].level)"
        pool.text = "\(student.poolMonth) \(student.poolYear)"
    }
    
    func showAdditionalInformation() {
        if let phone = student.phone {
            phoneTop.text = phone
        } else {
            phoneTop.text = "none"
        }
        
        emailTop.text = student.email
        
        if let location = student.location {
            locationTop.text = location + " - " + student.campus[0].name
        } else {
            locationTop.text = "unavailable - " + student.campus[0].name
        }
        let campusCount = student.campus.count
        if campusCount == 1 { return }
        for index in 1..<campusCount {
            locationTop.text = locationTop.text! + " | " + student.campus[index].name
        }
    }
}




extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case skillTable:
            return skills.count
            
        case projectTable:
            return allProjects.count
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case skillTable:
            let cell = tableView.dequeueReusableCell(withIdentifier: "skillCell") as! SkillCell
            
            cell.name.text = skills[indexPath.row].name
            return cell
            
        case projectTable:
            let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell") as! ProjectCell
            
            let projectUser = allProjects[indexPath.row]
            cell.name.text = projectUser.project.name
            
            if let mark = projectUser.finalMark { cell.mark.text = String(mark)}
            else { cell.mark.text = projectUser.status }
            
            if let validated = projectUser.validated {
                if validated { cell.mark.textColor = UIColor.green }
                else { cell.mark.textColor = UIColor.red }
            } else { cell.mark.textColor = UIColor.black }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case skillTable:
            return "Skills"
            
        case projectTable:
            return "Projects"
            
        default:
            return nil
        }
    }
}

extension SecondViewController {
  
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        let currentSelectedProject = sender as! ProjectUser
        let parentId = currentSelectedProject.project.id
        
        var currentChildProjects : [ProjectUser] = []
        
        for project in childProjects {
            if project.project.parentId! == parentId {
                currentChildProjects.append(project)
            }
        }
        
        let viewController = segue.destination as! ThirdViewController

        viewController.title = currentSelectedProject.project.name
        viewController.projects = currentChildProjects
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView != projectTable { return }
        
        let currentSelectedProject = allProjects[indexPath.row]
        let selecedProjectId = currentSelectedProject.project.id
        for project in childProjects {
            if project.project.parentId! == selecedProjectId{
                performSegue(withIdentifier: "segueToVC3", sender: currentSelectedProject)
                return
            }
        }
    }
    

}

extension SecondViewController {
    func projectsParser() {
        allProjects42 = student.projectsUsers.filter({
            if ($0.cursusIds.count == 0) { return false }
            if (!$0.cursusIds.contains(1)) { return false }
            return true
        })
        allProjectsPool = student.projectsUsers.filter({
            if ($0.cursusIds.count == 0) { return false }
            if (!$0.cursusIds.contains(4)) { return false }
            return true
        })
        
        childProjects42 = allProjects42.filter({
            if ($0.project.parentId == nil) { return false }
            return true
        })
        childProjectsPool = allProjectsPool.filter({
            if ($0.project.parentId == nil) { return false }
            return true
        })
        
        allProjects42 = allProjects42.filter({
            if ($0.project.parentId != nil) { return false }
            return true
        })
        allProjectsPool = allProjectsPool.filter({
            if ($0.project.parentId != nil) { return false }
            return true
        })
       
        allProjects = allProjects42
        childProjects = childProjects42
    }
}

extension SecondViewController {
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            level.text = String(student.cursusUsers[0].level)
            skills = student.cursusUsers[0].skills
            allProjects = allProjects42
            childProjects = childProjects42
            
        case 1:
            level.text = String(student.cursusUsers[1].level)
            skills = student.cursusUsers[1].skills
            allProjects = allProjectsPool
            childProjects = childProjectsPool
            
        default:
            break
        }
        skillTable.reloadData()
        projectTable.reloadData()
    }
}

class SecondViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameSurname: UILabel!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var correctionPoints: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var pool: UILabel!
    
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var phoneTop: UILabel!
    @IBOutlet weak var phoneBottom: UILabel!
    
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var emailTop: UILabel!
    @IBOutlet weak var emailBottom: UILabel!
    
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var locationTop: UILabel!
    @IBOutlet weak var locationBottom: UILabel!
    
    @IBOutlet weak var skillTable: UITableView!
    @IBOutlet weak var projectTable: UITableView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    
    var student: Student!
    
    var skills: [Skill]!
    var allProjects: [ProjectUser]!
    var childProjects: [ProjectUser]!
    
    var allProjects42: [ProjectUser]!
    var childProjects42: [ProjectUser]!
    
    var allProjectsPool: [ProjectUser]!
    var childProjectsPool: [ProjectUser]!
    
    func checkPoolFailed() {
        if student.cursusUsers.count != 1 { return }
        
        segmentController.selectedSegmentIndex = 1
        segmentController.setEnabled(false, forSegmentAt: 0)
        swap(&allProjects42, &allProjectsPool)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = DataController.login
        self.navigationController?.isNavigationBarHidden = false

        if DataController.student == nil { return }
        
        student = DataController.student!
        skills = student.cursusUsers[0].skills
        projectsParser()
        checkPoolFailed()
        showMainInformation()
        showAdditionalInformation()
        //emailBottom.textColor = UIColor.blue
        
//        image.layer.cornerRadius = (image.frame.size.height + image.frame.size.width) / 8
//        image.layer.masksToBounds = true
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        DataController.student = nil
    }
}
