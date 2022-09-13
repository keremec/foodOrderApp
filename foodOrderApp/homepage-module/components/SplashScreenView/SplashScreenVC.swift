//
//  SplashScreenVC.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 13.09.2022.
//

import UIKit
import Lottie

class SplashScreenVC: UIViewController {

    @IBOutlet weak var imageOutlet: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let animationView = AnimationView(name: "95073-frying-pan")
            animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            animationView.center = self.view.center
            animationView.contentMode = .scaleAspectFit
            
            view.addSubview(animationView)
        
            animationView.play()
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
