//
//  MainTabbarController.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 27.06.2021.
//

import UIKit

class MainTabbarController: UITabBarController {
    
    func setupUser() -> [Users] {
        var resultArray = [Users]()
        
        let firstFotoArray = [Foto(foto: UIImage(named: "0")!, countLikes: 0), Foto(foto: UIImage(named: "1")!, countLikes: 0), Foto(foto: UIImage(named: "2")!, countLikes: 2)]
        let secondFotoArray = [Foto(foto: UIImage(named: "3")!, countLikes: 0), Foto(foto: UIImage(named: "4")!, countLikes: 3), Foto(foto: UIImage(named: "5")!, countLikes: 2)]
        let firdFotoArray = [Foto(foto: UIImage(named: "6")!, countLikes: 5), Foto(foto: UIImage(named: "7")!, countLikes: 0), Foto(foto: UIImage(named: "8")!, countLikes: 2)]
        let fourthFotoArray = [Foto(foto: UIImage(named: "3")!, countLikes: 5), Foto(foto: UIImage(named: "8")!, countLikes: 0), Foto(foto: UIImage(named: "4")!, countLikes: 2)]
        
        let fistUser = Users(name: "Иван Иванов", avatar: UIImage(named: "0")!, fotoArray: firstFotoArray)
        resultArray.append(fistUser)
        let secondUser = Users(name: "Петр Петров", avatar: UIImage(named: "3")!, fotoArray: secondFotoArray)
        resultArray.append(secondUser)
        let firdUser = Users(name: "Семен Семенов", avatar: UIImage(named: "6")!, fotoArray: firdFotoArray)
        resultArray.append(firdUser)
        let fourthUser = Users(name: "Сергей Сергеев", avatar: UIImage(named: "1")!, fotoArray: fourthFotoArray)
        resultArray.append(fourthUser)
        
        
        return resultArray
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let friendsNavigationController = self.viewControllers?.first as? UINavigationController,
           let friendsViewController = friendsNavigationController.viewControllers.first as? FriendsTableViewController {
            friendsViewController.cofirure(userArray: setupUser())
        }
        
        
    }
    
}
