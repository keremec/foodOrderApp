//
//  HomepageProtocol.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 9.09.2022.
//

import Foundation
import UIKit



//MARK: Main Protocols

protocol VtoP_HomepageProtocol{
    var homepageInteractor:PtoI_HomepageProtocol? {get set}
    var homepageView:PtoV_HomepageProtocol? {get set}
    
    func doloadHero()
    func doLoadCategory()
    func doLoadNote()
    func doLoadNoteImage(noteImageString: String)
    func doSearchFood(searchString:String)
    func doAddFood(food_id:Int,value:Bool)
}

protocol PtoI_HomepageProtocol{
    
    var homepagePresenter:ItoP_HomepageProtocol? {get set}
    
    func loadHero()
    func loadCategory()
    func loadNote()
    func loadNoteImage(noteImageString: String)
    func searchFood(searchString:String)
    func addFood(food_id:Int,value:Bool)
}



// MARK: Transport Protocols

protocol ItoP_HomepageProtocol{
    func noteSendtoPresenter(noteList:Array<Notes>)
    func heroSendtoPresenter(herolist:Array<Heros>)
    func categorySendtoPresenter(categorylist:Array<Categories>)
    func noteImageSendtoPresenter(image:UIImage)
    
}

protocol PtoV_HomepageProtocol{
    func heroSendtoView(herolist:Array<Heros>)
    func categorySendtoView(categorylist:Array<Categories>)
    func noteSendtoView(noteList:Array<Notes>)
    func noteImageSendtoView(image:UIImage)
}




//MARK: Router

protocol PtoR_HomepageProtocol{
    static func createModule(ref:HomepageVC)
}
