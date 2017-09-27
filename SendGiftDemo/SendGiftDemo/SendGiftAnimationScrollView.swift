//
//  SendGiftAnimationScrollView.swift
//  SendGiftDemo
//
//  Created by Bolo on 2017/9/26.
//  Copyright © 2017年 Bolo. All rights reserved.
//

import UIKit

struct AnimationModel{
    var userHead:String?
    var giftNum:Int?
    var giftHeadImage:String?
    var giftUserName:String?
    var giftName:String?
    
    init(dict:[String:String]) {
        
        if let userHead = dict["userhead"]{
            self.userHead = userHead
        }
        
        if let giftName = dict["giftname"]{
            self.giftName = giftName
        }
        
        if let giftNum = Int(dict["giftnum"] ?? "0") {
            self.giftNum = giftNum
        }
        
        if let giftHeadImage = dict["giftheadimage"]{
            self.giftHeadImage = giftHeadImage
        }
        
        if let giftUserName = dict["giftusername"]{
            self.giftUserName = giftUserName
        }
        
    }
    
}

class AnimationLabel: UIView {
    var myTimer:Timer?
    var num:Int?
    var giftCount:Int?
    var model: AnimationModel?{
        didSet{
            self.headView.image = UIImage(named:model?.userHead ?? "head")
            self.giftImageView.image = UIImage(named:model?.giftHeadImage ?? "head")
            self.labelName.text = model?.giftUserName
            self.labelGift.text = "赠送\(model?.giftName ?? "匿名")"
        }
    }
    
    lazy var headView: UIImageView = {
        let frame = CGRect(x: 5, y: 5, width: self.frame.height - 10, height: self.frame.height - 10)
        return self.getImageView(frame: frame, stringImage: "head")
    }()
    
    lazy var labelName: UILabel = {
        let frame = CGRect(x: self.headView.frame.maxX+5, y: self.headView.frame.minY+5, width: self.frame.width - 10, height: 20)
        let label = self.getlabeView(frame: frame, title: "这就是我的名字")
        label.textColor = UIColor.rgb(239, 202, 139, 1.0)
        return label
    }()
    
    lazy var labelGift: UILabel = {
        let frame = CGRect(x: self.labelName.frame.minX, y: self.labelName.frame.maxY+5, width: self.frame.width, height: 20)
        let label = self.getlabeView(frame: frame, title: "赠送红唇")
        return label
    }()
    
    lazy var labelCount: UILabel = {
        let frame = CGRect(x: self.labelGift.frame.maxX + 5, y: self.labelGift.frame.minY, width: self.frame.width, height: 20)
        let label = self.getlabeView(frame: frame, title: "x1")
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.red
        return label
    }()
    
    lazy var giftImageView: UIImageView = {
        let frame = CGRect(x: self.labelName.frame.maxX, y: 0, width: 40, height: 40)
        return self.getImageView(frame: frame, stringImage: "礼物")
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.num = 1
        addSubview(headView)
        addSubview(labelName)
        addSubview(labelGift)
        addSubview(labelCount)
        addSubview(giftImageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SendGiftAnimationScrollView: UIScrollView {

    var numHeight:CGFloat!
    var viewY:CGFloat!
    var margin:CGFloat!
    override init(frame: CGRect) {
        super.init(frame: frame)
        numHeight = 0
        viewY = 350
        margin = 85
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAnimationLabel(dict: [String:String]){
        let animate = AnimationLabel(frame: CGRect(x: -100, y: self.viewY, width: 100, height: 80))
        let model = AnimationModel(dict: dict)
        animate.model = model
        animate.giftCount = model.giftNum
        self.addanimationView(sender: animate)
        
        self.viewY! += margin
    }
    
    private func addanimationView(sender:AnimationLabel) {
        var frame = sender.frame
        frame.origin.x = 0
        self.addSubview(sender)
        UIView.animate(withDuration: 0.5, animations: {
            sender.frame = frame
        }) { (finish) in
            let point = CGPoint(x: 0, y: self.numHeight)
            self.setContentOffset(point, animated: true)
            sender.startTimer()
        }
        
        self.numHeight! += margin
    }
}

// MARK: - extension

extension UIColor{
    class func rgb(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat, _ a:CGFloat) -> UIColor{
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}

extension AnimationLabel{
    
    func getImageView(frame:CGRect, stringImage:String) -> UIImageView {
        let imageView = UIImageView(frame: frame)
        imageView.image = UIImage(named:stringImage)
        return imageView
    }
    
    func getlabeView(frame:CGRect, title:String) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = title
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }
    
    func startTimer(){
        self.myTimer = Timer(timeInterval: 0.7, target: self, selector: #selector(mystartAnimation), userInfo: nil, repeats: true)
        RunLoop.current.add(self.myTimer!, forMode: .defaultRunLoopMode)
    }
    
    func stopTimer(){
        self.myTimer?.invalidate()
        self.myTimer = nil
    }
    
    
    @objc func mystartAnimation(){
        let add = floorf(Float(self.giftCount!) / 5.0)
        if self.num! >= self.giftCount! {
            self.num = self.giftCount
            self.stopTimer()
            UIView.animate(withDuration: 1.0, animations: {
                self.alpha = 0
            }, completion: { finish in
                self.removeFromSuperview()
            })
        }
        
        UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: .allowUserInteraction, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0, animations: {
                self.labelCount.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.labelCount.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
            
        }) { (finish) in
            
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 8, options: .curveEaseInOut, animations: {
                self.labelCount.text = "x\(self.num!)"
                self.num! += Int(add)
                self.labelCount.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { finish in
                
            })
        }
        
    }
}


