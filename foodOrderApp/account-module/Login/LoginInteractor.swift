//
//  LoginInteractor.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 8.09.2022.
//

import Foundation
import FirebaseAuth

class LoginInteractor:PtoI_LoginProtocol{
    var loginPresenter: ItoP_LoginProtocol?
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            let a = error
            self!.loginPresenter?.resultSendtoPresenter(result: a?.localizedDescription)
        }
    }
    
    
}
