//
//  SplashScreenVC.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 13.09.2022.
//

import UIKit

class SplashScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
            let transition: CATransition = CATransition()
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.moveIn
            transition.subtype = CATransitionSubtype.fromTop
            self.view.window!.layer.add(transition, forKey: nil)
            self.dismiss(animated: false, completion: nil)
        })
    }

}
