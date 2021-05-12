//
//  ViewController.swift
//  KeyboardDemo
//
//  Created by waitwalker on 2021/3/31.
//

import UIKit
import KeyboardKit

class ViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textField = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        textField.backgroundColor = .red
        self.view.addSubview(textField)
        
    }


}

