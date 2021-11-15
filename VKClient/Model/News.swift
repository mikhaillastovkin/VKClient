//
//  News.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 05.07.2021.
//

import Foundation

struct News {

    let header: HeaderNews
    let text: TextNews
    let image: ImageNews
    let footer: FooterNews
}

struct HeaderNews {

    let datePost: Date
    let imageUser: String
    let nameUser: String
    let countViews: Int
}

struct TextNews {
    let textNews: String?
}

struct ImageNews {
    let imageNews: String?
}

struct FooterNews {
    let countLikes: Int
    let countShareds: Int
    let countComments: Int
}
