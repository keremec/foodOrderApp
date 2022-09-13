//
//  NoteDetailInteractor.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 13.09.2022.
//

import Foundation
import Alamofire

class NoteDetailInteractor:PtoI_NoteDetailProtocol{
    
    func addNote(note:NoteReq) {
        print(note.kullanici_adi!)
        let params:Parameters = ["yemek_adi": note.yemek_adi!,"yemek_resim_adi":note.yemek_resim_adi!, "yemek_fiyat": note.yemek_fiyat!, "yemek_siparis_adet":note.yemek_siparis_adet!, "kullanici_adi":note.kullanici_adi!]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post,parameters: params).response { response in
            if let data = response.data {
                do{
                    let answer = try JSONSerialization.jsonObject(with: data)
                    print(answer)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
