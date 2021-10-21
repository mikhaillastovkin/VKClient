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

    func getFriends(
        for user: String) {
        let baseUrl = "https://api.vk.com/method"
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
                try RealmService.save(items: realmFriends)
            } catch {
                print(json)
            }
        }
    }

    func getFoto(
        for user: String) {
        let baseUrl = "https://api.vk.com/method"
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
                try RealmService.save(items: realmPhoto)
            } catch {
                print(json)
            }
        }
    }

    func getGroup(
        for user: String) {
        let baseUrl = "https://api.vk.com/method"
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
                try RealmService.save(items: realmGroup)
                } catch {
                print(json)
            }
        }
    }

    func getGroupSeach(groupName: String) {
        let baseUrl = "https://api.vk.com/method"
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
