//
//  NewsViewController.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 05.07.2021.
//

import UIKit

class NewsViewController: UIViewController {
    
    let reuseIdentifireNewsViewCell = "reuseIdentifireNewsViewCell"
    var newsArray = [News]()
    
    @IBOutlet weak var newsTableView: UITableView!
    
    func  setupNews() -> [News] {
        var resultNewsArray = [News]()
        
        let firstNews = News(imageUser: UIImage(named: "2")!, nameUser: "Иван Иванов", fotoUser: UIImage(named: "11")!, likeButton: false, likeCount: 0)
        let secondNews = News(imageUser: UIImage(named: "4")!, nameUser: "Петр Петров", fotoUser: UIImage(named: "12")!, likeButton: true, likeCount: 2)
        let thirdNews = News(imageUser: UIImage(named: "7")!, nameUser: "Семен Семенов", fotoUser: UIImage(named: "13")!, likeButton: false, likeCount: 5)
        
        resultNewsArray.append(firstNews)
        resultNewsArray.append(secondNews)
        resultNewsArray.append(thirdNews)
    
        return resultNewsArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.dataSource = self
        newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifireNewsViewCell)
        newsArray = setupNews()

    }

}

extension NewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = newsTableView.dequeueReusableCell(withIdentifier: reuseIdentifireNewsViewCell, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(imageUsr: newsArray[indexPath.row].imageUser, nameUsr: newsArray[indexPath.row].nameUser, fotoUsr: newsArray[indexPath.row].fotoUser, likeLbl: newsArray[indexPath.row].likeCount, likeBtn: newsArray[indexPath.row].likeButton)
        
        
        return cell
        
    }
    
}

