//
//  News.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 05.07.2021.
//

import Foundation

struct News {
    let sourse: String
    let sourseImg: String
    let date: String
    let view: String
    let text: String
    let image: String
    let likeCount: String
    let isLike: Bool
    let repostsCount: String
    let isReposted: Bool
    let commentCount: String
}

//MARK: - VK News

struct VkNews<T: Decodable> : Decodable {
    let response : T

    enum CodingKeys: String, CodingKey {
        case response
    }

}

struct VkNewsResonseItems: Decodable {
    let items: [VkNewsItems]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items
        case nextFrom = "next_from"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decode([VkNewsItems].self, forKey: .items)
        nextFrom = try values.decode(String.self, forKey: .nextFrom)
    }

}

struct VkNewsResonseGroups: Decodable {
    let groups: [VkNewsGroups]

    enum CodingKeys: String, CodingKey {
        case groups
    }
}

struct VkNewsResonseProfiles: Decodable {
    let profiles: [VkNewsProfiles]

    enum CodingKeys: String, CodingKey {
        case profiles
    }
}


//MARK: - VK News Items
struct VkNewsItems: Decodable {
    let sourceId: Int
    let date: Date
    let text: String
    let comments: VkNewsComments
    let likes: VkNewsLikes
    let views: VkNewsViews?
    let reposts: VkNewsReposts
    let attachments: [VkNewsAttachments]?

    enum CodingCase: String, CodingKey {
        case sourceId = "source_id"
        case date
        case text
        case comments
        case likes
        case views
        case attachments
        case reposts
    }

    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingCase.self)
        sourceId = try value.decode(Int.self, forKey: .sourceId)
        date = try value.decode(Date.self, forKey: .date)
        text = try value.decode(String.self, forKey: .text)
        comments = try value.decode(VkNewsComments.self, forKey: .comments)
        likes = try value.decode(VkNewsLikes.self, forKey: .likes)
        views = try? value.decode(VkNewsViews.self, forKey: .views)
        attachments = try? value.decode([VkNewsAttachments].self, forKey: .attachments)
        reposts = try value.decode(VkNewsReposts.self, forKey: .reposts)
    }

}

//MARK: News Comments
struct VkNewsComments: Decodable {
    let count: Int

    enum CodingCase: String, CodingKey {
        case count
    }

    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingCase.self)
        count = try value.decode(Int.self, forKey: .count)
    }

}

//MARK: News Likes
struct VkNewsLikes: Decodable {
    let count: Int
    let userLikes: Int

    enum CodingCase: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }

    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingCase.self)
        count = try value.decode(Int.self, forKey: .count)
        userLikes = try value.decode(Int.self, forKey: .userLikes)
    }

}


//MARK: News Reposts
struct VkNewsReposts: Decodable {
    let count: Int
    let userReposted: Int

    enum CodingCase: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }

    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingCase.self)
        count = try value.decode(Int.self, forKey: .count)
        userReposted = try value.decode(Int.self, forKey: .userReposted)
    }

}

//MARK: News Views
struct VkNewsViews: Decodable {
    let count: Int

    enum CodingCase: String, CodingKey {
        case count
    }

    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingCase.self)
        count = try value.decode(Int.self, forKey: .count)
    }

}

//MARK: News Attachments
struct VkNewsAttachments: Decodable {
    let type: String
    let photo: VkNewsPhotos?

    enum CodingCase: String, CodingKey {
        case type
        case photo
    }

    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingCase.self)
        type = try value.decode(String.self, forKey: .type)
        photo = try? value.decode(VkNewsPhotos.self, forKey: .photo)
    }

}

//MARK: News Photos
struct VkNewsPhotos: Decodable {
    let sizes: [VkNewsPhotoSizes]

    enum CodingCase: String, CodingKey {
        case sizes
    }

    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingCase.self)
        sizes = try value.decode([VkNewsPhotoSizes].self, forKey: .sizes)
    }
}

//MARK: News Photo Sizes
struct VkNewsPhotoSizes : Decodable {
    let url : String
    let width : Int

    enum CodingKeys: String, CodingKey {
        case url
        case width
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decode(String.self, forKey: .url)
        width = try values.decode(Int.self, forKey: .width)
    }
}

//MARK: - Vk News Profiles

struct VkNewsProfiles: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo50: String

    enum CodingCase: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingCase.self)
        id = try values.decode(Int.self, forKey: .id)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        photo50 = try values.decode(String.self, forKey: .photo50)
    }
}

//MARK: - Vk News Groups

struct VkNewsGroups: Decodable {
    let id: Int
    let name: String
    let photo50: String

    enum CodingCase: String, CodingKey {
        case id
        case name = "name"
        case photo50 = "photo_50"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingCase.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        photo50 = try values.decode(String.self, forKey: .photo50)
    }

}
