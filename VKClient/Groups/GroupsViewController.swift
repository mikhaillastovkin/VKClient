//
//  GroupsViewController.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 22.06.2021.
//

import UIKit

class GroupsViewController: UIViewController {

    
    @IBOutlet weak var groupsTableView: UITableView!
    
    
    var myGroups = [Groups]()
    let nwl = NetworkLayer()

    
    let reuseIdentifierXibTableViewCell = "reuseIdentifierXibTableViewCell"
    
    override func viewWillAppear(_ animated: Bool) {
        self.groupsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupsTableView.dataSource = self
        groupsTableView.delegate = self
        
        groupsTableView.register(UINib(nibName: "XibTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierXibTableViewCell)
        
    
        NotificationCenter.default.addObserver(self, selector: #selector(addNewGroup(_:)), name: NSNotification.Name(rawValue: "sendGroup"), object: nil)

        loagGroup()


    }

    func loagGroup() {
        nwl.getGroup(for: Singletone.share.idUser) { [weak self] groups in
            guard
                let self = self else { return }
            print(groups)
            self.myGroups = groups.sorted(by: { $0.name < $1.name })
            self.groupsTableView.reloadData()
        }

    }
    
    func isContainInArray(group: Groups) -> Bool {
        if myGroups.contains(where: { itemGroup in itemGroup.name == group.name}) {
            return true
        }
        return false
    }
    
    
    @objc func addNewGroup(_ notification: Notification) {
        guard let newGroup = notification.object as? Groups else {return}
        
        if isContainInArray(group: newGroup) {
            return
        }
        myGroups.append(newGroup)
        self.groupsTableView.reloadData()
        }
    }


extension GroupsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierXibTableViewCell, for: indexPath) as? XibTableViewCell else {
            return UITableViewCell()
        }
        
       cell.configure(group: myGroups[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        myGroups.remove(at: indexPath.row)
        groupsTableView.deleteRows(at: [indexPath], with: .middle)
    }
    
    

    
}
