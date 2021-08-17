//
//  AddTodoViewController.swift
//  ToDoList
//
//  Created by K_Xcode on 2021/04/01.
//

import UIKit

class AddTodoViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource, UITextViewDelegate {
    
    var todoTitle :String = "タイトル入力なし"
    var roopIntervalText :String = "繰り返しなし"
    var tagText :String = "タグなし"
    var startTime = "指定なし"
    var endTime = "指定なし"
    var notificationTime = "指定なし"
    let startTimeFormatter = DateFormatter()
    let endTimeFormatter = DateFormatter()
    let notificationTimeFormatter = DateFormatter()
    var savedata: UserDefaults = UserDefaults.standard
    
    @IBOutlet var todoを追加: UILabel!
    @IBOutlet weak var todoTitleField: UITextField!
    @IBOutlet var startTimeDatePicker: UIDatePicker!
    @IBOutlet var endTimeDatePicker: UIDatePicker!
    @IBOutlet var roopIntervalPicker: UIPickerView!
    @IBOutlet var notificationTimeDatePicker: UIDatePicker!
    @IBOutlet var notificationLabel: UILabel!
    @IBOutlet var tagPicker: UIPickerView!
    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var tagLabel: UILabel!
    @IBOutlet var roopLabel: UILabel!
    @IBOutlet var addtagDesign: UIButton!
    @IBOutlet var saveButtonDesign: UIButton!
    @IBOutlet var CancelButtonDesign: UIButton!
    
    //S_Textview
    var memoText: String = ""
    
    @objc func onClickCommitButton(sender: UIButton) {
        if(memoTextView.isFirstResponder) {
            memoTextView.resignFirstResponder()
            memoText = memoTextView.text
            print("memoText:\(memoText)")
        }
    }
    //E_Textview
    
    let roopIntervalList = ["繰り返しなし","1日毎","1週間毎","1ヶ月毎","1年毎"]

