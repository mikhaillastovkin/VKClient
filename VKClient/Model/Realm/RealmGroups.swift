//
//  RealmGroups.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 19.10.2021.
//

import RealmSwift

class RealmGroups: Object {

    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted(indexed: true) var name: String = ""
    @Persisted var image: String = ""

}

extension RealmGroups {
    convenience init(group: Groups) {
        self.init()
        self.id = group.id
        self.name = group.name
        self.image = group.image
    }
}
