//
//  SignupProtocol.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 8.09.2022.
//

import Foundation

//MARK: Main Protools

protocol VtoP_SignupProtocol{
    var signupInteractor : PtoI_SignupProtocol? {get set}
    var signupView : PtoV_SignupProtocol? {get set}
    
    func doSignup(name:String, surname:String, phone:String, email: String, password: String)
    
}

protocol PtoI_SignupProtocol{
    var signupPresenter:ItoP_SignupProtocol? {get set}
    func signup(name:String, surname:String, phone:String, email: String, password: String)
    
}


//MARK: Transport Protools

protocol ItoP_SignupProtocol{
    func resultSendtoPresenter(result:String?)
    
}

protocol PtoV_SignupProtocol{
    func resultSendtoView(result:String?)
    
}

//MARK: Router
protocol PtoR_SignupProtocol{
    static func createModule(ref:SignupVC)
}
