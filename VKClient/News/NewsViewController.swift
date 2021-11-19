//
//  NewsViewController.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 05.07.2021.
//

import UIKit

final class NewsViewController: UIViewController {

    var newsArray = [News]()
    
    @IBOutlet weak var newsTableView: UITableView!
    
    func  setupNews() -> [News] {
        var resultNewsArray = [News]()
        
        let firstNews = News(
            header: HeaderNews(datePost: Date(),
                               imageUser: "11",
                               nameUser: "Иван Иванов",
                               countViews: 20),
            text: TextNews(textNews: "Когда человек сознательно или интуитивно выбирает себе в жизни какую-то цель, жизненную задачу, он невольно дает себе оценку. По тому, ради чего человек живет, можно судить и о его самооценке - низкой или высокой. Если человек живет, чтобы приносить людям добро, облегчать их страдания, давать людям радость, то он оценивает себя на уровне этой своей человечности. Он ставит себе цель, достойную человека."),
            image: ImageNews(imageNews: nil),
            footer: FooterNews(countLikes: 16,
                               countShareds: 7,
                               countComments: 228))
        

        let secondNews = News(
            header: HeaderNews(datePost: Date(),
                               imageUser: "12",
                               nameUser: "Петр Петров",
                               countViews: 37),
            text: TextNews(textNews: "Когда человек сознательно или интуитивно выбирает себе в жизни какую-то цель, жизненную задачу, он невольно дает себе оценку. По тому, ради чего человек живет, можно судить и о его самооценке - низкой или высокой. Если человек живет, чтобы приносить людям добро, облегчать их страдания, давать людям радость, то он оценивает себя на уровне этой своей человечности. Он ставит себе цель, достойную человека."),
            image: ImageNews(imageNews: "7"),
            footer: FooterNews(countLikes: 5,
                               countShareds: 18,
                               countComments: 15))


        let thirdNews = News(
            header: HeaderNews(datePost: Date(),
                               imageUser: "13",
                               nameUser: "Семен Семенов",
                               countViews: 45),
            text: TextNews(textNews: nil),
            image: ImageNews(imageNews: "14"),
            footer: FooterNews(countLikes: 1,
                               countShareds: 98,
                               countComments: 2))
        
        resultNewsArray.append(firstNews)
        resultNewsArray.append(secondNews)
        resultNewsArray.append(thirdNews)
    
        return resultNewsArray
    }
    
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
        newsArray = setupNews()
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
            cell.configure(news: newsArray[indexPath.section].header)
            return cell


        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextTableViewCell.identifire,
                                                           for: indexPath) as? NewsTextTableViewCell
            else {
                return UITableViewCell()
            }
            cell.configure(news: newsArray[indexPath.section].text)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
            return cell

        case 2:

            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsImageTableViewCell.identifire,
                                                           for: indexPath) as? NewsImageTableViewCell
            else {
                return UITableViewCell()
            }

            cell.configure(image: newsArray[indexPath.section].image)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
            return cell

        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewFooterTableViewCell.identifire, for: indexPath) as? NewFooterTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(news: newsArray[indexPath.section].footer)
            return cell

        default:
            return UITableViewCell()
        }
    }

}



