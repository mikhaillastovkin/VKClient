//
//  ViewController.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 13.06.2021.
//

import UIKit
import RealmSwift

final class FriendsTableViewController: UIViewController {

    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var searchBarFriends: UISearchBar!
    
    let segueFromTableToCollection = "fromTableToCollection"
    let reuseIdentifierXibTableViewCell = "reuseIdentifierXibTableViewCell"

    let nwl = NetworkLayer()

    var friendsArray: Results<RealmUsers>?
    var notifationToken: NotificationToken?

    var savedIndexP = Int()
    var savedIndexS = Int()
    var searchFlag = Bool()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        friendsTableView.reloadData()

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notifationToken?.invalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        friendsTableView.dataSource = self
        friendsTableView.delegate = self
        searchBarFriends.delegate = self
        //searchResultArray = friendsArray
        
        friendsTableView.register(UINib(nibName: "XibTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierXibTableViewCell)

        loadFriends()

    }

    private func loadFriends(){
        nwl.getFriends(for: Singletone.share.idUser)
        friendsArray = try? RealmService.load(typeOf: RealmUsers.self).sorted(byKeyPath: "name")

        notifationToken = friendsArray?.observe { [weak self] changes in
            switch changes {
            case .initial(let objects):
                if objects.count > 0 {
                    self?.friendsTableView.reloadData()
                }
            case let .update(results, deletions, insertions, modifications):
                self?.friendsTableView.reloadData()
            case .error(let error):
                print(error)
            }
        }

    }

    private func loadSearchFriends(searchText: String){
        friendsArray = try? RealmService.load(typeOf: RealmUsers.self).filter(NSPredicate(format: "name CONTAINS[c] '\(searchText)'"))
    }
    
    @IBAction func unwindFromFriendToPhoto(_ sender: UIStoryboardSegue) {
//        if let source = sender.source as? FriendsCollectionViewController {
//            friendsArray[savedIndexP + savedIndexS].fotoArray = source.fotoArray
//        }
    }
    
//    func MyFriendsArray() -> [RealmUsers] {
//        if searchFlag {
//            return searchResultArray
//        }
//        return friendsArray
//    }
    
    
//    func ExtractFirstSymbol() -> [String] {
//        var resultArray = [String]()
//
//        for item in MyFriendsArray() {
//            let nameSymbol = String(item.name.prefix(1))
//            if !resultArray.contains(nameSymbol){
//                resultArray.append(nameSymbol)
//            }
//        }
//        return resultArray
//    }
    
//    func SymbolFilter(symbol: String) -> [RealmUsers] {
//        var resultArray = [RealmUsers]()
//
//        for item in MyFriendsArray() {
//            let nameSymbol = String(item.name.prefix(1))
//            if nameSymbol == symbol {
//                resultArray.append(item)
//            }
//        }
//        return resultArray
//    }
    
}

extension FriendsTableViewController: UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray?.count ?? 0
//        SymbolFilter(symbol: ExtractFirstSymbol()[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierXibTableViewCell, for: indexPath) as? XibTableViewCell,
              let unFriendArray = friendsArray?[indexPath.row] else {
            return UITableViewCell()
        }
//        let symblolFilterItem = SymbolFilter(symbol: ExtractFirstSymbol()[indexPath.section])
        
        cell.configure(user: unFriendArray)
         
        return cell
    }

}

extension FriendsTableViewController: UITableViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueFromTableToCollection,
           let dst = segue.destination as? FriendsCollectionViewController,
           let user = sender as? RealmUsers,
           let indexP = friendsTableView.indexPathForSelectedRow?.row,
           let indexS = friendsTableView.indexPathForSelectedRow?.section {
            dst.userID = String(user.id)
            savedIndexP = indexP
            savedIndexS = indexS
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = friendsTableView.cellForRow(at: indexPath) as? XibTableViewCell,
              let cellObject = cell.saveObject as? RealmUsers else {return}
        performSegue(withIdentifier: segueFromTableToCollection, sender: cellObject)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            loadFriends()

        } else {
            loadSearchFriends(searchText: searchText)
        }
        friendsTableView.reloadData()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBarFriends.endEditing(true)
    }
}
