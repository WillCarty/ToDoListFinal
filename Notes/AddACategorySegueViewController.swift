//
//  AddACategorySegueViewController.swift
//  Notes
//
//  Created by Will Carty on 10/29/16.
//  Copyright © 2016 efa. All rights reserved.
//

import UIKit

class AddACategorySegueViewController: UIViewController {
    //IBOutlets
    @IBOutlet weak var addACategoryText: UITextField!
    
    let mainView = ToDosTableViewController()
    let addACateory = AddACategory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //IBActions
    @IBAction func addACategoryButton(_ sender: AnyObject) {
        let newname = addACategoryText.text
        ToDoDetailViewController.categoryPickerArray.append(newname!)
        mainView.numberOfSections += 1
        AddACategory.SectionTitles.append(newname!)
    }
    
    @IBAction func deleteCategoryButton(_ sender: AnyObject) {
        ToDoDetailViewController.categoryPickerArray.removeLast()
        AddACategory.SectionTitles.removeLast()
        mainView.numberOfSections -= 1
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
