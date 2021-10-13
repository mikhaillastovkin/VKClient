//
//  VKResponse.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 11.10.2021.
//

import Foundation
struct VKResonse<T: Decodable> : Decodable {
    let response : Response<T>

    enum CodingKeys: String, CodingKey {
        case response
    }

}

struct Response<T: Decodable> : Decodable {
    let items: [T]

    enum CodingKeys: String, CodingKey {
        case items = "items"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decode([T].self, forKey: .items)
    }

}