    let errorPickerList = ["読み込み失敗"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //S_startTime 選択・読み込み
        startTimeDatePicker.minimumDate = NSDate() as Date
        //E_startTime 選択・読み込み
        
        //S_endTime 選択・読み込み
        endTimeDatePicker.minimumDate = NSDate() as Date
        //E_endTime 選択・読み込み
        
        //S_endTime 選択・読み込み
        notificationTimeDatePicker.minimumDate = NSDate() as Date
        //E_endTime 選択・読み込み
        
        //S_Textview
        
        // NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
        let costombar = UIView(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.size.width), height: 40))
        costombar.backgroundColor = UIColor.secondarySystemBackground
        let commitBtn = UIButton(frame: CGRect(x: (UIScreen.main.bounds.size.width)-50, y: 0, width: 55, height: 40))
        commitBtn.setTitle("完了", for: .normal)
        commitBtn.setTitleColor(UIColor.systemTeal, for: .normal)
        commitBtn.addTarget(self, action: #selector(AddTodoViewController.onClickCommitButton), for: .touchUpInside)
        costombar.addSubview(commitBtn)
        memoTextView.inputAccessoryView = costombar
        memoTextView.keyboardType = .default
        memoTextView.returnKeyType = .default
        memoTextView.delegate = self
        //E_Textview
        
        
        
        todoTitleField.delegate = self
        //Title読み込み
        
        //S_PickerView
        roopIntervalPicker.delegate = self
        roopIntervalPicker.dataSource = self
        tagPicker.delegate = self
        tagPicker.dataSource = self
        
        roopIntervalPicker.tag = 1
        tagPicker.tag = 2
        
        
        //E_PickerView
        
        todoを追加.layer.cornerRadius = 23.0
        todoを追加.clipsToBounds = true
        memoTextView.layer.cornerRadius = 15.0
        addtagDesign.layer.cornerRadius = 15.0
        CancelButtonDesign.layer.cornerRadius = 25.0
        saveButtonDesign.layer.cornerRadius = 25.0
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    //S_Title入力・読み込み
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //キーボードを閉じる
        todoTitle = textField.text!  //todoTitleに入力した文字列を代入
        print("todoTitle: \(todoTitle)") //入力された文字をデモで表示
        return true //戻り値
    }
    //E_Title入力・読み込み
    
    //S_startTime 選択・読み込み
    @IBAction func starttimeDatePickerTapped() {
        //S_startTimeDatePicker
        startTimeDatePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        startTimeDatePicker.timeZone = NSTimeZone.local
        startTimeDatePicker.locale = Locale.current
        startTimeDatePicker.endEditing(true)
        startTimeFormatter.dateFormat = "MM/dd HH:mm"
        print(startTimeFormatter.string(from: startTimeDatePicker.date))
        startTime = startTimeFormatter.string(from: startTimeDatePicker.date)
        print("開始時刻: \(startTime)")
    }
    //E_startTime 選択・読み込み
    
    //S_endTime 選択・読み込み
    
    @IBAction func endtimeDatePickerTapped() {
    endTimeDatePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
    endTimeDatePicker.timeZone = NSTimeZone.local
    endTimeDatePicker.locale = Locale.current
    endTimeDatePicker.endEditing(true)
    endTimeFormatter.dateFormat = "MM/dd HH:mm"
    print(endTimeFormatter.string(from: endTimeDatePicker.date))
    endTime = endTimeFormatter.string(from: endTimeDatePicker.date)
    print("終了時刻: \(endTime)")
}
    //E_endTime 選択・読み込み
    
    @IBAction func notificationTimeDatePickerTapped() {
    notificationTimeDatePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
    notificationTimeDatePicker.timeZone = NSTimeZone.local
    notificationTimeDatePicker.locale = Locale.current
    notificationTimeDatePicker.endEditing(true)
    notificationTimeFormatter.dateFormat = "MM/dd HH:mm"
    print(notificationTimeFormatter.string(from: endTimeDatePicker.date))
    notificationTime = notificationTimeFormatter.string(from: endTimeDatePicker.date)
    print("通知時刻: \(notificationTime)")
}
    
    
    @IBAction func addTag() {
        //MARK:タグを新規作成
        //アラート形式で表示・入力・配列に追加
        
        var alertController: UIAlertController!
        
        //警告アラート
        func alert(title:String, message:String) {
            alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true)
        }
        
        let alertTitle = "タグを新規作成・削除"
        let alertMessage = "新規タグ・削除したいタグ\nの名称を記入し、\n「完了」ボタンを押してください。"
        let alert1 = UIAlertController (title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let addTagAction = UIAlertAction(title: "完了", style: .default, handler: {(action:UIAlertAction!) -> Void in
            if let addTagContent = alert1.textFields?[0].text{
                if addTagContent == "タグを選択" {
                    alert(title: "「タグを選択」は\n追加・削除できません",message: "「タグを選択」は追加・削除できません。\n他の名称で再度お試しください。")
                } else if addTagContent == "タグなし" {
                    alert(title: "「タグなし」は\n追加・削除できません",message: "「タグなし」は追加・削除できません。\n他の名称で再度お試しください。")
                } else if addTagContent == "" {
                    alert(title: "タグの名称が\n入力されていません",message: "タグの名称を入力し、\n再度お試しください。")
                } else {
                    var tagPickerList = self.savedata.array(forKey: "tagPickerList") as? [String] ?? ["タグを選択","タグなし"]
                if tagPickerList.firstIndex(of: addTagContent) != nil {
                    let tagSearch = tagPickerList.firstIndex(of: addTagContent)
                    tagPickerList.remove(at: tagSearch!)
                    self.savedata.set(tagPickerList,forKey: "tagPickerList")
                    alert(title: "「\(addTagContent)」タグを削除しました", message: "")
                } else {
                tagPickerList.append(addTagContent)
                    self.savedata.set(tagPickerList,forKey: "tagPickerList")
                    alert(title: "「\(addTagContent)」タグを追加しました", message: "")
                    /*
                    var tagSaveListData = self.tagSaveData.array(forKey: "saveTag") as? [String] ?? []
                    tagSaveListData.append(addTagContent)
                    self.tagSaveData.set(tagSaveListData, forKey: "saveTag")
                    */
                }
                self.tagPicker.reloadAllComponents()
                }
            }
                
            
        })
        alert1.addAction(addTagAction)
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alert1.addAction(cancelAction)
        
        alert1.addTextField(configurationHandler: {(textfield:UITextField!) -> Void in
            textfield.placeholder = "タグ名を入力..."
            textfield.keyboardType = .default
        })
        self.present(alert1, animated: true, completion: nil)
    }
    
    //S_PickerView
    
    //列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //行・リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return roopIntervalList.count
        } else if pickerView.tag == 2 {
            let tagPickerList = self.savedata.array(forKey: "tagPickerList") as? [String] ?? ["タグを選択","タグなし"]
            return tagPickerList.count
        } else {
            return errorPickerList.count
        }
    }
    
    //最初の表示
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return roopIntervalList[row]
        } else if pickerView.tag == 2{
            let tagPickerList = self.savedata.array(forKey: "tagPickerList") as? [String] ?? ["タグを選択","タグなし"]
            return tagPickerList[row]
        } else {
            return errorPickerList[row]
        }
    }
    
    //PickerViewのRowが選択されたときの挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            roopIntervalText = roopIntervalList[row]
            print("roopIntervalText: \(roopIntervalText)")
                roopLabel.text = "選択中: \(roopIntervalText)"
                roopLabel.textColor = UIColor.systemTeal
            
        } else if pickerView.tag == 2{
            let tagPickerList = self.savedata.array(forKey: "tagPickerList") as? [String] ?? ["タグを選択","タグなし"]
            tagText = tagPickerList[row]
            print("tagText: \(tagText)")
            
            if tagText == "タグを選択"{
                tagLabel.text = "⚠️タグが選択されていません"
                tagLabel.textColor = UIColor.red
            } else {
                tagLabel.text = "選択中のタグ: \(tagText)"
                tagLabel.textColor = UIColor.systemTeal
            }
            
        } else {
            print("エラー: UIPickerView 応答なし")
        }
        
    }
    //E_PickerView
    
    
    
    
    @IBAction func cancel(){
        //MARK:Todoをキャンセル
        //アラートで警告表示後、
        //全ての値を初期化
        let resetalert: UIAlertController = UIAlertController(title: "データをリセットしますか？",message: "現在入力中のデータを保存していない\nx場合、このデータは削除されます", preferredStyle: UIAlertController.Style.alert)
        let confilmAction: UIAlertAction = UIAlertAction(title: "リセット", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            //MARK:データ等、全ての値を初期化
            self.todoTitleField.text = ""
            self.memoTextView.text = ""
            self.startTimeDatePicker.setDate(NSDate() as Date, animated: false)
            self.endTimeDatePicker.setDate(NSDate() as Date, animated: true)
            self.notificationTimeDatePicker.setDate(NSDate() as Date, animated: false)
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:nil)
        
        resetalert.addAction(confilmAction)
        resetalert.addAction(cancelAction)
        
        //alertを表示
        present(resetalert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func saveDeta(){
        //MARK:Todoを保存
        //全ての値を配列に追加
        if tagText == "タグを選択"{
            var alertController: UIAlertController!
            func alert(title:String, message:String) {
                alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true)
            }
            
            alert(title: "タグが正しく\n選択できていません",message: "タグを再度選択してください。")
        } else if todoTitle == "タイトル入力なし" {
            var alertController: UIAlertController!
            func alert(title:String, message:String) {
                alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true)
            }
            
            alert(title: "タイトルが正しく\n入力できていません",message: "タイトルを再度入力してください。")
        } else {
        let dictionary: [String: Any] = [
            "Todotitle": todoTitle,
            "startTime": startTimeFormatter.string(from: startTimeDatePicker.date),
            //"startTime": startTime,
            //"endTime": endTime,
            "endTime": endTimeFormatter.string(from: endTimeDatePicker.date),
            "roopinterval": roopIntervalText,
            //"notificationTime": notificationTime,
            "notificationTime": notificationTimeFormatter.string(from: endTimeDatePicker.date),
            "tagText": tagText,
            "memoText": memoText,
        ]
        var currentData = savedata.array(forKey: "aTodo") ?? []
        currentData.append(dictionary)
        savedata.set(currentData, forKey: "aTodo")
        dismiss(animated: true, completion: nil)
        
        
        var alertController: UIAlertController!
        func alert(title:String, message:String) {
            alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true)
        }
        
        alert(title: "新たなTodoを追加しました",message: "Todoタブを選択し、確認してください。")
        
        self.todoTitleField.text = ""
        self.memoTextView.text = ""
        self.startTimeDatePicker.setDate(NSDate() as Date, animated: false)
        self.endTimeDatePicker.setDate(NSDate() as Date, animated: true)
        self.notificationTimeDatePicker.setDate(NSDate() as Date, animated: false)
        }
    }
    
    //S_UISwitch
    @IBAction func notificationSwitch(_ sender: UISwitch) {
        if sender.isOn {
            notificationTimeDatePicker.isHidden = false
            notificationLabel.isHidden = true
        } else {
            notificationTimeDatePicker.isHidden = true
            notificationLabel.isHidden = false
        }
    }
    //E_UISwitch

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
