//
//  HomepagePresenter.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 9.09.2022.
//

import Foundation

class HomepagePresenter:VtoP_HomepageProtocol{
    var homepageInteractor: PtoI_HomepageProtocol?
    
    var homepageView: PtoV_HomepageProtocol?
    
    
    func doloadHero() {
        homepageInteractor?.loadHero()
    }
    
    func doLoadCategory() {
        homepageInteractor?.loadCategory()
    }

    
    func doLoadFood() {
        homepageInteractor?.loadFood()
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
    
    func dataSendtoPresenter(foodList: Array<Foods>) {
        let list = foodList
        homepageView?.dataSendtoView(foodList: list)
    }
    
    
}

