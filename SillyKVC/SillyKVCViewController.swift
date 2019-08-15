//
//  SillyKVCViewController.swift
//  SillyKVC
//
//  Created by K Y on 8/15/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

@objcMembers
class SillyModel: NSObject {
    @objc private var name: String
    @objc private var age: Int
    @objc private var title: String
    init(_ name: String, _ age: Int, _ title: String) {
        self.name = name
        self.age = age
        self.title = title
        super.init()
    }
}

class SillyKVCViewController: UIViewController {

    // MARK: - Interface Builder Outlets
    
    @IBOutlet var nameView: KeyValueView! {
        didSet {
            nameView.key = "name"
            nameView.val = item.value(forKey: "name") as? String
            item.addObserver(self, forKeyPath: "name", options: .new, context: nil)
        }
    }
    @IBOutlet var ageView: KeyValueView!{
        didSet {
            ageView.key = "age"
            ageView.val = String(item.value(forKey: "age") as? Int ?? 0)
            item.addObserver(self, forKeyPath: "age", options: .new, context: nil)
            
        }
    }
    @IBOutlet var titleView: KeyValueView!{
        didSet {
            titleView.key = "title"
            titleView.val = item.value(forKey: "title") as? String
            item.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        }
    }
    
    @IBOutlet var keyInputTextField: UITextField!
    @IBOutlet var valueInputTextField: UITextField!
    @IBOutlet var performButton: UIButton!
    
    // MARK: - Model Properties
    
    var item: SillyModel
    
    // MARK: - Lifecycle Methods
    
    required init?(coder aDecoder: NSCoder) {
        item = SillyModel("Roger", 47, "Buckaneer")
        super.init(coder: aDecoder)
    }
    
    deinit {
        item.removeObserver(self, forKeyPath: "name")
        item.removeObserver(self, forKeyPath: "age")
        item.removeObserver(self, forKeyPath: "title")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - KVO Override Methods
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        guard let change = change, let newVal = change[.newKey] else {
            return
        }
        switch keyPath {
        case "name":
            if let name = newVal as? String {
                nameView.val = name
            }
        case "age":
            if let age = newVal as? Int {
                ageView.val = String(age)
            }
        case "title":
            if let title = newVal as? String {
                titleView.val = title
            }
        default:
            return
        }
    }
    
    // MARK: - Custom Action Methods
    
    @IBAction func performButtonAction(_ sender: Any) {
        guard let key = keyInputTextField.text, key.isEmpty == false,
        let val = valueInputTextField.text, val.isEmpty == false else {
            return
        }
        if item.responds(to: Selector(key)) {
            item.setValue(val, forKey: key)
        }
        else {
            showAlert(text: "KeyPath \"\(key)\" does not exist!")
        }
    }

}

extension UIViewController {
    func showAlert(text: String) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}

