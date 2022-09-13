//
//  HomepageInteractor.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 9.09.2022.
//

import UIKit
import Foundation
import Alamofire
import Firebase

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
        let refCategory = Database.database().reference().child("home/category")

        refCategory.observe(.value, with: { snapshot in
            var list = [Categories]()
            var CategoryImage:UIImage?

            if let dataRec = snapshot.value as? [String:AnyObject]{
                print(dataRec)
                for i in dataRec{
                    if let d = i.value as? NSDictionary{
                        let CategoryId = i.key
                        let CategoryTitle = d["name"] as? String ?? ""
                        let CategoryColor = "#DEDEDE"
                        let CategoryImgName = d["url"] as? String ?? ""
                        print("link:")
                        print(CategoryImgName)
                        AF.request(CategoryImgName ,method: .get).response { data in
                            CategoryImage = UIImage(data: data.data!, scale:1)
                            let cat = Categories(CategoryId: Int(CategoryId) ?? -1 , CategoryTitle: CategoryTitle, CategoryColor: CategoryColor, CategoryImage: CategoryImage!)
                            if(cat.CategoryId != -1){
                                list.append(cat)
                                self.homepagePresenter?.categorySendtoPresenter(categorylist: list)
                            }
                        }
                        
                    }
                }
            }
            
        })
        
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
    

}
