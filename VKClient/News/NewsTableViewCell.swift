//
//  NewsTableViewCell.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 05.07.2021.
//

import UIKit


class NewsTableViewCell: UITableViewCell {
    
    var isLike = false
    var countLike = 0
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var fotoUser: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    
    
       
    
    func setup() {
        
    }
    
    func clearCell(){
        imageUser.image = nil
        nameUser.text = nil
        fotoUser.image = nil
        likeLabel.text = nil
        likeImage.image = nil
    }
    
    func configure(imageUsr: UIImage, nameUsr: String, fotoUsr: UIImage, likeLbl: Int, likeBtn: Bool) {
        imageUser.image = imageUsr
        nameUser.text = nameUsr
        fotoUser.image = fotoUsr
        likeLabel.text = String(likeLbl)
        if likeBtn {
            likeImage.image = UIImage(systemName: "heart.fill")
            likeImage.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            likeLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            isLike = true
        } else {
            likeImage.image = UIImage(systemName: "heart")
            isLike = false
            likeImage.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            likeLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
        
        
        countLike = likeLbl
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }
    
    
    @IBAction func pressLikeButton(_ sender: Any) {
        if !isLike {
            countLike += 1
            like()
            isLike = !isLike
        } else {
            countLike -= 1
            disLike()
            isLike = !isLike
        }
    }
    
    
    func like() {
        UIView.animate(withDuration: 0.5,
                       animations: { [weak self] in
                        self?.likeImage.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                        self?.likeLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                        self?.likeImage.bounds = CGRect(x: 2, y: 2, width: 20, height: 20)
                        self?.likeImage.image = UIImage(systemName: "heart.fill")
                        
                        },
                       completion: {_ in
                        UIView.transition(with: self.likeLabel,
                                          duration: 0.5,
                                          options: .transitionFlipFromBottom,
                                          animations: {
                                            self.likeLabel.text = String(self.countLike)
                                          },
                                          completion: nil)
                       })
        
        }
    
    
    func disLike() {
        UIView.animate(withDuration: 0.5,
                       animations: { [weak self] in
                        self?.likeImage.tintColor = .lightGray
                        self?.likeLabel.textColor = .lightGray
                        self?.likeImage.bounds = CGRect(x: 2, y: 2, width: 20, height: 20)
                        self?.likeImage.image = UIImage(systemName: "heart")
                        },
                       completion: { [weak self]_ in
                        guard let self = self else {return}
                        UIView.transition(with: self.likeLabel,
                                          duration: 0.5,
                                          options: .transitionFlipFromTop,
                                          animations: {
                                            self.likeLabel.text = String(self.countLike)
                                          },
                                          completion: nil)
                       })
        
    }
        
}





