//
//  RealmUsers.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 19.10.2021.
//

import RealmSwift

class RealmUsers: Object {

    @Persisted var firstName: String = ""
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var lastName: String = ""
    @Persisted var photo: String = ""
    @Persisted(indexed: true) var name: String = ""

}

extension RealmUsers {
    convenience init(user: Users) {
        self.init()
        self.firstName = user.firstName
        self.id = user.id
        self.lastName = user.lastName
        self.photo = user.photo
        self.name = user.name
    }

}
