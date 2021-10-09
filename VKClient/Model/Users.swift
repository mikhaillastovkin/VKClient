//
//  Users.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 27.06.2021.
//

import UIKit

struct Users {
    var name: String
    var avatar: UIImage
    var fotoArray: [Foto]
    
}

struct Foto {
    var foto: UIImage
    var countLikes: Int
    var isLikeOn = false
}


