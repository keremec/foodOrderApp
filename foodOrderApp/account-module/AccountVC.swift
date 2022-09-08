//
//  AccountVC.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 8.09.2022.
//

import UIKit
import FirebaseAuth

class AccountVC: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var ordersButton: UIButton!
    @IBOutlet weak var walletButton: UIButton!
    @IBOutlet weak var setttingsButton: UIButton!
    @IBOutlet weak var authButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let status = (Auth.auth().currentUser != nil) ? true : false
        loadUser(status: status)

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func authButton(_ sender: Any) {
        authButton.isEnabled = false
        let status = (Auth.auth().currentUser != nil) ? true : false
        if(status){
            signOut()
        }
        else{
            signIn()
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in
                self.authButton.isEnabled = true
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            let status = (Auth.auth().currentUser != nil) ? true : false
            self.loadUser(status: status)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}


extension AccountVC{
    
    func loadUser(status:Bool){
        addressButton.isEnabled = status
        ordersButton.isEnabled = status
        walletButton.isEnabled = status
        setttingsButton.isEnabled = status
        
        let titleActive = status ? "Çıkış Yap" : "Giriş Yap"
        let titleDisabled = status ? "Çıkış Yapılıyor" : "Giriş Yapılıyor"
        authButton.configuration = status ? .gray() : .filled()
        authButton.setTitle(titleActive, for: .normal)
        authButton.setTitle(titleDisabled, for: .disabled)
        authButton.isEnabled = true
    }
    
    
    func signIn(){
       performSegue(withIdentifier: "toLogin", sender: nil)
    }
    
    func signOut(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}


