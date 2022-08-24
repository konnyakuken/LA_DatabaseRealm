//
//  Memo.swift
//  DatabaseRealm
//
//  Created by 若宮拓也 on 2022/08/25.
//

import Foundation
import RealmSwift

class Memo: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
}
