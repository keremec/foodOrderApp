//
//  CartpageVC.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 14.09.2022.
//

import UIKit
import Firebase


//MARK: - ViewController

    
class CartpageVC: UIViewController {

    //MARK: - Declarations
    var cartpagePresenterObject:VtoP_CartpageProtocol?
    
    @IBOutlet weak var CartTableView: UITableView!
    @IBOutlet weak var CartPrice: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var cleanCartButton: UIButton!
    @IBOutlet weak var emptyCartString: UILabel!
    @IBOutlet weak var emptyCartImage: UIImageView!
    @IBOutlet weak var orderSeperatorLine: UILabel!
    
    var NoteList = [Notes]()
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        CartpageRouter.createModule(ref: self)
        CartTableView.delegate = self
        CartTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showCartEmpty()
        orderButton.isEnabled = false
        CartPrice.isHidden = true
        if let user = Auth.auth().currentUser?.uid{
            cartpagePresenterObject?.doLoadNote(uid: user)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser?.uid{
            print(user)
        }
        else{
            self.tabBarItem.badgeValue = nil
            performSegue(withIdentifier: "Cart2Login", sender: nil)
            _ = self.tabBarController?.selectedIndex = 3
        }
    }
    
    //MARK: - Widget Actions
    @IBAction func stepperAction(_ sender: UIStepper) {
        CartTableView.reloadData()
    }
    
    @IBAction func orderCartAction(_ sender: Any) {
        orderButton.isEnabled = false
        cleanCartAction("order")
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd_HH:mm:ss"
        let dateString = df.string(from: date)
        self.cartpagePresenterObject?.doNewOrder(orderDate: dateString)
        _ = self.tabBarController?.selectedIndex = 3
        
    }
    
    @IBAction func cleanCartAction(_ sender: Any) {
        if let user = Auth.auth().currentUser?.uid{
            cleanCartButton.isEnabled = false
            print("tetiklendi")
            cartpagePresenterObject?.doCleanCart(uid: user)
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
                self.cartpagePresenterObject?.doLoadNote(uid: user)
            })
        }
    }
}

//MARK: - Tableview Functions

extension CartpageVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NoteList.count
    }
    
    //MARK: Adding Cells
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = NoteList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        cell.noteStepper.tag = indexPath.row
        cell.noteStepper.value = Double(note.note_count!)
        let count = cell.noteStepper.value.cleanValue
        
        cell.noteCounterButton.setTitle(count, for: .normal)
        cell.noteImage.image = note.note_image
        cell.noteLabel.text =  note.note_title
        cell.noteDetail.text = note.note_detail
        let cartPrice = note.note_price! * cell.noteStepper.value
        cell.notePrice.text = "₺" + cartPrice.cleanValue
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let note = self.NoteList[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Sepetten Kaldır"){(contextualAction, view, bool ) in
            if let user = Auth.auth().currentUser?.uid{
                self.cartpagePresenterObject?.doRemoveNote(uid: user, noteID: note.note_id!)
                Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: { _ in
                    self.cartpagePresenterObject?.doLoadNote(uid: user)
                })
            }
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK: - Presenter Calls

extension CartpageVC:PtoV_CartpageProtocol{
    func countSendtoView(count: Int) {
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[1]
            if(count == 0){
                tabItem.badgeValue = nil
                self.showCartEmpty()
            }
            else{
                self.showCartNotEmpty()
            }
        }
    }
    
    func priceSendtoView(price: Double) {
        CartPrice.text = "₺" + price.cleanValue
    }
    

    
    func noteSendtoView(noteList: Array<Notes>) {
        self.NoteList = noteList
        print(noteList.count)
        DispatchQueue.main.async {
            self.CartTableView.reloadData()
        }
    }
}



//MARK: - UI Functions

extension CartpageVC{
    func showCartEmpty(){
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: { _ in
            if(self.NoteList.isEmpty){
                self.cleanCartButton.isEnabled = false
                self.orderButton.isEnabled = false
                self.orderButton.isHidden = true
                self.CartPrice.isHidden = true
                self.orderSeperatorLine.isHidden = true
                
                self.emptyCartImage.isHidden = false
                self.emptyCartString.isHidden = false
            }
        })
    }
    
    func showCartNotEmpty(){
        self.cleanCartButton.isEnabled = true
        self.orderButton.isHidden = false
        self.orderSeperatorLine.isHidden = false
        
        self.emptyCartImage.isHidden = true
        self.emptyCartString.isHidden = true
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.CartPrice.isHidden = false
            self.orderButton.isEnabled = true
        })
    }
}
