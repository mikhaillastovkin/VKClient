//
//  XibCollectionViewCell.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 22.06.2021.
//

import UIKit
import Nuke

protocol XibCollectionViewCellDelegate: AnyObject {
    func pressLikeButton(isLikeOn: Bool, indexOfPicture: Int)
}




class XibCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCoolectionViewCell: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
    
    var isLike = false
    var countLike = 0
    var indexOfPicture = 0
    
    weak var delegate: XibCollectionViewCellDelegate?
    
    
    func setup() {
    }
    
    
    func clearCell() {
        imageCoolectionViewCell.image = nil
        likesLabel.text = nil
        heartImageView.image = nil
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }
    
    
    func configure(image: RealmPhoto, indexOfPicture: Int) {
        self.indexOfPicture = indexOfPicture

        guard let urlPhoto = image.sizes.first?.src else { return }

        guard let url = URL(string: urlPhoto) else { return }
        Nuke.loadImage(with: url, into: imageCoolectionViewCell)
        likesLabel.text = String(image.count)
        
        if image.userlikes == 1 {
            heartImageView.image = UIImage(named: "like")
        }
        else {
            heartImageView.image = UIImage(named: "dontlike")
        }
        countLike = image.count
    }
    
    
    @IBAction func pressHeartButton(_ sender: Any) {
        if isLike == false {
            heartImageView.image = UIImage(named: "like")
            likesLabel.text = String(countLike + 1)
            countLike += 1
            isLike = !isLike
            likesLabel.textColor = UIColor.red
            delegate?.pressLikeButton(isLikeOn: isLike, indexOfPicture: self.indexOfPicture)
        } else {
            heartImageView.image = UIImage(named: "dontlike")
            likesLabel.text = String(countLike - 1)
            countLike -= 1
            isLike = !isLike
            likesLabel.textColor = UIColor.black
            delegate?.pressLikeButton(isLikeOn: isLike, indexOfPicture: self.indexOfPicture)
        }
    }
}
