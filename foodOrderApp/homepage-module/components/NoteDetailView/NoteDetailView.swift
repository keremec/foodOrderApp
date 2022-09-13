//
//  ViewController.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 12.09.2022.
//

import UIKit
import FirebaseAuth
import Alamofire

//MARK: - ViewController

class NoteDetailView: UIViewController {
    
    //MARK: - Declarations
    weak var delegateDetail:HomepageVC?
    var noteDetailPresenterObject:VtoP_NoteDetailProtocol?
    
    var note:Notes?
    var price:Double?
    var user:String?
    
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var boldLabelOutlet: UILabel!
    @IBOutlet weak var labelOutlet: UILabel!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var priceOutlet: UILabel!
    @IBOutlet weak var counterOutlet: UIButton!
    
    //MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        
        user = Auth.auth().currentUser?.uid
        
        super.viewDidLoad()
        NoteDetailRouter.createModule(ref: self)
        
        let yemek = NoteReq(yemek_adi: note?.note_title, yemek_resim_adi: note?.note_image_name, yemek_fiyat: Int((note?.note_price)!), yemek_siparis_adet: 1, kullanici_adi: user ?? nil)
        
        AF.request("http://kasimadalan.pe.hu/yemekler/resimler/" + yemek.yemek_resim_adi! ,method: .get).response { data in
            self.imageOutlet.image = UIImage(data: data.data!, scale:1)
        }
        
        boldLabelOutlet.text = yemek.yemek_adi
        labelOutlet.text = "Tam size göre bir lezzet"
        
        price = Double(yemek.yemek_fiyat!)
        priceOutlet.text = ("₺" + price!.cleanValue)
    }
    
    //MARK: - Widget Actions
    
    @IBAction func stepperAction(_ sender: Any) {
        let sumPrice = Double(round(100 * (price! * stepperOutlet.value))/100)
        counterOutlet.setTitle(stepperOutlet.value.cleanValue, for: .normal)
        priceOutlet.text = "₺" + sumPrice.cleanValue
    }
    
    @IBAction func addCartAction(_ sender: Any) {
        
        user = Auth.auth().currentUser?.uid

        if(user == nil){
            performSegue(withIdentifier: "carttoLogin", sender: nil)
        }
        else{
            let yemek = NoteReq(yemek_adi: note?.note_title, yemek_resim_adi: note?.note_image_name, yemek_fiyat: Int((note?.note_price)!), yemek_siparis_adet: Int(stepperOutlet.value), kullanici_adi: user)
            noteDetailPresenterObject?.doAddNote(note: yemek)
            dismiss(animated: true)
        }
        
    }
}
