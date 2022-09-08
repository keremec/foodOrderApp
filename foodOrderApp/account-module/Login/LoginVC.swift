//
//  LoginVC.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 8.09.2022.
//

import UIKit
import FirebaseAuth
import CoreAudioTypes

class LoginVC: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    var loginPresenterObject:VtoP_LoginProtocol?

    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.setTitle("Giriş Yap", for: .normal)
        loginButton.setTitle("Giriş Yapılıyor", for: .disabled)

        LoginRouter.createModule(ref: self)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if(Auth.auth().currentUser != nil){
                self.loginButton.isEnabled = false
                self.dismiss(animated: true)
                self.dismiss(animated: true)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBAction func pressLogin(_ sender: Any) {
        loginButton.isEnabled = false
        loginPresenterObject?.doLogin(email: mailField.text!, password: passwordField.text!)
        
    }
    
}


extension LoginVC:PtoV_LoginProtocol{
    func resultSendtoView(result: String?) {
        guard (result == nil) else{
            loginButton.setTitle(result, for: .disabled)
            Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { _ in
                self.loginButton.isEnabled = true
                self.loginButton.setTitle("Giriş Yapılıyor", for: .disabled)
            })
            print(result!)
            return
        }
        print("Success")
    }
    
    
}
