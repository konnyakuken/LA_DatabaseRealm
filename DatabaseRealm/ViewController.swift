//
//  ViewController.swift
//  DatabaseRealm
//
//  Created by 若宮拓也 on 2022/08/25.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextField: UITextField!
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        contentTextField.delegate = self
        
        let memo: Memo? = read()
        
        titleTextField.text = memo?.title
        contentTextField.text = memo?.content
        // Do any additional setup after loading the view.
    }
    
    func read() -> Memo?{
        return realm.objects(Memo.self).first
    }
    
    @IBAction func save(){
        //画面上の値を代入
        let title: String = titleTextField.text!
        let content: String = contentTextField.text!
        //すでに保存されている情報を取得
        let memo: Memo? = read()
        
        if memo != nil {
            //memoにすでにデータが保存されている時、保存データを更新する
            //try! realm.write{}内でデータベースへ書き込み
            try! realm.write{
                memo!.title = title
                memo!.content = content
            }
        }else{
            //保存されているメモがない時、新しくメモを新規作成→データベースに保存
            let newMemo = Memo()
            newMemo.title = title
            newMemo.content = content
            
            try! realm.write{
                realm.add(newMemo)
            }
        }
        
        //アラートを扱うための設定
        let alert: UIAlertController = UIAlertController(title: "成功",
                                                         message: "保存しました",
                                                         preferredStyle: .alert)
        //アラート内にOKボタンを設定
        alert.addAction(
            UIAlertAction(title: "OK",style: .default,handler: nil)
        )
        //アラートを表示する
        present(alert, animated: true, completion: nil)
    }
    
    //終了時にキーボードが閉じる設定
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
    }


}

