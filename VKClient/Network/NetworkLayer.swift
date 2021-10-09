//
//  NetworkLayoutLogin.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 07.10.2021.
//

import Foundation
import Alamofire

final class NetworkLayer {

    func getFriends() {
        let baseUrl = "https://api.vk.com/method"
        let baseMethod = "/friends.get"
        let parametrs: Parameters = [
            "user_id" : Singletone.share.idUser,
            "access_token" : Singletone.share.token,
            "v" : "5.131",]
        AF.request(baseUrl + baseMethod, method: .get, parameters: parametrs).responseJSON { json in
            print(json)
        }
    }

    func getFoto() {
        let baseUrl = "https://api.vk.com/method"
        let baseMethod = "/photos.getAll"
        let parametrs: Parameters = [
            "owner_id" : Singletone.share.idUser,
            "access_token" : Singletone.share.token,
            "v" : "5.131",]
        AF.request(baseUrl + baseMethod, method: .get, parameters: parametrs).responseJSON { json in
            print(json)
        }
    }

    func getGroup() {
        let baseUrl = "https://api.vk.com/method"
        let baseMethod = "/groups.get"
        let parametrs: Parameters = [
            "user_id" : Singletone.share.idUser,
            "access_token" : Singletone.share.token,
            "v" : "5.131",]
        AF.request(baseUrl + baseMethod, method: .get, parameters: parametrs).responseJSON { json in
            print(json)
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
