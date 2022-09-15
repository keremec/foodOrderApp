//
//  ViewController.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 6.09.2022.
//

import UIKit
import Alamofire
import SwiftUI

//MARK: - ViewController

class HomepageVC: UIViewController {
    
    //MARK: - Declarations
    var homepagePresenterObject:VtoP_HomepageProtocol?
    
    @IBOutlet weak var scrollViewHome: UIScrollView!
    
    @IBOutlet weak var HeroCollectionView: UICollectionView!
    
    @IBOutlet weak var CategoryCollectionView: UICollectionView!
    
    @IBOutlet weak var NotesTableView: UITableView!
    
    var HeroList = [Heros]()
    var CategoryList = [Categories]()
    var NoteList = [Notes]()
    var welcome = true
    
    //MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = self.view.frame.size.width
        HomepageRouter.createModule(ref: self)
        
        HeroCollectionView.delegate = self
        HeroCollectionView.dataSource = self
        
        CategoryCollectionView.delegate = self
        CategoryCollectionView.dataSource = self
        
        NotesTableView.delegate = self
        NotesTableView.dataSource = self
        scrollViewHome.delegate = self
        
        homepagePresenterObject?.doloadHero()
        homepagePresenterObject?.doLoadCategory()
        homepagePresenterObject?.doLoadNote()
        
        
        //MARK: Styles
        
        // Hero Collection View
        
        let heroDesign = UICollectionViewFlowLayout()
        heroDesign.scrollDirection = .horizontal
        heroDesign.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        heroDesign.itemSize = CGSize(width: width * 0.85, height: width * 0.42)
        HeroCollectionView.isPagingEnabled = true
        HeroCollectionView.collectionViewLayout = heroDesign
        
        //categories
        
        let categoryDesign = UICollectionViewFlowLayout()
        categoryDesign.scrollDirection = .horizontal
        categoryDesign.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        categoryDesign.minimumInteritemSpacing = 1
        categoryDesign.itemSize = CGSize(width: width * 0.35, height: width * 0.3)
        CategoryCollectionView.collectionViewLayout = categoryDesign
        CategoryCollectionView.isScrollEnabled = true
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(welcome){
        performSegue(withIdentifier: "toWelcome", sender: nil)
            welcome = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toDetail":
            if let note = sender as? Notes{
                let goalVC = segue.destination as! NoteDetailView
                goalVC.delegateDetail = self
                goalVC.note = note
            }
        default:
            print("identifier not found")
        }
    }
    
    //MARK: - Widget Actions
    
    @IBAction func toUpButton(_ sender: Any) {
        scrollViewHome.setContentOffset(.zero, animated: true)
        NotesTableView.setContentOffset(.zero, animated: true)
    }
}

//MARK: - Presenter Calls

extension HomepageVC:PtoV_HomepageProtocol{
    func heroSendtoView(herolist: Array<Heros>) {
        self.HeroList = herolist
        DispatchQueue.main.async {
            self.HeroCollectionView.reloadData()
        }
    }
    
    func categorySendtoView(categorylist: Array<Categories>) {
        self.CategoryList = categorylist
        DispatchQueue.main.async {
            self.CategoryCollectionView.reloadData()
        }
    }
    
    func noteSendtoView(noteList: Array<Notes>) {
        self.NoteList = noteList
        
        DispatchQueue.main.async {
            self.NotesTableView.reloadData()
        }
        
    }
    
    func noteImageSendtoView(image: UIImage){
    }
}


//MARK: - Filling the CollectionViews

extension HomepageVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
            
        case HeroCollectionView:
            return HeroList.count
            
        case CategoryCollectionView:
            return CategoryList.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
            
        case HeroCollectionView:
            let hero = HeroList[indexPath.row]
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as! HeroCollectionViewCell
            
            cell.heroImage.image = hero.heroImg
            
            cell.layer.cornerRadius = 10.0
            
            return cell
            
        case CategoryCollectionView:
            let category = CategoryList[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            
            cell.imageSpec.image = category.CategoryImgage
            
            cell.buttonOutlet.configuration?.subtitle = category.CategoryTitle
            
            cell.layer.cornerRadius = 5.0
            cell.backgroundColor = UIColor(hex: category.CategoryColor!)
            return cell
            
        default:
            return UICollectionViewCell()
            
        }
    }
    
}


//MARK: - Filling Tableview

extension HomepageVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NoteList.count
    }
    
    //MARK: Adding Cells
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = NoteList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell

        cell.noteImage.image = note.note_image
        
        cell.noteLabel.text = note.note_title
        cell.noteDetail.text = note.note_detail
        cell.notePrice.text = "₺" + note.note_price!.cleanValue
        
        
        return cell
        
    }
    
    //MARK: Adding Cell Click Action
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = self.NoteList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: note)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - Scroll Behaviour

extension HomepageVC{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if (NotesTableView.contentOffset.y <= 0){
            scrollViewHome.isScrollEnabled = true
        }
        
        if (scrollViewHome.contentOffset.y <= 0){
            scrollViewHome.bounces = true
            NotesTableView.setContentOffset(.zero, animated: false)
        }
        
        
        if (NotesTableView.contentOffset.y >= (NotesTableView.contentSize.height - NotesTableView.frame.size.height)) {
            scrollViewHome.isScrollEnabled = true
            scrollViewHome.bounces = true
        
        }
        
        if (scrollViewHome.contentOffset.y >= (scrollViewHome.contentSize.height - scrollViewHome.frame.size.height)) {
            NotesTableView.isScrollEnabled = true
        }
        
        
        if (NotesTableView.contentOffset.y > 0 && NotesTableView.contentOffset.y < (NotesTableView.contentSize.height - scrollViewHome.frame.size.height)){
            scrollViewHome.isScrollEnabled = false
            
           
        }
        if (scrollViewHome.contentOffset.y > 0 && scrollViewHome.contentOffset.y < (scrollViewHome.contentSize.height - scrollViewHome.frame.size.height)){
            NotesTableView.isScrollEnabled = false
            scrollViewHome.bounces = false
        }
        
    }
}
