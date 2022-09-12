//
//  ViewController.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 12.09.2022.
//

import UIKit
import FirebaseAuth
import Alamofire

class NoteDetailView: UIViewController {
    
    weak var delegateDetail:HomepageVC?
    
    var note:Notes?
    var price:Double?
    
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var boldLabelOutlet: UILabel!
    @IBOutlet weak var labelOutlet: UILabel!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var priceOutlet: UILabel!
    @IBOutlet weak var counterOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let yemek = NoteReq(yemek_adi: note?.note_title, yemek_resim_adi: note?.note_image, yemek_fiyat: Int((note?.note_price)!), yemek_siparis_adet: 1, kullanici_adi: Auth.auth().currentUser?.uid)
        
        AF.request("http://kasimadalan.pe.hu/yemekler/resimler/" + yemek.yemek_resim_adi! ,method: .get).response { data in
            self.imageOutlet.image = UIImage(data: data.data!, scale:1)
        }
        
        boldLabelOutlet.text = yemek.yemek_adi
        labelOutlet.text = "Tam size göre bir lezzet"
        
        price = Double(yemek.yemek_fiyat!)
        priceOutlet.text = ("₺" + price!.cleanValue)
    }
    
    @IBAction func stepperAction(_ sender: Any) {
        let sumPrice = Double(round(100 * (price! * stepperOutlet.value))/100)
        counterOutlet.setTitle(stepperOutlet.value.cleanValue, for: .normal)
        priceOutlet.text = "₺" + sumPrice.cleanValue
    }
    
    @IBAction func addCartAction(_ sender: Any) {
    }
}
