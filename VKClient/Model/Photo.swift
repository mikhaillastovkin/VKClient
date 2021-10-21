//
//  Photo.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 12.10.2021.
//

import Foundation
import RealmSwift

struct VKResonsePhoto: Decodable {
    let response : ResponsePhoto

    enum CodingKeys: String, CodingKey {
        case response = "response"
    }

}

struct ResponsePhoto: Decodable {
    let items : [Items]

    enum CodingKeys: String, CodingKey {
        case items = "items"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decode([Items].self, forKey: .items)
    }
}

struct Items : Decodable {
    let sizes : [Foto]
    let likes : Likes
    let id : Int

    enum CodingKeys: String, CodingKey {
        case sizes = "sizes"
        case likes = "likes"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sizes = try values.decode([Foto].self, forKey: .sizes)
        likes = try values.decode(Likes.self, forKey: .likes)
        id = try values.decode(Int.self, forKey: .id)
    }
}

struct Foto : Decodable {
    let src : String
    let width : Int

    enum CodingKeys: String, CodingKey {

        case url = "url"
        case width = "width"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        src = try values.decode(String.self, forKey: .url)
        width = try values.decode(Int.self, forKey: .width)
    }
}

struct Likes : Codable {
    let userlikes : Int
    let count : Int

    enum CodingKeys: String, CodingKey {

        case userlikes = "user_likes"
        case count = "count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userlikes = try values.decode(Int.self, forKey: .userlikes)
        count = try values.decode(Int.self, forKey: .count)
    }

}
