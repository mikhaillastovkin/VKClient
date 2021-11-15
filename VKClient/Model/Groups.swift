//
//  Groups.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 27.06.2021.
//

import Foundation

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
