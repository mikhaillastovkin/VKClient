//
//  AllGroupsViewController.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 22.06.2021.
//

import UIKit

class AllGroupsViewController: UIViewController {
    
    @IBOutlet weak var allGroupsTableView: UITableView!
    
    var allGroups = [Groups]()
    
    func setupGroup() -> [Groups] {
        var resultArray = [Groups]()
        
        let firstGoup = Groups(title: "Любители поесть", image: UIImage(named: "11")!)
        resultArray.append(firstGoup)
        
        let secondGroup = Groups(title: "Любители поспать", image: UIImage(named: "12")!)
        resultArray.append(secondGroup)
        
        return resultArray
    }
    

    var allTestGroupNames = ["Любители поесть", "Любители поспать", "Любители читать", "Любители кино"]
    
    let reuseIdentifierXibTableViewCell = "reuseIdentifierXibTableViewCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.allGroupsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allGroups = setupGroup()
        
        allGroupsTableView.dataSource = self
        allGroupsTableView.delegate = self
        
        allGroupsTableView.register(UINib(nibName: "XibTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierXibTableViewCell)
        

        
    }


}

extension AllGroupsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierXibTableViewCell, for: indexPath) as? XibTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(group: allGroups[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? XibTableViewCell,
              let cellObject = cell.saveObject as? Groups else {return}
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sendGroup"), object: cellObject)
        self.navigationController?.popViewController(animated: true)
    }

    
}
