//
//  XibTableViewCell.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 22.06.2021.
//

import UIKit
import Nuke

class XibTableViewCell: UITableViewCell {
    
    @IBInspectable var shadowColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    @IBInspectable var shadowRadius: Int = 2
    @IBInspectable var shadowOpacity: Float = 0.5
    
    @IBOutlet weak var imageCellView: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    
    
    var saveObject: Any?
    
    func setup() {
        labelCell.font = .boldSystemFont(ofSize: 18)
        imageCell.layer.cornerRadius = 25
        imageCellView.layer.cornerRadius = 25
        imageCellView.layer.shadowColor = shadowColor.cgColor
        imageCellView.layer.shadowRadius = CGFloat(shadowRadius)
        imageCellView.layer.shadowOffset = CGSize(width: 2, height: 2)
        imageCellView.layer.shadowOpacity = shadowOpacity
        
    }
    
    
    func clearCell() {
        saveObject = nil
        imageView?.image = nil
        labelCell.text = nil
        
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
    
    
    
    func configure(image: UIImage?, text: String) {
        imageCell.image = image
        labelCell.text = text
    }
    
    
    func configure(user: Users) {
        saveObject = user
        labelCell.text = user.name
        guard let url = URL(string: user.photo) else { return }
        Nuke.loadImage(with: url, into: imageCell)
    }
    
    func configure(group: Groups) {
        saveObject = group

        guard let url = URL(string: group.image) else { return }
        Nuke.loadImage(with: url, into: imageCell)
        labelCell.text = group.name
    }
    
    
    @IBAction func pressAvatarButton(_ sender: Any) {
        
        animateAvatar()

    }
    
    
    
    
    func animateAvatar() {
        let animate = CASpringAnimation(keyPath: "transform.scale")
        animate.fromValue = 1
        animate.toValue = 0.9
        animate.stiffness = 500
        animate.mass = 5
        animate.duration = 1
        animate.fillMode = CAMediaTimingFillMode.forwards
        imageCellView.layer.add(animate, forKey: nil)
    }


    
    
    
}
