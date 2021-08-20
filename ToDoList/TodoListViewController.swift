//
//  TodoListViewController.swift
//  ToDoList
//
//  Created by K_Xcode on 2021/04/01.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    
    
    
    var todoData: [[String: Any]] = []
    var doneTodoData: [[String: Any]] = []
    var filterTodoData: [[String: Any]] = []
    
    var todayTodoData: [[String: Any]] = []
    var tomorrowTodoData: [[String: Any]] = []
    var otherTodoData: [[String: Any]] = []
    
    var saveData: UserDefaults = UserDefaults.standard
    var saveDoneData: UserDefaults = UserDefaults.standard
    var saveFilterData: UserDefaults = UserDefaults.standard
    var saveFilterSituationData: UserDefaults = UserDefaults.standard
    
    
    var timeFormatter = DateFormatter()
    let nowTimeFormatter = NSDate()
    var nowTime: String = ""
    
    var forFilter: [[String: Any]] = []
    var filterSitiation: Int = 0
    
    let sectionTitle: NSArray = ["今日","明日","それ以降"] //Sectionの配列
    let sectionTitleForFilter: NSArray = ["検索結果"]
    
    
    
    @IBAction func searchButton(_ sender: Any) {
        performSegue(withIdentifier: "TodoModalSegue", sender: nil)
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
     
        
        timeFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MM/dd HH:mm", options: 0, locale: Locale(identifier: "ja_jp"))
        
       nowTime = "\(timeFormatter.string(from: nowTimeFormatter as Date))"
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let doneData = saveDoneData.array(forKey: "DoneATodo") as? [[String: Any]] ?? []
        doneTodoData = doneData
        
        let data = saveData.array(forKey: "aTodo") as? [[String: Any]] ?? []
        todoData = data
        
        let filterdata = saveFilterData.array(forKey: "filterArray") as? [[String: Any]] ?? []
        filterTodoData = filterdata
        
        if saveFilterSituationData.integer(forKey: "filterSituation") != nil {
            
            let situationdata = saveFilterSituationData.integer(forKey: "filterSituation")
            filterSitiation = situationdata
            
        }
        
        
        
        
         print("これ",todoData)
        
//        通知機能
//        for i in 0...todoData.count - 1 {
//
//            let todocontent = todoData[i]
//            let time:String = todocontent["notificationTime"] as! String  //notificationTimeの値を取り出している
//            print(time)
//            if time == nowTime {
//                forFilter.append(todocontent)
//                print("ここ！！",forFilter)
//            }
//
        
        
//
//            filter機能
//            if time.filter{$0.containString.nowtime} == true {
//                forFilter.append(todocontent)
//                print(forFilter)
//            } else {
//            }
        
        
        
//        }  //通知機能
            
        
        tableView.reloadData()

    }
    
    @IBAction func reloadData(_ sender: Any) {
        filterSitiation = 0
        
        self.saveFilterSituationData.set(filterSitiation,forKey: "filterSituation")
        tableView.reloadData()
        print("tableView.reloadData()",filterSitiation)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if filterSitiation != 0 {
            return sectionTitleForFilter.count
        } else {
        return sectionTitle.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if filterSitiation != 0 {
            return sectionTitleForFilter[section] as? String
        } else {
            return sectionTitle[section] as? String
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filterSitiation != 0 {
            return filterTodoData.count
        } else {
        if section == 0 { //今日のtodoカウント
            return todoData.count
        } else if section == 1 {
            return todoData.count //明日のtodoカウント
        } else if section == 2 {
            return todoData.count //その他のtodoカウント
        } else {
            return todoData.count //残りの場合
        }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if filterSitiation != 0 {
            let todoTitle = filterTodoData[indexPath.row]["Todotitle"] as! String
            let tagName = filterTodoData[indexPath.row]["tagText"] as! String
            let startTime = filterTodoData[indexPath.row]["startTime"] as! String
            let endTime = filterTodoData[indexPath.row]["endTime"] as! String
            
            cell?.textLabel?.text = todoTitle
            cell?.detailTextLabel?.text = "\(startTime)〜\(endTime)　　タグ:\(tagName)"
            cell?.accessoryType = .disclosureIndicator
            return cell!
        } else {
        
        let todoTitle = todoData[indexPath.row]["Todotitle"] as! String
        let tagName = todoData[indexPath.row]["tagText"] as! String
        let startTime = todoData[indexPath.row]["startTime"] as! String
        let endTime = todoData[indexPath.row]["endTime"] as! String
            
            cell?.textLabel?.text = todoTitle
            cell?.detailTextLabel?.text = "\(startTime)〜\(endTime)　　タグ:\(tagName)"
            cell?.accessoryType = .disclosureIndicator
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if filterSitiation != 0 {
            let selectedtodoData = filterTodoData[indexPath.row]
                performSegue(withIdentifier: "toDetail", sender: selectedtodoData)
            
        } else {
    let selectedtodoData = todoData[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: selectedtodoData)
            
        }
    }
    
    //セル削除機能↓
    /*
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     return true
     }
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == UITableViewCell.EditingStyle.delete{
     todoData.remove(at: indexPath.row)
     tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
     UserDefaults.standard.set(todoData, forKey: "aTodo")
     tableView.reloadData()
     }
     }
     */
    //セル削除機能↑
    
    //セル削除・完了機能↓
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //完了ボタン
        let taskCompletionAction = UIContextualAction(style: .normal, title: "完了") {
            (UIContextualAction,view,completionHandler) in
            
            let appendTodo = self.todoData[indexPath.row]
            self.doneTodoData.append(appendTodo)
            self.saveDoneData.set(self.doneTodoData, forKey: "doneATodo")
            print(self.doneTodoData)
            
            if self.filterSitiation != 0 {
                
                self.filterTodoData.remove(at: indexPath.row)
                UserDefaults.standard.set(self.filterTodoData, forKey: "filterSituation")
            }
            self.todoData.remove(at: indexPath.row)
            UserDefaults.standard.set(self.todoData, forKey: "aTodo")
            tableView.reloadData()
            print("完了ボタンをクリック")
            completionHandler(true)
        }
        
        let taskCompletionButtonImage = UIImage(systemName: "checkmark.shield")?.withTintColor(UIColor.white, renderingMode: .alwaysTemplate)
        taskCompletionAction.image = taskCompletionButtonImage
        taskCompletionAction.backgroundColor = UIColor.systemTeal
        
        
        //削除ボタン
        let taskDeleteAction = UIContextualAction(style: .normal, title: "削除") {
            (UIContextualAction,view,completionHandler) in
            print("削除ボタンをクリック")
//            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.left)
            
            if self.filterSitiation != 0 {
                self.filterTodoData.remove(at: indexPath.row)
                UserDefaults.standard.set(self.filterTodoData, forKey: "filterSituation")
            }
            
            self.todoData.remove(at: indexPath.row)
            
            UserDefaults.standard.set(self.todoData, forKey: "aTodo")
            tableView.reloadData()
            
            completionHandler(true)
        }
        let taskDeleteButtonImage =  UIImage(systemName: "trash.circle")?.withTintColor(UIColor.white, renderingMode: .alwaysTemplate)
        taskDeleteAction.image = taskDeleteButtonImage
        taskDeleteAction.backgroundColor = UIColor.red
        
        
        let swipeAction = UISwipeActionsConfiguration(actions: [taskDeleteAction,taskCompletionAction])
        swipeAction.performsFirstActionWithFullSwipe = false
        
        return swipeAction
        
    }
    
    //セル削除・完了機能↑
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let nextVC = segue.destination as! TodoDetailViewController
            nextVC.selectedtodoData = sender as! [String: Any]
        }
    }
    
    
    
    
    // MARK: - Table view data source
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
//        filterを使う
        
        
        
//    let content = UNMutableNotificationContent()
//    content.title = "title"
//    content.body = "body"
//    content.sound = UNNotificationSound.default
//    // content.categoryIdentifier = "category_select"
//    let request = UNNotificationRequest(identifier: "notificationIdentifier", content: content, trigger: nil)
//    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    
}
