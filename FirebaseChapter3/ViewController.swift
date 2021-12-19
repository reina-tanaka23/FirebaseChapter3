//
//  ViewController.swift
//  FirebaseChapter3
//
//  Created by reina.tanaka on 2021/10/04.
//

import UIKit
import Firebase
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var msg: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var data: UITextView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var age: UITextField!
    
    var ref: DatabaseReference!
    var people: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        self.people = ref.child("people")
        
//        ref.child("people").observe(DataEventType.value, with: {(snapshot) in
//        people.observe(DataEventType.value, with: {(snapshot) in
//            var res = ""
////            if let values = snapshot.value as? NSArray {
//            if let values = snapshot.value as? [String: Any] {
////                for val in values {
//                for (_, val) in values {
//                    let ob: NSDictionary! = val as! NSDictionary
//                    let nm: String = ob.value(forKey: "name") as! String
//                    let ml: String = ob.value(forKey: "mail") as! String
//                    let ag: Int = ob.value(forKey: "age") as! Int
//                    res += nm + "[" + ml + ":" + "]\n"
//                }
//            }
//            self.data.text = res
//        }) { (error) in
//            print(error.localizedDescription)
//        }
    }

    @IBAction func doAction(_ sender: Any) {
        print("doAction is called.")
//        let msg = self.msg.text
//        ref.child("message").setValue(msg)
        
        // データ検索
       self.name.endEditing(true)
       if let fstr: String = self.name.text {
           print("fstr: \(fstr)")
           var fRef = people.queryOrdered(byChild: "name").queryStarting(atValue: fstr)
           fRef.observeSingleEvent(of:DataEventType.value, with: {(snapshot) in
               var res = ""
               print("snapshot.value: \(snapshot.value)")
               if let valuesArray = snapshot.value as? NSArray {
                   for value in valuesArray {
                       if let item = value as? [String: Any] {
//                           for (num, val) in item {
                               let nm = item["name"] as! String
    //                           let ob: NSDictionary! = val as! NSDictionary
//                               let nm: String = ob.value(forKey: "name") as! String
    //                           let ml: String = ob.value(forKey: "mail") as! String
    //                           let ag: Int = ob.value(forKey: "age") as! Int
                               res += nm
//                           }
                       }
                   }
                   
//                   }
//                   for (_, val) in values {
//                       let ob: NSDictionary! = val as! NSDictionary
//                       let nm: String = ob.value(forKey: "name") as! String
//                       let ml: String = ob.value(forKey: "mail") as! String
//                       let ag: Int = ob.value(forKey: "age") as! Int
//                       res += nm + "[" + ":" + String(ag) + "]\n"
//                       res += nm
//                   }
                   print("res: \(res)")
               }
               self.data.text = res
           })
//           }) { (error) in
//               print(error.localizedDescription)
           }
//           })
//       } else {
//           print("fstr is null")
//       }
        
        // データ削除
        if let id: String = self.name.text {
            let rf = self.people.child(id)
            rf.removeValue()
            self.name.text = ""
        }
        
//        // データ新規追加
//        let nm: String? = self.name.text
//        let ml: String? = self.mail.text
//        let ag: Int? = Int(self.age.text ?? "0")
//        let data = [
//            "name": nm,
//            "mail": ml,
//            "age": ag
//        ] as [String : Any]
//        let newRf = self.people.childByAutoId()
//        newRf.setValue(data)
//        self.name.text = ""
//        self.mail.text = ""
//        self.age.text = ""
    }
}
