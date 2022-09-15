//
//  Notes.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 9.09.2022.
//

import Foundation
import UIKit

class Notes{
    var note_id:Int?
    var note_title:String?
    var note_detail:String?
    var note_image:UIImage?
    var note_image_name:String?
    var note_price:Double?
    var note_count:Int?
    var note_status:Bool?
    init(note_id:Int,note_title:String,note_detail:String,note_image:UIImage,note_image_name:String?,note_price:Double?,note_count:Int = 1,note_status:Bool) {
        self.note_id = note_id
        self.note_title = note_title
        self.note_detail = note_detail
        self.note_image = note_image
        self.note_image_name = note_image_name
        self.note_price = note_price
        self.note_count = note_count
        self.note_status = note_status
    }
}
