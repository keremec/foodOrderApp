//
//  LoginPresenter.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 8.09.2022.
//

import Foundation

class LoginPresenter:VtoP_LoginProtocol{
    var loginInteractor: PtoI_LoginProtocol?
    
    var loginView: PtoV_LoginProtocol?
    
    func doLogin(email: String, password: String) {
        loginInteractor?.login(email: email, password: password)
    }
    
}

extension LoginPresenter:ItoP_LoginProtocol{
    func resultSendtoPresenter(result: String?) {
        loginView?.resultSendtoView(result: result)
    }
    
    
}
