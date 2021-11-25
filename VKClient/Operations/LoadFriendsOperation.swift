//
//  LoadFriendsOperation.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 25.11.2021.
//

import Foundation
import Alamofire


final class LoadFriendsOperation: AsyncOperation {

    let idUser: String
    var friends = [Users]()

    init (forUser: String) {
        self.idUser = forUser
    }

    private func getFriends(
        for user: String,
        complition: @escaping (VKResonse<Users>) -> Void) {
            let baseUrl = "https://api.vk.com/method"
            let baseMethod = "/friends.get"
            let parametrs: Parameters = [
                "user_id" : user,
                "fields" : "photo_50",
                "access_token" : Singletone.share.token,
                "v" : "5.131",]
            AF.request(baseUrl + baseMethod, method: .get, parameters: parametrs).responseJSON { json in
                guard json.error == nil, let jsonData = json.data else {
                    return
                }
                do {
                    let friends = try JSONDecoder().decode(VKResonse<Users>.self, from: jsonData)
                    complition(friends)

                } catch {
                    print(error)
                }
            }
        }

    override func main() {
        self.getFriends(for: idUser) { users in
            self.friends = users.response.items
            self.state = .finished
        }
    }

}
