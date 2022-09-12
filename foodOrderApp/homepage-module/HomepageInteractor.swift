//
//  HomepageInteractor.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 9.09.2022.
//

import UIKit
import Foundation
import Alamofire

class HomepageInteractor:PtoI_HomepageProtocol{
    
    var homepagePresenter: ItoP_HomepageProtocol?
    
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
        
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).response { response in
            if let data = response.data {
                do{
                    let response = try JSONDecoder().decode(NoteResponse.self, from: data)
                    if let list = response.yemekler {
                        for i in list{
                            let n = Notes(note_id: Int(i.yemekID!)!, note_title: i.yemekAdi!, note_detail: "Ağzınıza layık", note_image: i.yemekResimAdi!, note_price: Double(i.yemekFiyat!)!, note_status: true)
                            print(noteList.count)
                            noteList.append(n)
                        }
                    }
                    self.homepagePresenter?.noteSendtoPresenter(noteList: noteList)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        
        
    }
    
    
    func loadNoteImage(noteImageString: String){
        AF.request("http://kasimadalan.pe.hu/yemekler/resimler/" + noteImageString, method: .get).response { data in
            if let data = data.data{
                do{
                    if let image = UIImage(data: data, scale:1){
                        self.homepagePresenter?.noteImageSendtoPresenter(image: image)
                    }
                    else{
                        self.homepagePresenter?.noteImageSendtoPresenter(image: UIImage(systemName: "error")!)
                    }
                }
            }
        }
        
    }
    
    
    
    func searchFood(searchString: String) {
        
    }
    
    
    func addFood(food_id: Int,value:Bool) {
        
    }
}
