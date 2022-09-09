//
//  HomepageProtocol.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 9.09.2022.
//

import Foundation



//MARK: Main Protocols

protocol VtoP_HomepageProtocol{
    var homepageInteractor:PtoI_HomepageProtocol? {get set}
    var homepageView:PtoV_HomepageProtocol? {get set}
    
    func doLoadFood()
    func doSearchFood(searchString:String)
    func doAddFood(food_id:Int,value:Bool)
}

protocol PtoI_HomepageProtocol{
    
    var homepagePresenter:ItoP_HomepageProtocol? {get set}
    
    func loadFood()
    func searchFood(searchString:String)
    func addFood(food_id:Int,value:Bool)
}



// MARK: Transport Protocols

protocol ItoP_HomepageProtocol{
    func dataSendtoPresenter(foodList:Array<Foods>)
    
}

protocol PtoV_HomepageProtocol{
    func dataSendtoView(foodList:Array<Foods>)
}




//MARK: Router

protocol PtoR_HomepageProtocol{
    static func createModule(ref:HomepageVC)
}
