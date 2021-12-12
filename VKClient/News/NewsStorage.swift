//
//  NewsStorage.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 21.11.2021.
//

import Foundation

final class NewsStorage {

    var dataFormate: DateFormatter {
        let dataFormate = DateFormatter()
        dataFormate.dateFormat = "d MMMM HH:mm"
        dataFormate.locale = Locale(identifier: "ru_RU")
        return dataFormate
    }

    private func getSourse(item: VkNewsItems, groups: [VkNewsGroups], profiles: [VkNewsProfiles]) -> String {
        var name = String()

        if item.sourceId < 0 {
            for group in groups {
                if group.id == abs(item.sourceId) {
                    name = group.name
                }
            }
        } else {
            for profile in profiles {
                if profile.id == item.sourceId {
                    name = "\(profile.firstName) \(profile.lastName)"
                }
            }
        }
        return name
    }

    private func getData(item: VkNewsItems) -> String {
        let date = dataFormate.string(from: item.date)
        return date
    }

    private func getSourseImage(item: VkNewsItems, groups: [VkNewsGroups], profiles: [VkNewsProfiles]) -> String {
        var sourseImage = String()

        if item.sourceId < 0 {
            for group in groups {
                if group.id == abs(item.sourceId) {
                    sourseImage = group.photo50
                }
            }
        } else {
            for profile in profiles {
                if profile.id == item.sourceId {
                    sourseImage = profile.photo50
                }
            }
        }
        return sourseImage
    }

    private func getImage(item: VkNewsItems) -> String {
        guard let attachments = item.attachments,
              let photos = attachments.first?.photo,
              let photo = photos.sizes.last?.url
        else { return "" }
        return photo
    }

    private func getIsLike(item: VkNewsItems) -> Bool {
        if item.likes.userLikes > 0 {
            return true
        } else {
            return false
        }
    }

    private func getIsReposted(item: VkNewsItems) -> Bool {
        if item.reposts.userReposted > 0 {
            return true
        } else {
            return false
        }

    }

    func getNews(_ items: [VkNewsItems], _ groups: [VkNewsGroups], _ profiles: [VkNewsProfiles]) -> [News] {
        var newsArray = [News]()
        for item in items {
            var sourse = String()
            var date = String()
            var image = String()
            var isLike = Bool()
            var isReposted = Bool()
            var sourseImg = String()
                sourse = self.getSourse(item: item, groups: groups, profiles: profiles)
                date = self.getData(item: item)
                isLike = self.getIsLike(item: item)
                isReposted = self.getIsReposted(item: item)
                image = self.getImage(item: item)
                sourseImg = self.getSourseImage(item: item, groups: groups, profiles: profiles)

                newsArray.append(News(
                    sourse: sourse,
                    sourseImg: sourseImg,
                    date: date,
                    view: String(item.views?.count ?? 0),
                    text: item.text,
                    image: image,
                    likeCount: String(item.likes.count),
                    isLike: isLike,
                    repostsCount: String(item.comments.count),
                    isReposted: isReposted,
                    commentCount: String(item.reposts.count)
                ))

        }
        return newsArray
    }
}
