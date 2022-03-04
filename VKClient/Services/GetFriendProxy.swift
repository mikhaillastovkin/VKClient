//
//  GetFriendProxy.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 04.03.2022.
//

import Foundation

final class GetFriendProxy: GetFriendProxyProtocol {

    let networkLayer: GetFriendProxyProtocol

    init(networkLayer: GetFriendProxyProtocol) {
        self.networkLayer = networkLayer
    }

    func getFriends(for user: String, complition: @escaping ([Users]) -> Void) {
        networkLayer.getFriends(for: user, complition: complition)
        print("Loaded friend list with proxy")
    }
}
