//
//  NewsTextTableViewCell.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 15.11.2021.
//

import UIKit

final class NewsTextTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak private var textLabelCell: UILabel! {
        didSet {
            textLabelCell.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private let offSet: CGFloat = 12.0

    //MARK: Identifire
    static let identifire = "NewsTextTableViewCell"

    //MARK: Lifi cell
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
        setupCell()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

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
        textLabelCell.backgroundColor = .systemBackground
        textLabelCell.isOpaque = true
    }

    private func calculateLabelSize(text: String, font: UIFont) -> CGSize {
        let maxWight = bounds.width - offSet * 2
        let textBlock = CGSize(width: maxWight, height: .greatestFiniteMagnitude)
        let rect = text.boundingRect(
            with: textBlock,
            attributes: [NSAttributedString.Key.font : font],
            context: nil)
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }

    private func textLabelFrame() {
        let textLabelFrame = calculateLabelSize(
            text: textLabelCell.text ?? "",
            font: textLabelCell.font)
        let textLabelX = offSet
        let textLabelOrigin = CGPoint(
            x: textLabelX,
            y: offSet)
        textLabelCell.frame = CGRect(
            origin: textLabelOrigin,
            size: textLabelFrame)
    }

    //MARK: - Public configure method
    func configure(news: News) {
        textLabelCell.text = news.text
        textLabelFrame()
    }

}
