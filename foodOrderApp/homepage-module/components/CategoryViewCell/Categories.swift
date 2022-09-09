//
//  Categories.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 9.09.2022.
//

import Foundation

class Categories{
    internal init(CategoryId: Int, CategoryTitle: String, CategoryColor: String, CategoryImgName: String) {
        self.CategoryId = CategoryId
        self.CategoryTitle = CategoryTitle
        self.CategoryColor = CategoryColor
        self.CategoryImgName = CategoryImgName
    }
    
    
    var CategoryId:Int?
    var CategoryTitle:String?
    var CategoryColor:String?
    var CategoryImgName:String?
}

