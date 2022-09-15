//
//  CartpageProtocol.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 14.09.2022.
//

import Foundation
import UIKit

//MARK: Main Protocols

protocol VtoP_CartpageProtocol{
    var cartpageInteractor:PtoI_CartpageProtocol? {get set}
    var cartpageView:PtoV_CartpageProtocol? {get set}
    
    func doLoadNote(uid:String)
    func doCleanCart(uid:String)
    func doRemoveNote(uid:String, noteID:Int)
    func doNewOrder(orderDate:String)
}

protocol PtoI_CartpageProtocol{
    
    var cartpagePresenter:ItoP_CartpageProtocol? {get set}

    func loadNote(uid:String)
    func cleanCart(uid:String)
    func removeNote(uid:String, noteID:Int)
    func newOrder(orderDate:String)
}



// MARK: Transport Protocols

protocol ItoP_CartpageProtocol{
    func countSendtoPresenter(count:Int)
    func priceSendtoPresenter(price:Double)
    func noteSendtoPresenter(noteList:Array<Notes>)
    
}

protocol PtoV_CartpageProtocol{
    func countSendtoView(count:Int)
    func priceSendtoView(price:Double)
    func noteSendtoView(noteList:Array<Notes>)
}




//MARK: Router

protocol PtoR_CartpageProtocol{
    static func createModule(ref:CartpageVC)
}
