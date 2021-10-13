//
//  NetworkLayoutLogin.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 07.10.2021.
//

import Foundation
import Alamofire

final class NetworkLayer {

    func getFriends(
        for user: String,
        complition: @escaping ([Users]) -> Void) {
        let baseUrl = "https://api.vk.com/method"
        let baseMethod = "/friends.get"
        let parametrs: Parameters = [
            "user_id" : Singletone.share.idUser,
            "fields" : "photo_50",
            "access_token" : Singletone.share.token,
            "v" : "5.131",]
        AF.request(baseUrl + baseMethod, method: .get, parameters: parametrs).responseJSON { json in
            guard json.error == nil, let jsonData = json.data else {
                return complition([])
            }
            do {
                let friends = try JSONDecoder().decode(VKResonse<Users>.self, from: jsonData)
                DispatchQueue.main.async {
                    complition(friends.response.items)
                }
            } catch {
                print(json.error)
            }
        }
    }

    func getFoto(
        for user: String,
        complition: @escaping ([Items]) -> Void) {
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
            else { return complition([])}
            do {
                let foto = try JSONDecoder().decode(VKResonsePhoto.self, from: jsonData)
                DispatchQueue.main.async {
                    complition(foto.response.items)
                }
            } catch {
                print(json.error)

            }
        }
    }

    func getGroup(
        for user: String,
        complition: @escaping ([Groups]) -> Void) {
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
            else { return complition([])}
            do {
                let groups = try JSONDecoder().decode(VKResonse<Groups>.self, from: jsonData)
                DispatchQueue.main.async {
                    complition(groups.response.items)
                }
            } catch {
                print(json.error)
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
