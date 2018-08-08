//
//  Category.swift
//  Todoey
//
//  Created by Timothy Platt on 08/08/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
