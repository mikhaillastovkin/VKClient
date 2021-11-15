//
//  NewsTextTableViewCell.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 15.11.2021.
//

import UIKit

final class NewsTextTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak private var textLabelCell: UILabel!

    //MARK: Identifire
    static let identifire = "NewsTextTableViewCell"

    //MARK: Lifi cell
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

    //MARK: - Private methodes
    private func clearCell() {
        textLabelCell.text = nil
    }

    private func setupCell() {
        textLabelCell.numberOfLines = 0
    }

    //MARK: - Public configure method
    func configure(news: TextNews) {
        textLabelCell.text = news.textNews
    }

}
