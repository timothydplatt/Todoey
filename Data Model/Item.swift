//
//  Item.swift
//  Todoey
//
//  Created by Timothy Platt on 08/08/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateAdded : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
