//
//  DoneListViewController.swift
//  ToDoList
//
//  Created by K_Xcode on 2021/04/01.
//

import UIKit

class DoneListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    
    var todoData: [[String: Any]] = []
    var doneTodoData: [[String: Any]] = []
    
    var saveDoneData: UserDefaults = UserDefaults.standard
    var saveData: UserDefaults = UserDefaults.standard
    
    let sectionTitle: NSArray = ["超過","実行済"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let todoDataSubstitution = saveData.array(forKey: "aTodo") as? [[String: Any]] ?? []
        todoData = todoDataSubstitution
        
        let doneData = saveDoneData.array(forKey: "doneATodo") as? [[String: Any]] ?? []

        doneTodoData = doneData
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section] as? String
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 { //超過のtodoカウント
            
            return doneTodoData.count
        } else if section == 1 {
            return doneTodoData.count //実行済のtodoカウント
        } else {
            return 0 //残りの場合
        }
//        return doneTodoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoneCell")
        //        print("チェック",doneTodoData[indexPath.row]["Todotitle"] as! String)
        let todoTitle = doneTodoData[indexPath.row]["Todotitle"] as! String
        let tagName = doneTodoData[indexPath.row]["tagText"] as! String
        let startTime = doneTodoData[indexPath.row]["startTime"] as! String
        let endTime = doneTodoData[indexPath.row]["endTime"] as! String
        cell?.textLabel?.text = todoTitle
        cell?.detailTextLabel?.text = "\(startTime)〜\(endTime)　　タグ:\(tagName)"
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedtodoData = doneTodoData[indexPath.row]
        performSegue(withIdentifier: "toDoneTodoDetail", sender: selectedtodoData)
    }
    
    //セル削除・完了機能↓
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //完了ボタン
        let taskCompletionAction = UIContextualAction(style: .normal, title: "未完了") {
            (UIContextualAction,view,completionHandler) in
            
            let appendTodo = self.doneTodoData[indexPath.row]
            self.todoData.append(appendTodo)
            self.saveData.set(self.todoData, forKey: "aTodo")
            print(self.todoData)
            
            self.doneTodoData.remove(at: indexPath.row)
            self.saveDoneData.set(self.doneTodoData, forKey: "doneATodo")
            
            print("きたよ")
//            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.left)
            
            tableView.reloadData()
            
            print("未完了ボタンをクリック")
            completionHandler(true)
        }
        
        let taskCompletionButtonImage = UIImage(systemName: "xmark.shield")?.withTintColor(UIColor.white, renderingMode: .alwaysTemplate)
        taskCompletionAction.image = taskCompletionButtonImage
        taskCompletionAction.backgroundColor = UIColor.systemTeal
        
        
        let swipeAction = UISwipeActionsConfiguration(actions: [taskCompletionAction])
        swipeAction.performsFirstActionWithFullSwipe = false
        
        return swipeAction
        
    }
    
    //セル削除・完了機能↑
    
    
    
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
    
    
    
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "toDoneTodoDetail" {
     let nextVC = segue.destination as! DoneDetailViewController
     nextVC.selectedtodoData = sender as! [String: Any]
     }
     }*/
    
    
    
    
    
}
