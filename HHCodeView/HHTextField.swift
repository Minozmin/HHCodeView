//
//  HHTextField.swift
//  HHCodeView
//
//  Created by Mac on 2018/10/20.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

protocol HHTextFieldDeleteDelegate {
    func didClickBackWard()
}

class HHTextField: UITextField {
    
    var deleteDelegate:HHTextFieldDeleteDelegate?
    
    override func deleteBackward() {
        super.deleteBackward()
        deleteDelegate?.didClickBackWard()
        
    }
    
}

