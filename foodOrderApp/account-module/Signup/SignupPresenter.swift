//
//  SignupPresenter.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 8.09.2022.
//

import Foundation

class SignupPresenter:VtoP_SignupProtocol{
    var signupInteractor: PtoI_SignupProtocol?
    
    var signupView: PtoV_SignupProtocol?
    
    func doSignup(name:String, surname:String, phone:String, email: String, password: String) {
        signupInteractor?.signup(name: name, surname: surname, phone: phone, email: email, password: password)
    }
    
}

extension SignupPresenter:ItoP_SignupProtocol{
    func resultSendtoPresenter(result: String?) {
        signupView?.resultSendtoView(result: result)
    }
    
    
}
