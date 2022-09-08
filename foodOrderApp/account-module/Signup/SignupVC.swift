//
//  SignupVC.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 8.09.2022.
//

import UIKit

class SignupVC: UIViewController {
    
    var signupPresenterObject:VtoP_SignupProtocol?

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupButton.setTitle("Hesap Oluştur", for: .normal)
        signupButton.setTitle("Hesap Oluşturuluyor", for: .disabled)
        
        SignupRouter.createModule(ref: self)

        // Do any additional setup after loading the view.
    }
    

    @IBAction func pressSignup(_ sender: Any) {
        signupButton.isEnabled = false
        signupButton.setTitle("Hesap Oluşturuluyor", for: .disabled)
        signupPresenterObject?.doSignup(name: nameField.text!, surname: surnameField.text!, phone: numberField.text!, email: emailField.text!, password: passwordField.text!)
        
    }
    
    
    @IBAction func pressBack(_ sender: Any) {
        dismiss(animated: true)
    }
}


extension SignupVC:PtoV_SignupProtocol{
    func resultSendtoView(result: String?) {
        guard (result == nil) else{
            signupButton.setTitle(result, for: .disabled)
            Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { _ in
                self.signupButton.isEnabled = true
                self.signupButton.setTitle("Hesap Oluşturuluyor", for: .disabled)
            })
            print(result!)
            return
        }
        print("Success")
    }
    
    
}
