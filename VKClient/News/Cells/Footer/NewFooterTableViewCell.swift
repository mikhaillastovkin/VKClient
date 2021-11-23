//
//  NewFooterTableViewCell.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 14.11.2021.
//

import UIKit

final class NewFooterTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak private var likeButton: UIButton!
    @IBOutlet weak private var likeLabel: UILabel!
    @IBOutlet weak private var commentButton: UIButton!
    @IBOutlet weak private var commentLabel: UILabel!
    @IBOutlet weak private var shareButton: UIButton!
    @IBOutlet weak private var shareLabel: UILabel!

    //MARK: Identifer cell
    static let identifire = "NewFooterTableViewCell"

    //MARK: Properties
    private let colorElements = UIColor.systemGray
    private let fontElements = UIFont.systemFont(ofSize: 18, weight: .bold)

    //MARK: Life cell
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
        likeLabel.text = nil
        commentLabel.text = nil
        shareLabel.text = nil
    }

    private func setupButton(_ button: UIButton, systemImage: String) {
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: systemImage), for: .normal)
        button.tintColor = colorElements
    }

    private func setupLabel(_ label: UILabel) {
        label.textColor = colorElements
        label.font = fontElements
    }

    private func setupCell() {
        setupButton(likeButton, systemImage: "heart")
        setupLabel(likeLabel)
        setupButton(shareButton, systemImage: "arrowshape.turn.up.right")
        setupLabel(shareLabel)
        setupButton(commentButton, systemImage: "bubble.left")
        setupLabel(commentLabel)
    }

    //MARK: - Public configure cell
    func configure(news: News) {
        likeLabel.text = news.likeCount
        shareLabel.text = news.repostsCount
        commentLabel.text = news.commentCount
    }

}
