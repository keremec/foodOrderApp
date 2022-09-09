//
//  HomepageInteractor.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 9.09.2022.
//

import Foundation

class HomepageInteractor:PtoI_HomepageProtocol{
    
    var homepagePresenter: ItoP_HomepageProtocol?
    
    
    
    init(){
    }
    
    func loadHero() {
        var HeroList = [Heros]()
        let tombraiderDesc = "Become the Tomb Raider"
        
        let h1 = Heros(heroId: 1, heroTitle: "Shadow of the Tomb Raider", heroDesc: tombraiderDesc, heroImgName: "placeholderhero")

        HeroList.append(h1)
        HeroList.append(h1)
        homepagePresenter?.heroSendtoPresenter(herolist: HeroList)
        
    }
    
    
    func loadCategory() {
        var CategoryList = [Categories]()
        let catName1 = "Hamburger"
        
        let cat1 = Categories(CategoryId: 1, CategoryTitle: catName1,CategoryColor: "#008745ff", CategoryImgName: "placeholdercategory")
        
        CategoryList.append(cat1)
        CategoryList.append(cat1)
        CategoryList.append(cat1)
        CategoryList.append(cat1)
        CategoryList.append(cat1)
        homepagePresenter?.categorySendtoPresenter(categorylist: CategoryList)
        
        
    }
    
    
    func loadNote() {
        var noteList = [Notes]()
        let n = Notes(note_id: 1, note_title: "Lorem", note_detail: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", note_price: "₺25.90", note_status: true)
        
        noteList.append(n)
        noteList.append(n)
        noteList.append(n)
        noteList.append(n)
        
        homepagePresenter?.noteSendtoPresenter(noteList: noteList)
        

    }
    
    
    func searchFood(searchString: String) {
        
    }
    
    
    func addFood(food_id: Int,value:Bool) {
        
    }
    
}
