//
//  HomepageRouter.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 9.09.2022.
//

import Foundation

class HomepageRouter: PtoR_HomepageProtocol{
    static func createModule(ref: HomepageVC) {
        let presenter = HomepagePresenter()
        
        //View
        ref.homepagePresenterObject = presenter
        
        //Presenter
        ref.homepagePresenterObject?.homepageView = ref
        ref.homepagePresenterObject?.homepageInteractor = HomepageInteractor()
        
        //Interactor
        ref.homepagePresenterObject?.homepageInteractor?.homepagePresenter = presenter
        
    }
}
