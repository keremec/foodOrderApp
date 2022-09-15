//
//  CartpageInteractor.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 14.09.2022.
//

import UIKit
import Foundation
import Alamofire
import Firebase

class CartpageInteractor:PtoI_CartpageProtocol{
    
    var cartpagePresenter: ItoP_CartpageProtocol?
    
    func loadNote(uid:String) {
        var noteList = [Notes]()
        var noteCartPrice = 0.0
        var noteCartCount = 0
        var note_image:UIImage?
        let params:Parameters = ["kullanici_adi": uid]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: params).response { response in
            if let data = response.data {
                do{
                    print(response)
                    let response = try JSONDecoder().decode(CartResponse.self, from: data)
                    if let list = response.sepetYemekler {
                        for i in list{
                            AF.request("http://kasimadalan.pe.hu/yemekler/resimler/" + (i.yemekResimAdi ?? "ayran.png") ,method: .get).response { data in
                                note_image = UIImage(data: data.data!, scale:1)
                                let n = Notes(note_id: Int(i.sepetYemekID!) ?? -1, note_title: i.yemekAdi ?? "-1", note_detail: "Ağzınıza layık", note_image: note_image ?? UIImage(), note_image_name: i.yemekResimAdi ?? "-1", note_price: Double(i.yemekFiyat ?? "-1")!, note_count: Int(i.yemekSiparisAdet!)!, note_status: true)
                                if(n.note_id != -1){
                                    noteCartCount += n.note_count!
                                    noteCartPrice += n.note_price! * Double(n.note_count!)
                                    noteList.append(n)
                                    self.cartpagePresenter?.countSendtoPresenter(count: noteCartCount)
                                    self.cartpagePresenter?.priceSendtoPresenter(price: noteCartPrice)
                                    self.cartpagePresenter?.noteSendtoPresenter(noteList: noteList)
                                }
                            }
                        }
                    }
                }catch{
                    self.cartpagePresenter?.countSendtoPresenter(count: noteCartCount)
                    self.cartpagePresenter?.priceSendtoPresenter(price: noteCartPrice)
                    self.cartpagePresenter?.noteSendtoPresenter(noteList: noteList)
                    print(error.localizedDescription)
                }
            }
        }
        
        
    }
    
    
    func removeNote(uid:String, noteID:Int){
        
        let params:Parameters = ["sepet_yemek_id": noteID, "kullanici_adi": uid]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post,parameters: params).responseString { response in
            print(noteID)
        }
        
    }
    
    
    func cleanCart(uid: String) {
        
        let params:Parameters = ["kullanici_adi": uid]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: params).response { response in
            if let data = response.data {
                do{
                    let response = try JSONDecoder().decode(CartResponse.self, from: data)
                    if let list = response.sepetYemekler {
                        for i in list{
                            let cartID = Int(i.sepetYemekID!)!
                            let userID = i.kullaniciAdi!
                            self.removeNote(uid: userID, noteID: cartID)
                            
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func newOrder(orderDate: String) {
        if let user = Auth.auth().currentUser?.uid{
            var refOrder = Database.database().reference().child("profiles/\(user)/orders")
            let newOrderValue = ["order_date":orderDate]
            refOrder.childByAutoId().setValue(newOrderValue)
        }
    }
    
    
}


