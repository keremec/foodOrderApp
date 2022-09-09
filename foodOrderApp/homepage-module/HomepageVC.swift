//
//  ViewController.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 6.09.2022.
//

import UIKit

class HomepageVC: UIViewController {

    var homepagePresenterObject:VtoP_HomepageProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()


        HomepageRouter.createModule(ref: self)
    }


}

extension HomepageVC:PtoV_HomepageProtocol{
    func dataSendtoView(foodList: Array<Foods>) {
    }
}
