//
//  ActivityType.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 16/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

@objc(ActivityType)
public class ActivityType: NSManagedObject {
	
	init(acTID: Int, typeName: String, color1: String, color2: String) {
		let managedContext = DataModel.managedContext
		super.init(entity: NSEntityDescription.entity(forEntityName: "ActivityType", in: managedContext)!, insertInto: managedContext)
		self.acTID = Int32(acTID)
		self.typeName = typeName
		self.color1 = color1
		self.color2 = color2
	}
	
	init(json: JSON) {
		let managedContext = DataModel.managedContext
		super.init(entity: NSEntityDescription.entity(forEntityName: "ActivityType", in: managedContext)!, insertInto: managedContext)
		acTID = Int32(json["AcTID"].intValue)
		typeName = json["TypeName"].stringValue
		color1 = json["Color1"].stringValue
		color2 = json["Color2"].stringValue
	}
	
	override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
		super.init(entity: entity, insertInto: context)
	}
}
