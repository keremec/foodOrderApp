//
//  SignupInteractor.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 8.09.2022.
//

import Foundation
import Firebase
import FirebaseAuth

class SignupInteractor:PtoI_SignupProtocol{
    var signupPresenter: ItoP_SignupProtocol?
    
    
    func signup(name:String, surname:String, phone:String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            var a = error
            if(a == nil){
                let refDatabase = Database.database().reference().child("profiles")
                let newEntry = ["name":name, "surname":surname, "phone":phone]
                refDatabase.child((authResult?.user.uid)!).setValue(newEntry)
            }
            let changeRequest = authResult?.user.createProfileChangeRequest()
            changeRequest?.displayName = name + " " + surname
            changeRequest?.commitChanges { error in
                a = error ?? a
            }
            self.signupPresenter?.resultSendtoPresenter(result: a?.localizedDescription)
        }
    }
    
    
}
