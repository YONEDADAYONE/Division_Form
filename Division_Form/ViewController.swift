//
//  ViewController.swift
//  Division_Form
//
//  Created by 米田大弥 on 2018/11/29.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var AnswerLabel: UILabel!
    @IBOutlet weak var MoneyTextField: UITextField!
    @IBOutlet weak var PeopleTextField: UITextField!
    @IBAction func InputButton(_ sender: UIButton) {
        
        if MoneyTextField.text! == "" && PeopleTextField.text! == "" {
            let alert = UIAlertController(
                title: "金額及び人数が入力されていません。", message: "恐れ入りますが金額及び人数を入力してください。",preferredStyle: UIAlertController.Style.alert)
            
            let DefaultAction = UIAlertAction(title: "入力画面に戻ります。", style: .default, handler:{
                (action: UIAlertAction!) -> Void in
            })
            
            alert.addAction(DefaultAction)
            
            present(alert,animated: true,completion: nil)
            
        }else if MoneyTextField.text! == "" {
            
            let alert = UIAlertController(
                title: "金額が入力されていません。", message: "恐れ入りますが金額を入力してください。",preferredStyle: UIAlertController.Style.alert)
            
            let defaultAction = UIAlertAction(title: "入力画面に戻ります。", style: .default, handler:{
                (action: UIAlertAction!) -> Void in
            })
            
            alert.addAction(defaultAction)
            
            present(alert,animated: true,completion: nil)
            
        }else if PeopleTextField.text! == "" {
            
            let alert = UIAlertController(
                title: "人数が入力されていません。", message: "恐れ入りますが人数を入力してください。",preferredStyle: UIAlertController.Style.alert)
            
            let defaultAction = UIAlertAction(title: "入力画面に戻ります。", style: .default, handler:{
                (action: UIAlertAction!) -> Void in
            })
            
            alert.addAction(defaultAction)
            
            present(alert,animated: true,completion: nil)
            
        }else if Int(PeopleTextField.text!)! < 2 {
            
            let alert = UIAlertController(
                title: "人数に誤りがあります。", message: "恐れ入りますが２名以上の人数を入力してください。",preferredStyle: UIAlertController.Style.alert)
            
            let defaultAction = UIAlertAction(title: "入力画面に戻ります。", style: .default, handler:{
                (action: UIAlertAction!) -> Void in
            })
            
            alert.addAction(defaultAction)
            present(alert,animated: true,completion: nil)
            
        }else {
            LabelResult()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 234/255, blue: 255/255, alpha: 1)
        
        NotificationCenter.default.addObserver(
            self,selector: #selector(textFieldDidChange),name: UITextField.textDidChangeNotification,object: MoneyTextField)
        
        NotificationCenter.default.addObserver(
            self,selector: #selector(textFieldDidChange),name: UITextField.textDidChangeNotification,object: PeopleTextField)
        
        MoneyTextField.placeholder = "金額を入力してください"
        PeopleTextField.placeholder = "人数を入力してください"
        
        self.MoneyTextField.keyboardType = UIKeyboardType.numberPad
        self.PeopleTextField.keyboardType = UIKeyboardType.numberPad
        
        var Done:UIToolbar = UIToolbar()
        Done = UIToolbar(frame: CGRect(origin: .zero,size: CGSize(width: 0,height: 44)))
        let SpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let DoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self,action:#selector(textFieldShouldReturn(_:)))
        Done.items = [SpaceItem,DoneItem]
        MoneyTextField.inputAccessoryView = Done
        PeopleTextField.inputAccessoryView = Done
    }
    
    func LabelResult() {
        let MoneyResult:Int? = Int(MoneyTextField.text!)
        let PeopleResult:Int? = Int(PeopleTextField.text!)
        let LastResult = MoneyResult! / PeopleResult!
        
        if LastResult > 1000 {
            let SemiFinalResult = Double(LastResult) * 0.1
            let FinalResult = Int((ceil(SemiFinalResult)*10))
            AnswerLabel.text = ("\(PeopleResult!)人の場合1人当たりの支払い金額は\((FinalResult))円です。")
        }else{
            AnswerLabel.text = ("\(PeopleResult!)人の場合1人当たりの支払い金額は\(LastResult)円です。")
        }
    }
    
    @IBAction func ResetButton(_ sender: UIButton) {
        PeopleTextField.text = ""
        MoneyTextField.text = ""
        AnswerLabel.text = "金額と人数を入力してください。"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        MoneyTextField.resignFirstResponder()
        PeopleTextField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func textFieldDidChange(notification: NSNotification) {
        let textFieldString = notification.object as! UITextField
        if let text = textFieldString.text {
            if MoneyTextField.text!.count > 19  {
                MoneyTextField.text = (String(text[text.index(text.startIndex, offsetBy: 10)..<text.index(text.endIndex, offsetBy: -10)]))
            } else if PeopleTextField.text!.count > 19 {
                PeopleTextField.text = (String(text[text.index(text.startIndex, offsetBy: 10)..<text.index(text.endIndex, offsetBy: -10)]))
            }
        }
    }
    
    
}
