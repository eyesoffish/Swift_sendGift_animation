//
//  ViewController.swift
//  SendGiftDemo
//
//  Created by Bolo on 2017/9/26.
//  Copyright © 2017年 Bolo. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    var scrollView: SendGiftAnimationScrollView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView = SendGiftAnimationScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.7, height: view.frame.height))
        self.scrollView?.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.addSubview(self.scrollView!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let dic = ["userhead":"头像","giftnum":"99","giftheadimage":"礼物1","giftusername":"不一样的烟火","giftname":"皇冠"]
        let dic2 = ["userhead":"头像2","giftnum":"9","giftheadimage":"礼物2","giftusername":"简简单单","giftname":"红唇"]
        self.scrollView?.addAnimationLabel(dict: dic)
        self.scrollView?.addAnimationLabel(dict: dic2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

