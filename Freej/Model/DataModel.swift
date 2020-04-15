//
//  DataModel.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 23/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

protocol DataModelProtocol {
	func userHasValidated()
}

class DataModel {
	static var currentUser: Student?
	
	static let appDelegate = UIApplication.shared.delegate as! AppDelegate
	static let managedContext = appDelegate.persistentContainer.viewContext
	
	static var dataModelDelegate: DataModelProtocol?
	
	static func setCurrentStudent(student: Student, saveToPersistent: Bool) {
		currentUser = student
		if(saveToPersistent) {
			let _ = saveCurrentUserToPersistent()
		}
	}
	
	//This method does not save in the persistent model, it only instantiates a student object
	static func createStudent(fromJSON: JSON?, isSignuedDB: Bool) -> Student? {
		if(fromJSON != nil) {
			let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
			let student = NSManagedObject(entity: entity, insertInto: managedContext)
			student.setValue(fromJSON!["UserID"].stringValue, forKeyPath: "userID")
			student.setValue(fromJSON!["BNo"].stringValue, forKeyPath: "bno")
			student.setValue(fromJSON!["FName"].stringValue, forKeyPath: "fName")
			student.setValue(fromJSON!["LName"].stringValue, forKeyPath: "lName")
			student.setValue(fromJSON!["KFUPMID"].stringValue, forKeyPath: "kfupmID")
			student.setValue(fromJSON!["Gender"].stringValue, forKeyPath: "gender")
			student.setValue(fromJSON!["Stat"].stringValue, forKeyPath: "stat")
			student.setValue(fromJSON!["IsAmeen"].boolValue, forKeyPath: "isAmeen")
			student.setValue(isSignuedDB, forKeyPath: "isSignedUpDB")
			return student as? Student
		}
		return nil
	}
	
	static func instantiateEmptyStudent() {
		let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
		let student = NSManagedObject(entity: entity, insertInto: managedContext)
		currentUser = student as? Student
	}
	
	static func userIsSignedUp() -> Bool {
		var userIsSignedUp: Bool
		currentUser?.userID == nil ? (userIsSignedUp = false) : (userIsSignedUp = true)
		return userIsSignedUp
	}
	
	static func saveCurrentUserToPersistent() -> Bool {
		if(currentUser != nil) {
			do {
				try managedContext.save()
				dataModelDelegate?.userHasValidated()
				return true
			} catch let error as NSError {
				print("Could not save. \(error), \(error.userInfo)")
				return false
			}
		}
		return false
	}
	
	static func clearCurrentUser() {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		
		let managedContext = appDelegate.persistentContainer.viewContext
		let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Student"))
		do {
			try managedContext.execute(DelAllReqVar)
		}
		catch {
			print(error)
		}
		
		//Remove Temporary (this session) currentUser
		currentUser = nil
	}
}
