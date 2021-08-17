//
//  HomeViewController.swift
//  ToDoList
//
//  Created by K_Xcode on 2021/04/01.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var glafImageSet: UIImageView! //グラフ
    @IBOutlet var taskPercent: UILabel! //タスク完了％
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goHomeCommentity() {
        //SFSafariで説明書へ
    }
    
    @IBAction func varInfo() {
        //バージョン情報をアラートで表示
    }
    
    @IBAction func goAppstore() {
        //NOTSFSafariでAppStoreへのリンク
    }
    
    @IBAction func goGoogleForm() {
        //SFSafariでGoogleFormへ
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
