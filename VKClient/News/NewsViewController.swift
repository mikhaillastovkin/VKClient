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
    var fromStart = String()
    var isLoading = false

    @IBOutlet weak var newsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        newsTableView.prefetchDataSource = self

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

        setRefreshControl()
        loadNews()

    }

    private func loadNews() {
        DispatchQueue.global().async {
            self.nwl.getNewsFeed(filter: .post, startFrom: nil) { [weak self] items, groups, profiles, startFrom  in
                guard let self = self else { return }
                self.fromStart = startFrom
                self.newsArray = self.newsStorage.getNews(items, groups, profiles)
                self.newsTableView.reloadData()
            }
        }
    }

    private func setRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(didRefresh),
            for: .valueChanged)
        newsTableView.refreshControl = refreshControl
    }

    @objc private func didRefresh() {
        loadNews()
        newsTableView.refreshControl?.endRefreshing()
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

extension NewsViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section}).max()
        else { return }
        if maxSection > newsArray.count - 3,
           !isLoading {
            isLoading = true
            nwl.getNewsFeed(filter: .post, startFrom: fromStart) { [weak self] items, groups, profiles, startFrom in
                guard let self = self else { return }
                self.fromStart = startFrom
                let indexSet = IndexSet(
                    integersIn: self.newsArray.count ..< self.newsArray.count + items.count)
                self.newsStorage.getNews(items, groups, profiles).forEach { self.newsArray.append($0)
                }
                self.newsTableView.insertSections(indexSet, with: .automatic)
                self.isLoading = false

            }
        }
    }

}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1 :
            if newsArray[indexPath.section].text == "" {
                return .leastNonzeroMagnitude
            } else {
                return 50
            }
        case 2 :
            let tableWight = tableView.bounds.width
            let news = self.newsArray[indexPath.section]
            let cellHeigh = tableWight * news.aspectRatio
            return cellHeigh
        default:
            return UITableView.automaticDimension
        }
    }
}



