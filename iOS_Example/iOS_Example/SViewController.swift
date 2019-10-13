//
//  SViewController.swift
//  iOS_Example
//
//  Created by chdo on 2019/10/11.c
//  Copyright © 2019 chdo. All rights reserved.
//

import UIKit
import Alamofire


class MOddd {
    lazy var time = Date()
}

class SViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        // Do any additional setup after loading the view.
        
        
        Alamofire.request("https://www.baidu.com").response { (res) in
            
        }
    }
    
}
