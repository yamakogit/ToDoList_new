//
//  DoneDetailViewController.swift
//  ToDoList
//
//  Created by K_Xcode on 2021/04/01.
//

import UIKit

class DoneDetailViewController: UIViewController {

    @IBOutlet var taskTitle: UILabel!
    @IBOutlet var startTimeLabel: UILabel!
    @IBOutlet var endTimeLabel: UILabel!
    @IBOutlet var roopInterval: UILabel!
    @IBOutlet var tagNameLabel: UILabel!
    @IBOutlet var notificaitionStatueLabel: UILabel!
    @IBOutlet var notificaitionTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func taskIncomplete() {
        
    }
    
    @IBAction func taskEdit() {
        
    }

    @IBAction func taskDelete() {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
