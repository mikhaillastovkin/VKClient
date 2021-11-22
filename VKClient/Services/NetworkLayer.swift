//
//  NetworkLayoutLogin.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 07.10.2021.
//

import Foundation
import Alamofire
import RealmSwift

final class NetworkLayer {
    
    private let baseUrl = "https://api.vk.com/method"
    
    enum FilterNews: String {
        case post = "post"
        case photo = "photo"
        case all = "post, photo"
    }
    
    
    func getNewsFeed(filter: FilterNews, complition: @escaping ([VkNewsItems], [VkNewsGroups], [VkNewsProfiles]) -> Void) {
        var newsItems = [VkNewsItems]()
        var newsGroups = [VkNewsGroups]()
        var newsProfiles = [VkNewsProfiles]()

        let decodeVkNewsDG = DispatchGroup()
        let baseMethod = "/newsfeed.get"
        let parametrs: Parameters = [
            "access_token" : Singletone.share.token,
            "filters" : filter,
            "count" : 100,
            "v" : "5.131",
        ]
        AF.request(self.baseUrl + baseMethod, method: .get, parameters: parametrs).responseJSON { json in
            guard json.error == nil,
                  let jsonData = json.data
            else { return }
            DispatchQueue.global().async(group: decodeVkNewsDG) {
                do {
                    let items = try JSONDecoder().decode(VkNews<VkNewsResonseItems>.self, from: jsonData)
                    newsItems = items.response.items
                }
                catch { print(error) }
                do {
                    let groups = try JSONDecoder().decode(VkNews<VkNewsResonseGroups>.self, from: jsonData)
                    newsGroups = groups.response.groups
                }
                catch { print(error)}
                do {
                    let profiles = try JSONDecoder().decode(VkNews<VkNewsResonseProfiles>.self, from: jsonData)
                    newsProfiles = profiles.response.profiles
                }
                catch { print(error)}
            }
            decodeVkNewsDG.notify(queue: DispatchQueue.main) {
                complition(newsItems, newsGroups, newsProfiles)
            }
        }
    }
    
    func getFriends(
        for user: String) {
            let baseMethod = "/friends.get"
            let parametrs: Parameters = [
                "user_id" : Singletone.share.idUser,
                "fields" : "photo_50",
                "access_token" : Singletone.share.token,
                "v" : "5.131",]
            AF.request(baseUrl + baseMethod, method: .get, parameters: parametrs).responseJSON { json in
                guard json.error == nil, let jsonData = json.data else {
                    return
                }
                do {
                    let friends = try JSONDecoder().decode(VKResonse<Users>.self, from: jsonData)
                    let realmFriends = friends.response.items.map { RealmUsers(user: $0) }
                    DispatchQueue.main.async {
                        try? RealmService.save(items: realmFriends)
                    }
                } catch {
                    print(error)
                }
            }
        }
    
    func getFoto(
        for user: String) {
            let baseMethod = "/photos.getAll"
            let parametrs: Parameters = [
                "owner_id" : user,
                "extended" : true,
                "photo_sizes" : true,
                "skip_hidden" : true,
                "access_token" : Singletone.share.token,
                "v" : "5.131",]
            AF.request(baseUrl + baseMethod, method: .get, parameters: parametrs).responseJSON { json in
                guard json.error == nil,
                      let jsonData = json.data
                else { return }
                do {
                    let foto = try JSONDecoder().decode(VKResonsePhoto.self, from: jsonData)
                    let realmPhoto = foto.response.items.map { RealmPhoto(photo: $0, user: user)}
                    DispatchQueue.main.async {
                        try? RealmService.save(items: realmPhoto)
                    }
                } catch {
                    print(error)
                }
            }
        }
    
    func getGroup(
        for user: String) {
            let baseMethod = "/groups.get"
            let parametrs: Parameters = [
                "user_id" : user,
                "extended" : true,
                "access_token" : Singletone.share.token,
                "v" : "5.131",]
            AF.request(baseUrl + baseMethod, method: .get, parameters: parametrs).responseJSON { json in
                guard json.error == nil,
                      let jsonData = json.data
                else { return }
                do {
                    let groups = try JSONDecoder().decode(VKResonse<Groups>.self, from: jsonData)
                    let realmGroup = groups.response.items.map { RealmGroups(group: $0) }
                    DispatchQueue.main.async {
                        try? RealmService.save(items: realmGroup)
                        
                    }
                } catch {
                    print(error)
                }
            }
        }
    
    func getGroupSeach(groupName: String) {
        let baseMethod = "/groups.search"
        let parametrs: Parameters = [
            "q" : groupName,
            "access_token" : Singletone.share.token,
            "v" : "5.131",]
        AF.request(baseUrl + baseMethod, method: .get, parameters: parametrs).responseJSON { json in
            print(json)
        }
    }
    
}
