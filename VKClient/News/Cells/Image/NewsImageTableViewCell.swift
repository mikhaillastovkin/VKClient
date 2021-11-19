//
//  NewsImageTableViewCell.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 15.11.2021.
//

import UIKit

final class NewsImageTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var imageCell: UIImageView!

    //MARK: Identifire
    static let identifire = "NewsImageTableViewCell"

    //MARK: Life cell
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        clearCell()
    }

    //MARK: Reuse cell
    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }

    //MARK: Private methods
    private func clearCell() {
        imageCell.image = nil
    }

    private func setupCell() {
        imageCell.contentMode = .scaleAspectFill
    }

    //MARK: - Public configure method
    func configure(image: ImageNews) {
        if let nameImage = image.imageNews {
            imageCell.image = UIImage(named: nameImage)
        } else {
            
        }
    }
}
