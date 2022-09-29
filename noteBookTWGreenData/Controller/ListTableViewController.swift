//
//  ListTableViewController.swift
//  noteBookTWGreenData
//
//  Created by Vadim Igdisanov on 26.09.2022.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController {
    
    var user: [User] = []
    let urlForUsers = "https://randomuser.me/api/?results=25&inc=gender,name,email,picture,location,dob"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            getData()
        if user.isEmpty {
            getUsers()
        }
        print(user.count)
    }
    
    private func getUsers() {
        guard let url = URL(string: urlForUsers) else {return}
        NetworkService.shared.getData(url: url) { (results) in
            guard let results = results.results else {return}
            for result in results {
                guard let user = User(results: result) else {continue}
                self.saveUser(withUser: user)
            }
            self.tableView.reloadData()
        }
    }
    
    private func saveUser(withUser user: User) {
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: context) else {return}
        let userObject = UserEntity(entity: entity, insertInto: context)
        userObject.gMT = user.gMT
        userObject.age = user.age
        userObject.urlPhoto = user.urlPhoto
        userObject.dob = user.dob
        userObject.email = user.email
        userObject.timeZone = user.timeZone
        userObject.gender = user.gender
        userObject.name = user.name
        
        do {
            try context.save()
            self.user.append(user)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    private func getData() {
        let context = getContext()
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        var usersEntity:[UserEntity] = []
        do {
            usersEntity = try context.fetch(fetchRequest)
            for userEntity in usersEntity {
                let user = User(
                    name: userEntity.name ?? "",
                    gender: userEntity.gender ?? "",
                    email: userEntity.email ?? "",
                    urlPhoto: userEntity.urlPhoto ?? "",
                    dob: userEntity.dob ?? "",
                    age: userEntity.age ,
                    timeZone: userEntity.timeZone ?? "",
                    gmt: userEntity.gMT ?? "")
                self.user.append(user)
            }
            self.tableView.reloadData()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserInfo" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let userInfoVC = segue.destination as! UserInfoViewController
                userInfoVC.user = self.user[indexPath.row]
            }
        }
    }
}

// MARK: - Table view data source
extension ListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return user.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        
        if indexPath.row == self.user.count - 1 {
            getUsers()
        }
        
        if let listCell = cell as? ListTableViewCell {
            listCell.configure(user: user[indexPath.row])
        }
        return cell
    }
}
