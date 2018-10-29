//
//  HHCodeView.swift
//  HHCodeView
//
//  Created by Mac on 2018/10/20.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit


protocol HHCodeViewDelegate {
    func HHCodeDidFinishedInput(codeView:HHCodeView,code:String)
}

class HHCodeView: UIView {

    var delegate:HHCodeViewDelegate?
    
    /// 框框的数组
    var textfields = [UITextField]()
    
    /// 验证码间隔
    let margin:CGFloat = 10
    
    /// 框框的大小
    let width:CGFloat = 45
    
    /// 框框个数
    var count = 4

    init(frame: CGRect,num:Int = 4,margin:CGFloat = 10) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cleanVerificationCodeView(){
        
        for tf in textfields {
            tf.text = ""
        }
        textfields.last?.becomeFirstResponder()
    }
}




extension HHCodeView {
    fileprivate func setupUI() {
        self.isUserInteractionEnabled = false
        
        // 计算左间距
        let leftmargin = (UIScreen.main.bounds.width - width * CGFloat(count) - CGFloat(count - 1) * margin) / 2
        
        // 创建 n个 UITextFiedl
        for i in 0..<count{
            
            let rect = CGRect(x: leftmargin + CGFloat(i)*width + CGFloat(i)*margin, y: 0, width: width, height: width)
            
            let view = UIView.init(frame: rect)
            view.layer.cornerRadius = 5
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.green.cgColor
            view.layer.masksToBounds = true
            let tf = createTextField(frame: rect)
            tf.tag = i
            textfields.append(tf)
            view .addSubview(tf)
            addSubview(view)
        }
        
        if count < 1 {
            return
        }
        
        textfields.first?.becomeFirstResponder()
        
    }
    
    private func createTextField(frame:CGRect)->UITextField{
        
        let tf = HHTextField(frame: CGRect(x: 5, y: 5, width: frame.width-10, height: frame.height - 10))
        tf.borderStyle = .none
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 32)
        tf.textColor = UIColor.red
        tf.delegate = self
        tf.deleteDelegate = self
        tf.keyboardType = .numberPad
        return tf
        
    }
    
}

extension HHCodeView : UITextFieldDelegate,HHTextFieldDeleteDelegate {
   
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !textField.hasText {
            let index = textField.tag
            textField.resignFirstResponder()
            if index == count - 1 {
                textfields[index].text = string
                // 拼接结果
                var code = ""
                for tf in textfields{
                    code += tf.text ?? ""
                }
                delegate?.HHCodeDidFinishedInput(codeView: self, code: code)
                return false
            }
            textfields[index].text = string
            textfields[index + 1].becomeFirstResponder()
        }else if string == "" {
            return true
        }
        return false
    }
    
    
    func didClickBackWard() {
        for i in 1..<count{
            if !textfields[i].isFirstResponder {
                continue
            }
            textfields[i].resignFirstResponder()
            textfields[i-1].becomeFirstResponder()
            textfields[i-1].text = ""
            
        }
        
    }
    
    
}
