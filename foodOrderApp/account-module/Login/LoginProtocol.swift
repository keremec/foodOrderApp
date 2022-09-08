//
//  LoginProtocol.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 8.09.2022.
//

import Foundation

//MARK: Main Protools

protocol VtoP_LoginProtocol{
    var loginInteractor : PtoI_LoginProtocol? {get set}
    var loginView : PtoV_LoginProtocol? {get set}
    
    func doLogin(email:String, password:String)
    
}

protocol PtoI_LoginProtocol{
    var loginPresenter:ItoP_LoginProtocol? {get set}
    func login(email:String, password:String)
    
}


//MARK: Transport Protools

protocol ItoP_LoginProtocol{
    func resultSendtoPresenter(result:String?)
    
}

protocol PtoV_LoginProtocol{
    func resultSendtoView(result:String?)
    
}

//MARK: Router
protocol PtoR_LoginProtocol{
    static func createModule(ref:LoginVC)
}
