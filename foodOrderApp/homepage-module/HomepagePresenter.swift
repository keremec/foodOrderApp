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
    
    func doSearchFood(searchString: String) {
        homepageInteractor?.searchFood(searchString: searchString)
    }
    
    
}

extension HomepagePresenter: ItoP_HomepageProtocol{
    func heroSendtoPresenter(herolist: Array<Heros>) {
        let list = herolist
        homepageView?.heroSendtoView(herolist: list)
    }
    
    func categorySendtoPresenter(categorylist: Array<Categories>) {
        let list = categorylist
        print(list.count)
        homepageView?.categorySendtoView(categorylist: list)
    }
    
    func noteSendtoPresenter(noteList: Array<Notes>) {
        let list = noteList
        homepageView?.noteSendtoView(noteList: list)
    }
    
}

