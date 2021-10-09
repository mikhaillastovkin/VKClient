//
//  Singletone.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 04.10.2021.
//

import Foundation

class Singletone {

    static var share = Singletone()

    private init() { }

    var token: String = ""
    var idUser: String = "0"

}
