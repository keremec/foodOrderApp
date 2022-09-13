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
        
        let refCategory = Database.database().reference().child("home/hero")
        
        refCategory.observe(.value, with: { snapshot in
            var list = [Heros]()
            var heroImage:UIImage?
            
            if let dataRec = snapshot.value as? [String:AnyObject]{
                for i in dataRec{
                    if let d = i.value as? NSDictionary{
                        let heroId = i.key
                        let heroTitle = d["name"] as? String ?? ""
                        let heroDesc = "Description"
                        let heroImgName = d["url"] as? String ?? ""
                        AF.request(heroImgName ,method: .get).response { data in
                            heroImage = UIImage(data: data.data!, scale:1)
                            let hero = Heros(heroId: Int(heroId) ?? -1 , heroTitle: heroTitle, heroDesc: heroDesc, heroImg: heroImage ?? UIImage())
                            if(hero.heroId != -1){
                                list.append(hero)
                                self.homepagePresenter?.heroSendtoPresenter(herolist: list)
                            }
                        }
                        
                    }
                }
            }
            
        })
    }
    
    
    func loadCategory() {
        let refCategory = Database.database().reference().child("home/category")
        
        refCategory.observe(.value, with: { snapshot in
            var list = [Categories]()
            var CategoryImage:UIImage?
            
            if let dataRec = snapshot.value as? [String:AnyObject]{
                for i in dataRec{
                    if let d = i.value as? NSDictionary{
                        let CategoryId = i.key
                        let CategoryTitle = d["name"] as? String ?? ""
                        let CategoryColor = "#DEDEDE"
                        let CategoryImgName = d["url"] as? String ?? ""
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
        var note_image:UIImage?
        
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).response { response in
            if let data = response.data {
                do{
                    let response = try JSONDecoder().decode(NoteResponse.self, from: data)
                    if let list = response.yemekler {
                        for i in list{
                            AF.request("http://kasimadalan.pe.hu/yemekler/resimler/" + i.yemekResimAdi! ,method: .get).response { data in
                                note_image = UIImage(data: data.data!, scale:1)
                                let n = Notes(note_id: Int(i.yemekID!) ?? -1, note_title: i.yemekAdi ?? "-1", note_detail: "Ağzınıza layık", note_image: note_image ?? UIImage(), note_image_name: i.yemekResimAdi ?? "-1", note_price: Double(i.yemekFiyat ?? "-1")!, note_status: true)
                                if(n.note_id != -1){
                                    noteList.append(n)
                                    self.homepagePresenter?.noteSendtoPresenter(noteList: noteList)
                                }
                            }
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        
        
    }
    
    
    
    func searchFood(searchString: String) {
        
    }
    
    
}
