//
//  NewsViewController.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 05.07.2021.
//

import UIKit
final class NewsViewController: UIViewController {

    let newsStorage = NewsStorage()
    var newsArray = [News]()
    let nwl = NetworkLayer()
    
    @IBOutlet weak var newsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.dataSource = self
        newsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        newsTableView.register(
            UINib(nibName: NewsHeaderTableViewCell.identifire,
                  bundle: nil),
            forCellReuseIdentifier: NewsHeaderTableViewCell.identifire)
        newsTableView.register(
            UINib(nibName: NewsTextTableViewCell.identifire,
                  bundle: nil),
            forCellReuseIdentifier: NewsTextTableViewCell.identifire)
        newsTableView.register(
            UINib(nibName: NewsImageTableViewCell.identifire,
                  bundle: nil),
            forCellReuseIdentifier: NewsImageTableViewCell.identifire)
        newsTableView.register(
            UINib(nibName: NewFooterTableViewCell.identifire,
                  bundle: nil),
            forCellReuseIdentifier: NewFooterTableViewCell.identifire)

        DispatchQueue.global().async {
            self.nwl.getNewsFeed(filter: .post) { [weak self] items, groups, profiles in
                guard let self = self else { return }
                self.newsArray = self.newsStorage.getNews(items, groups, profiles)
                self.newsTableView.reloadData()
            }
        }
    }

}

extension NewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        newsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {

        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsHeaderTableViewCell.identifire,
                                                           for: indexPath) as? NewsHeaderTableViewCell
            else {
                return UITableViewCell()
            }
            cell.configure(news: newsArray[indexPath.section])
            return cell


        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextTableViewCell.identifire,
                                                           for: indexPath) as? NewsTextTableViewCell
            else {
                return UITableViewCell()
            }
            cell.configure(news: newsArray[indexPath.section])
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
            return cell

        case 2:

            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsImageTableViewCell.identifire,
                                                           for: indexPath) as? NewsImageTableViewCell
            else {
                return UITableViewCell()
            }

            cell.configure(image: newsArray[indexPath.section])
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
            return cell

        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewFooterTableViewCell.identifire, for: indexPath) as? NewFooterTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(news: newsArray[indexPath.section])
            return cell

        default:
            return UITableViewCell()
        }
    }

}



