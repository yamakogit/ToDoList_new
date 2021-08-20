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
    @IBOutlet var roopIntervalLabel: UILabel!
    @IBOutlet var tagNameLabel: UILabel!
    @IBOutlet var notificationStatueLabel: UILabel!
    @IBOutlet var notificationTimeLabel: UILabel!
    
    @IBOutlet var memoTextView: UITextView!
    
    @IBOutlet var notCompletionTaskButtonDesign: UIButton!
    @IBOutlet var editTaskButtonDesign: UIButton!
    @IBOutlet var deleteTaskButtonDesign: UIButton!
    
    @IBOutlet var 開始日時: UILabel!
    @IBOutlet var 終了日時: UILabel!
    @IBOutlet var 繰り返し: UILabel!
    @IBOutlet var 通知の有無: UILabel!
    @IBOutlet var 通知時刻: UILabel!
    
    
    var selectedDonetodoData: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var startTime = selectedDonetodoData["startTime"] as! String  //ここにエラーが出る!!
        var endTime = selectedDonetodoData["endTime"] as! String
        let Todotitle = selectedDonetodoData ["Todotitle"] as! String
        let roopinterval = selectedDonetodoData ["roopinterval"] as! String
        var notificationTime = selectedDonetodoData["notificationTime"] as! String
        let tagText = selectedDonetodoData ["tagText"] as! String
        let memoText = selectedDonetodoData ["memoText"] as! String
        
        if startTime == "" { startTime = "指定なし" }
        if endTime == "" { endTime = "指定なし" }
        if notificationTime == "" {
            notificationTime = " - "
            notificationTimeLabel.text = "通知なし"
        } else {
            notificationTimeLabel.text = "通知あり"
        }
        
        
        
        //画面のヘッダー TodoTitleを設定
        navigationItem.title = Todotitle
        taskTitle.text = "  \(Todotitle)"
        
        let timeFormmater = DateFormatter()
        timeFormmater.dateStyle = .short
        timeFormmater.timeStyle = .short
        
        startTimeLabel.text = "  \(startTime)"
        endTimeLabel.text = "  \(endTime)"
        notificationTimeLabel.text = "  \(notificationTime)"
        
        roopIntervalLabel.text = roopinterval
        tagNameLabel.text = tagText
        memoTextView.text = memoText
        
        taskTitle.layer.cornerRadius = 20.0
        startTimeLabel.layer.cornerRadius = 20.0
        endTimeLabel.layer.cornerRadius = 20.0
        tagNameLabel.layer.cornerRadius = 20.0
        roopIntervalLabel.layer.cornerRadius = 15.0
        notificationTimeLabel.layer.cornerRadius = 20.0
        notificationStatueLabel.layer.cornerRadius = 20.0
        memoTextView.layer.cornerRadius = 10.0
        開始日時.layer.cornerRadius = 20.0
        終了日時.layer.cornerRadius = 20.0
        繰り返し.layer.cornerRadius = 15.0
        通知の有無.layer.cornerRadius = 20.0
        通知時刻.layer.cornerRadius = 20.0
        notCompletionTaskButtonDesign.layer.cornerRadius = 18.0
        editTaskButtonDesign.layer.cornerRadius = 18.0
        deleteTaskButtonDesign.layer.cornerRadius = 18.0
        
        taskTitle.clipsToBounds = true
        startTimeLabel.clipsToBounds = true
        endTimeLabel.clipsToBounds = true
        tagNameLabel.clipsToBounds = true
        roopIntervalLabel.clipsToBounds = true
        notificationTimeLabel.clipsToBounds = true
        notificationStatueLabel.clipsToBounds = true
        開始日時.clipsToBounds = true
        終了日時.clipsToBounds = true
        繰り返し.clipsToBounds = true
        通知の有無.clipsToBounds = true
        通知時刻.clipsToBounds = true
        
        memoTextView.isEditable = false
        memoTextView.isSelectable = false
        
        
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
