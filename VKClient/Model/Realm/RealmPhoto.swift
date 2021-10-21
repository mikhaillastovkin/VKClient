//
//  RealmPhoto.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 19.10.2021.
//

import RealmSwift

class RealmPhoto: Object {

    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var sizes = List<RealmFoto>()
    @Persisted var userlikes : Int = 0
    @Persisted var count : Int = 0
    @Persisted var user : String = ""

}

extension RealmPhoto {
    convenience init(photo: Items, user: String) {
        self.init()
        self.id = photo.id
        let photos = photo.sizes.map({ RealmFoto(foto: $0)})
        self.sizes.append(objectsIn: photos)
        self.userlikes = photo.likes.userlikes
        self.count = photo.likes.count
        self.user = user
    }

}

class RealmFoto: Object {
    @Persisted var src: String = ""
    @Persisted var widh : Int = 0
//
    convenience init(foto: Foto) {
        self.init()
        self.src = foto.src
        self.widh = foto.width
    }
}


