//
//  Users.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 27.06.2021.
//

import Foundation

struct Users: Decodable {
    let firstName: String
    let id: Int
    let lastName: String
    let photo: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id = "id"
        case lastName = "last_name"
        case photo = "photo_50"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try values.decode(String.self, forKey: .firstName)
        self.id = try values.decode(Int.self, forKey: .id)
        self.lastName = try values.decode(String.self, forKey: .lastName)
        self.photo = try values.decode(String.self, forKey: .photo)
        name = "\(firstName) \(lastName)"
    }

}
