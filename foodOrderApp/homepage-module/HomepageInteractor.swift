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
        
        let h1 = Heros(heroId: 1, heroTitle: "lorem", heroDesc: "lorem", heroImgName: "promotion far")
        let h2 = Heros(heroId: 1, heroTitle: "lorem", heroDesc: "lorem", heroImgName: "promo2")
        
        HeroList.append(h1)
        HeroList.append(h2)
        homepagePresenter?.heroSendtoPresenter(herolist: HeroList)
        
    }
    
    
    func loadCategory() {
        var CategoryList = [Categories]()
        
        let cat1 = Categories(CategoryId: 1, CategoryTitle: "Burger",CategoryColor: "#008745ff", CategoryImgName: "burger")
        let cat2 = Categories(CategoryId: 1, CategoryTitle: "Pizza",CategoryColor: "#008745ff", CategoryImgName: "pizza")
        let cat3 = Categories(CategoryId: 3, CategoryTitle: "Tatlı",CategoryColor: "#008745ff", CategoryImgName: "tatli")
        let cat4 = Categories(CategoryId: 4, CategoryTitle: "İçecek",CategoryColor: "#008745ff", CategoryImgName: "icecek")
        let cat5 = Categories(CategoryId: 5, CategoryTitle: "Kebap",CategoryColor: "#008745ff", CategoryImgName: "kebap")
        let cat6 = Categories(CategoryId: 6, CategoryTitle: "Dünya",CategoryColor: "#008745ff", CategoryImgName: "dunya")
        CategoryList.append(cat1)
        CategoryList.append(cat2)
        CategoryList.append(cat3)
        CategoryList.append(cat4)
        CategoryList.append(cat5)
        CategoryList.append(cat6)
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
    
    
    func addNote(note:NoteReq) {
        print(note.yemek_fiyat)
        print(note.kullanici_adi)
    }
}
