//
//  Groups.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 27.06.2021.
//

import UIKit

struct Groups: Decodable {
    let id: Int
    let name: String
    let image: String


    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case photo = "photo_50"
    }

    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try value.decode(Int.self, forKey: .id)
        self.name = try value.decode(String.self, forKey: .name)
        self.image = try value.decode(String.self, forKey: .photo)
        
    }
}

//
//{
//"response": {
//"count": 616,
//"items": [{
//"id": 31480508,
//"name": "Пикабу",
//"screen_name": "pikabu",
//"is_closed": 0,
//"type": "page",
//"is_admin": 0,
//"is_member": 1,
//"is_advertiser": 0,
//"photo_50": "https://sun9-5.us...i7F9_vu-8.jpg?ava=1",
//"photo_100": "https://sun9-17.u...1fqgM7UiI.jpg?ava=1",
//"photo_200": "https://sun9-3.us...vQJ6Gew98.jpg?ava=1"
//}, {
