//
//  LoadFriendsToRealmOperation.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 25.11.2021.
//

import Foundation
import RealmSwift

final class LoadFriendsToRealmOperation: AsyncOperation {

    override func main() {
        guard let loadFriendsOperation = dependencies.first as? LoadFriendsOperation,
              !isCancelled
        else { return }

        let loadFriends = loadFriendsOperation.friends
        let realmFriends = loadFriends.map { RealmUsers(user: $0)}
        try? RealmService.save(items: realmFriends)
        self.state = .finished
    }
    
}
