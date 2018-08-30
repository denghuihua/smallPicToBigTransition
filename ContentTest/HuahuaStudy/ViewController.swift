//
//  ViewController.swift
//  HuahuaStudy
//
//  Created by huihuadeng on 2018/8/29.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     var imgView: UIImageView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 100, y: 100, width: 100, height: 100);
        self.view.addSubview(imageView)
        
        imageView.image = UIImage(named: "IMG_0461.jpg")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.red
        imgView = imageView
        
        let btn = UIButton(type:.custom)
        btn.frame = CGRect(x: 20, y: 20, width: 44, height: 44)
        self.view.addSubview(btn)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action:  #selector(btnAction), for: UIControlEvents.touchUpInside)
    }
    
    @objc func btnAction() {
        print("btnAction")
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { 
            self.imgView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }) { (finish:Bool) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

