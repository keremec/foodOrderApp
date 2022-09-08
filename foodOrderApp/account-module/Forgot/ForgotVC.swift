//
//  ForgotVC.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 8.09.2022.
//

import UIKit
import FirebaseAuth

class ForgotVC: UIViewController {

    @IBOutlet weak var mailInput: UITextField!
    
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func pressResetButton(_ sender: Any) {
        resetPasswordButton.isEnabled = false
        resetPasswordButton.setTitle("Mail Gönderildi", for: .disabled)
        mailInput.isUserInteractionEnabled = false
        Auth.auth().sendPasswordReset(withEmail: mailInput.text!) { error in
            print(error?.localizedDescription ?? "success")
        }
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in
            self.dismiss(animated: true)
        })
    }
    
    
    @IBAction func pressBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
