//
//  HomeworkModel.swift
//  Homework
//
//  Created by Carlos Beltran on 12/26/14.
//  Copyright (c) 2014 Carlos. All rights reserved.
//

import Foundation
import CoreData

@objc(HomeworkModel)
class HomeworkModel: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var details: String

}
