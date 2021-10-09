//
//  ViewController.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 13.06.2021.
//

import UIKit

final class FriendsTableViewController: UIViewController {

    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var searchBarFriends: UISearchBar!
    
    let segueFromTableToCollection = "fromTableToCollection"
    let reuseIdentifierXibTableViewCell = "reuseIdentifierXibTableViewCell"

    let nwl = NetworkLayer()

    var friendsArray = [Users]()
    var searchResultArray = [Users]()
    var savedIndexP = Int()
    var savedIndexS = Int()
    var searchFlag = Bool()
    
    func cofirure(userArray: [Users]){
        self.friendsArray = userArray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        friendsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsTableView.dataSource = self
        friendsTableView.delegate = self
        searchBarFriends.delegate = self
        //searchResultArray = friendsArray
        
        friendsTableView.register(UINib(nibName: "XibTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierXibTableViewCell)

        nwl.getFriends()
        nwl.getFoto()
        nwl.getGroup()
        nwl.getGroupSeach(groupName: "Swift")
        
    }
    
    @IBAction func unwindFromFriendToPhoto(_ sender: UIStoryboardSegue) {
        if let source = sender.source as? FriendsCollectionViewController {
            friendsArray[savedIndexP + savedIndexS].fotoArray = source.fotoArray
        }
    }
    
    func MyFriendsArray() -> [Users] {
        if searchFlag {
            return searchResultArray
        }
        return friendsArray
    }
    
    
    func ExtractFirstSymbol() -> [String] {
        var resultArray = [String]()
        
        for item in MyFriendsArray() {
            let nameSymbol = String(item.name.prefix(1))
            if !resultArray.contains(nameSymbol){
                resultArray.append(nameSymbol)
            }
        }
        return resultArray
    }
    
    func SymbolFilter(symbol: String) -> [Users] {
        var resultArray = [Users]()
        
        for item in MyFriendsArray() {
            let nameSymbol = String(item.name.prefix(1))
            if nameSymbol == symbol {
                resultArray.append(item)
            }
        }
        return resultArray
    }
    
}

extension FriendsTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ExtractFirstSymbol().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SymbolFilter(symbol: ExtractFirstSymbol()[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierXibTableViewCell, for: indexPath) as? XibTableViewCell else {
            return UITableViewCell()
        }
        let symblolFilterItem = SymbolFilter(symbol: ExtractFirstSymbol()[indexPath.section])
        
        cell.configure(user: symblolFilterItem[indexPath.row])
         
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            friendsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension FriendsTableViewController: UITableViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueFromTableToCollection,
           let dst = segue.destination as? FriendsCollectionViewController,
           let user = sender as? Users,
           let indexP = friendsTableView.indexPathForSelectedRow?.row,
           let indexS = friendsTableView.indexPathForSelectedRow?.section {
            dst.fotoArray = user.fotoArray
            savedIndexP = indexP
            savedIndexS = indexS
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = friendsTableView.cellForRow(at: indexPath) as? XibTableViewCell,
              let cellObject = cell.saveObject as? Users else {return}
        performSegue(withIdentifier: segueFromTableToCollection, sender: cellObject)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ExtractFirstSymbol()[section].uppercased()
    }
    
}

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchFlag = false
        } else {
            searchFlag = true
            searchResultArray = friendsArray.filter({ userItem in
                userItem.name.lowercased().contains(searchText.lowercased())
            })
        }
        friendsTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBarFriends.endEditing(true)
    }
}
