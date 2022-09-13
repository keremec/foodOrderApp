//
//  NoteDetailRouter.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 13.09.2022.
//

import Foundation

class NoteDetailRouter: PtoR_NoteDetailProtocol{
    static func createModule(ref: NoteDetailView) {
        let presenter = NoteDetailPresenter()
        
        //View
        ref.noteDetailPresenterObject = presenter
        
        //Presenter
        ref.noteDetailPresenterObject?.noteDetailInteractor = NoteDetailInteractor()
        
    }
}
