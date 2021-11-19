//
//  NewsHeaderTableViewCell.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 14.11.2021.
//

import UIKit

final class NewsHeaderTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak private var imageUser: UIImageView!
    @IBOutlet weak private var nameUserLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!

    let dataFormate = DateFormatter()

    //MARK: Identifire cell
    static let identifire = "NewsHeaderTableViewCell"

    //MARK: - Life cell
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
        setupCell()
    }

    //MARK: Reuse cell
    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }

   //MARK: - Private methods
    private func clearCell() {
        imageUser.image = nil
        nameUserLabel.text = nil
        dateLabel.text = nil
    }

    private func setupCell() {
        imageUser.layer.cornerRadius = imageUser.bounds.width / 2
        imageUser.layer.masksToBounds = true
        imageUser.contentMode = .scaleAspectFill
        nameUserLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = .systemGray

    }

    //MARK: - Public configure methods
    func configure(news: HeaderNews) {
        imageUser.image = UIImage(named: news.imageUser)
        nameUserLabel.text = news.nameUser
        dataFormate.dateFormat = "d MMMM HH:mm"
        dataFormate.locale = Locale(identifier: "ru_RU")
        dateLabel.text = "\(dataFormate.string(from: news.datePost))  👁 \(String(news.countViews))"
    }
    
}
