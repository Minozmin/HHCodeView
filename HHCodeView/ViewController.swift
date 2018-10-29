//
//  ViewController.swift
//  HHCodeView
//
//  Created by Mac on 2018/10/20.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController,HHCodeViewDelegate {
    
    

    var infolabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let v = HHCodeView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 100))
        v.delegate = self
        view.backgroundColor = UIColor.white
        view.addSubview(v)
        
        infolabel.frame = CGRect(x: 0, y: 300, width: UIScreen.main.bounds.width, height: 30)
        infolabel.textAlignment = .center
        infolabel.text = "这里展示验证码"
        infolabel.font = UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(infolabel)
    }
    
    func HHCodeDidFinishedInput(codeView: HHCodeView, code: String) {
        infolabel.text = code
        if code != "9021" {
            codeView.cleanVerificationCodeView()
        }
    }

}

