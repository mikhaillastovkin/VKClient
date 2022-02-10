//
//  GroupsViewController.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 22.06.2021.
//

import UIKit
import RealmSwift

class GroupsViewController: UIViewController {

    @IBOutlet weak var groupsTableView: UITableView!

    var myGroups: Results<RealmGroups>?
    var notifationToken: NotificationToken?


    let nwl = NetworkLayer()
    let reuseIdentifierXibTableViewCell = "reuseIdentifierXibTableViewCell"
    
    override func viewWillAppear(_ animated: Bool) {
        self.groupsTableView.reloadData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notifationToken?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupsTableView.dataSource = self
        groupsTableView.delegate = self
        groupsTableView.register(UINib(nibName: "XibTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierXibTableViewCell)

//        NotificationCenter.default.addObserver(self, selector: #selector(addNewGroup(_:)), name: NSNotification.Name(rawValue: "sendGroup"), object: nil)

        loadGroup()

    }

    func loadGroup() {

        nwl.getGroup(for: Singletone.share.idUser)
            .map(on: .global()) { data in
                try JSONDecoder().decode(VKResonse<Groups>.self, from: data).response.items
            }
            .done(on: .main) { groups in
                let realmGroups = groups.map { RealmGroups(group: $0) }
                try RealmService.save(items: realmGroups)
            }
            .catch { error in
                print(error)
            }
        

        myGroups = try? RealmService.load(typeOf: RealmGroups.self).sorted(byKeyPath: "name")
        notifationToken = myGroups?.observe { [weak self] changes in
            switch changes {
            case .initial(let objects):
                if objects.count > 0 {
                    self?.groupsTableView.reloadData()
                }
            case let .update(results, deletions, insertions, modifications):
                self?.groupsTableView.reloadData()
            case .error(let error):
                print(error)
            }
        }

    }
    
//    func isContainInArray(group: Groups) -> Bool {
//        if myGroups.contains(where: { itemGroup in itemGroup.name == group.name}) {
//            return true
//        }
//        return false
//    }

//    @objc func addNewGroup(_ notification: Notification) {
//        guard let newGroup = notification.object as? Groups else {return}
//
//        if isContainInArray(group: newGroup) {
//            return
//        }
////        myGroups.append(newGroup)
//        self.groupsTableView.reloadData()
//        }
//    }
}

extension GroupsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierXibTableViewCell, for: indexPath) as? XibTableViewCell,
              let unMyGroups = myGroups?[indexPath.row]
        else {
            return UITableViewCell()
        }
        
       cell.configure(group: unMyGroups)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
