//
//  SignupInteractor.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 8.09.2022.
//

import Foundation
import FirebaseAuth

class SignupInteractor:PtoI_SignupProtocol{
    var signupPresenter: ItoP_SignupProtocol?
    
    func signup(name:String, surname:String, phone:String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            let a = error
            self.signupPresenter?.resultSendtoPresenter(result: a?.localizedDescription)
        }
    }
    
    
}
