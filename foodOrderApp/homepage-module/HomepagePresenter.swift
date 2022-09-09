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
    func dataSendtoPresenter(foodList: Array<Foods>) {
        var list = foodList
        homepageView?.dataSendtoView(foodList: list)
    }
    
    
}

