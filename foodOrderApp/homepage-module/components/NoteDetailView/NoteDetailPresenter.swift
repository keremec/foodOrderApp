//
//  NoteDetailPresenter.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 13.09.2022.
//

import Foundation

class NoteDetailPresenter:VtoP_NoteDetailProtocol{
    var noteDetailInteractor: PtoI_NoteDetailProtocol?
    
    func doAddNote(note:NoteReq) {
        noteDetailInteractor?.addNote(note: note)
    }
    
}
