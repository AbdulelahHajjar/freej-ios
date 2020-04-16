//
//  ActivityType.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 16/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ActivityType {
	let acTID:		Int
	let typeName:	String
	let color1Hex:	String
	let color2Hex:	String
	
	static var activityTypesArray: [ActivityType]?
	
	static func getActivityTypesArray(fromJSON: JSON) -> [ActivityType]? {
		var atArray = [ActivityType]()
		for at in fromJSON.array! {
			let dbAcTID =		at["AcTID"].intValue
			let dbTypeName =	at["TypeName"].stringValue
			let dbColor1Hex =	at["Color1"].stringValue
			let dbColor2Hex =	at["Color2"].stringValue
			print(dbAcTID)
			atArray.append(ActivityType(acTID: dbAcTID, typeName: dbTypeName, color1Hex: dbColor1Hex, color2Hex: dbColor2Hex))
		}
		activityTypesArray = atArray
		return atArray
	}
}