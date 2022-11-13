//
//  ContentData+CoreDataProperties.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/11/02.
//
//

import Foundation
import CoreData


extension ContentData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContentData> {
        return NSFetchRequest<ContentData>(entityName: "ContentData")
    }

    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var notiTime: Date?
    @NSManaged public var tag: String?
    @NSManaged public var type: String?
    @NSManaged public var image: Data?

}

extension ContentData : Identifiable {

}
