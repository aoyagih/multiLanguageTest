//
//  ViewController.swift
//  multiLanguageTest
//
//  Created by Aoyagi Hiroki on 2020/04/17.
//  Copyright © 2020 Aoyagi Hiroki. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class ViewController: UIViewController {

    //テキスト
    @IBOutlet weak var localText: UILabel!
    @IBOutlet weak var serverText: UILabel!
    @IBOutlet weak var localImageText: UILabel!
    @IBOutlet weak var serverImageText: UILabel!
    
    //画像
    @IBOutlet weak var localImage: UIImageView!
    @IBOutlet weak var serverImage: UIImageView!
    
    //Firebase関連
    let db = Firestore.firestore()
    let storage = Storage.storage()
    // Create a storage reference from our storage service
    let storageRef = Storage.storage().reference()
    var serverTextRef = Firestore.firestore().collection("languages").document("ja")
    // Create a reference to the file you want to download
    var serverImageRef = Storage.storage().reference().child("image").child("ja").child("server_image.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        //iOS端末の設定言語を取得
        let languages = NSLocale.preferredLanguages
        print(languages) // ["ja-JP", "en-JP"]
        let language = languages[0].prefix(2)
        print(language) // ja
        
        
        if language == "ja" {
            // iPhoneの設定が日本語設定だった場合
            //サーバー上のテキスト
            serverTextRef = db.collection("languages").document("ja")
            //ローカル上の画像
            localImage.image = UIImage(systemName: "yensign.square.fill")
            //サーバー上の画像
            // Create a reference to the file you want to download
            serverImageRef = storageRef.child("image").child("ja").child("server_image.png")
        }
        else {
            // iPhoneの設定がそれ以外の言語設定だった場合
            serverTextRef = db.collection("languages").document("en")
            localImage.image = UIImage(systemName: "dollarsign.square.fill")
            serverImageRef = storageRef.child("image").child("en").child("server_image.png")
        }
        
        
        //ローカル上のテキスト
        localText.text = NSLocalizedString("local_text", comment: "")
        localImageText.text = NSLocalizedString("local_image_text", comment: "")
        serverImageText.text = NSLocalizedString("server_image_text", comment: "")
        
        //サーバー上のテキスト
        serverTextRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let server_text = document.get("server_text") as! String
                print(server_text)
                self.serverText.text = server_text
            } else {
                print("Document does not exist")
            }
        }

        //サーバー上の画像
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        serverImageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("Uh-oh, an error occurred!")
            } else {
                // Data for "images/island.jpg" is returned
                self.serverImage.image = UIImage(data: data!)
                print("Data for images/island.jpg is returned")
          }
        }
        
        
    }

}
