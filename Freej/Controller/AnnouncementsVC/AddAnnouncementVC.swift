//
//  AddAnnouncement.swift
//  Freej
//
//  Created by khaled khamis on 01/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import UIKit

class AddAnnouncementVC : UIViewController, UITextViewDelegate {
    @IBOutlet weak var ancmtTypeTF: UITextField!
	@IBOutlet weak var ancmtDescrp: UITextView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
    }
    
	@IBAction func addButton(_ sender: UIButton) {
		addAnnouncement()
	}
	
	func addAnnouncement() {
		var anTID = -1
		switch ancmtTypeTF.text! {
		case "General":
			anTID = 1
		case "Specific":
			anTID = 2
		default:
			anTID = 3
		}
		
		let ancmt = Announcement(anTID: anTID, userID: DataModel.currentUser?.userID ?? "NA", title: "title", descrp: ancmtDescrp.text, sDate: "i")
		
		ancmt.addToDatabase { (success) in
			print(success)
		}
		self.dismiss(animated: true, completion: nil)
	}
	
	func configureTextView() {
		ancmtDescrp.delegate = self
		ancmtDescrp.layer.borderWidth = 1
		ancmtDescrp.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		ancmtDescrp.layer.cornerRadius = 5
	}

	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if(text == "\n") {
			textView.resignFirstResponder()
			addAnnouncement()
			return true
		}
		return true
	}
}
