//
//  HomepagePresenter.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 9.09.2022.
//

import Foundation
import UIKit

class HomepagePresenter:VtoP_HomepageProtocol{
    var homepageInteractor: PtoI_HomepageProtocol?
    
    var homepageView: PtoV_HomepageProtocol?
    
    
    func doloadHero() {
        homepageInteractor?.loadHero()
    }
    
    func doLoadCategory() {
        homepageInteractor?.loadCategory()
    }

    
    func doLoadNote() {
        homepageInteractor?.loadNote()
    }
    
    func doLoadNoteImage(noteImageString: String) {
        homepageInteractor?.loadNoteImage(noteImageString: noteImageString)
    }
    
    func doSearchFood(searchString: String) {
        homepageInteractor?.searchFood(searchString: searchString)
    }
    
    func doAddFood(food_id:Int,value:Bool) {
        homepageInteractor?.addFood(food_id: food_id, value: value)
    }
    
    
}

extension HomepagePresenter: ItoP_HomepageProtocol{
    func heroSendtoPresenter(herolist: Array<Heros>) {
        let list = herolist
        homepageView?.heroSendtoView(herolist: list)
    }
    
    func categorySendtoPresenter(categorylist: Array<Categories>) {
        let list = categorylist
        homepageView?.categorySendtoView(categorylist: list)
    }
    
    func noteSendtoPresenter(noteList: Array<Notes>) {
        let list = noteList
        homepageView?.noteSendtoView(noteList: list)
    }
    
    func noteImageSendtoPresenter(image: UIImage) {
        homepageView?.noteImageSendtoView(image: image)
    }
    
    
}

