//
//  SignupRouter.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 8.09.2022.
//

import Foundation

class SignupRouter:PtoR_SignupProtocol{
    static func createModule(ref: SignupVC) {
        let presenter = SignupPresenter()
        
        //View
        ref.signupPresenterObject = presenter
        
        //Presenter
        ref.signupPresenterObject?.signupView = ref
        ref.signupPresenterObject?.signupInteractor = SignupInteractor()
        
        //Interactor
        ref.signupPresenterObject?.signupInteractor?.signupPresenter = presenter
    }
    
    
}
