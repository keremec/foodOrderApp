//
//  CartpagePresenter.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 14.09.2022.
//

import Foundation
import UIKit

class CartpagePresenter:VtoP_CartpageProtocol{
    var cartpageInteractor: PtoI_CartpageProtocol?
    
    var cartpageView: PtoV_CartpageProtocol?
    
    
    func doLoadNote(uid:String) {
        cartpageInteractor?.loadNote(uid: uid)
    }
    
    func doCleanCart(uid: String) {
        cartpageInteractor?.cleanCart(uid: uid)
    }
    func doRemoveNote(uid:String, noteID:Int){
        cartpageInteractor?.removeNote(uid:uid, noteID: noteID)
    }
    
    func doNewOrder(orderDate: String) {
        cartpageInteractor?.newOrder(orderDate: orderDate)
    }
    
    
}

extension CartpagePresenter: ItoP_CartpageProtocol{
    func countSendtoPresenter(count: Int) {
        cartpageView?.countSendtoView(count: count)
    }
    
    func priceSendtoPresenter(price: Double) {
        cartpageView?.priceSendtoView(price: price)
    }
    

    
    func noteSendtoPresenter(noteList: Array<Notes>) {
        let list = noteList
        cartpageView?.noteSendtoView(noteList: list)
    }
    
}

