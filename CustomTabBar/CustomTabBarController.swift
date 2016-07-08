//
//  CustomTabBarController.swift
//  CustomTabBarController
//
//  Created by eugene golovanov on 7/7/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit


    let hartBlu = UIColor(red: 0.231, green: 0.741, blue: 0.792, alpha: 1.000)
    let hartBlueberry = UIColor(red: 0.290, green: 0.584, blue: 1.000, alpha: 1.000)



class CustomTabBarController: UITabBarController {
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - Properties

    let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 55, height: 55))
    var blurEffectView = UIVisualEffectView()
    private var effectsViewVisible = false
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Disable middle items
        if let items = self.tabBar.items {
            items[1].enabled = false
        }
        
        let offset:CGFloat = 20
        let tabBg = UIImageView(frame: CGRectMake(0, -offset, self.tabBar.frame.size.width, self.tabBar.frame.size.height+offset))
        tabBg.image = UIImage(named: "tabbarBg")
        tabBg.contentMode = UIViewContentMode.ScaleAspectFill
        self.tabBar.insertSubview(tabBg, atIndex: 0)

        self.setupEffectsView()
        self.setupMiddleButton()

    
    }
    
    
    
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - Setups
    
    func setupMiddleButton() {
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = self.view.bounds.height - menuButtonFrame.height - 5
        menuButtonFrame.origin.x = self.view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        menuButton.backgroundColor = hartBlu
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        menuButton.titleLabel?.font = UIFont.systemFontOfSize(60)
        menuButton.setTitleColor(hartBlueberry, forState: UIControlState.Highlighted)
        menuButton.setTitle("+", forState: .Normal)
        menuButton.titleEdgeInsets = UIEdgeInsetsMake(-8, 0, 0, 0)
        self.view.addSubview(menuButton)
        self.view.bringSubviewToFront(menuButton)
        
        menuButton.addTarget(self, action: #selector(CustomTabBarController.menuButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    
    
    func setupEffectsView() {
        
        let someFrame = CGRect(
            x: 0,
            y: 66,
            width: view.frame.size.width,
            height: view.frame.size.height)
        
        // Blur Effect
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = someFrame
        blurEffectView.alpha = 0
        
        self.view.addSubview(blurEffectView)
        
        // Label
        let incomeMessageLabel = UILabel(frame: CGRect(
            x: 0,
            y: 0,
            width: blurEffectView.frame.size.width,
            height: blurEffectView.frame.size.height))
        incomeMessageLabel.textColor = UIColor.blackColor()
        incomeMessageLabel.text = "Super Blurred View"
        incomeMessageLabel.font = UIFont.systemFontOfSize(22.0)
        incomeMessageLabel.backgroundColor = UIColor.clearColor()
        incomeMessageLabel.textAlignment = NSTextAlignment.Center
        incomeMessageLabel.numberOfLines = 0
        
        blurEffectView.contentView.addSubview(incomeMessageLabel)
        
    }

    
    
    
    
    
    
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - Actions
    
    func menuButtonAction(sender: UIButton) {
//        self.selectedIndex = 1
        
        if self.effectsViewVisible == false {
            self.effectsViewVisible = true
        } else {
            self.effectsViewVisible = false
        }
        
        self.animateEffectsView(toVisibilty: self.effectsViewVisible)
        self.animateButton()
        
    }
    
    
    
    
    
    //MARK: - Infinite Rotation Animation
    
    func animateButton() {
        
    ////////rotate circle
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnim.duration = 0.5
        rotationAnim.repeatCount = 1
        rotationAnim.fromValue = 0.0
        rotationAnim.toValue = Float(M_PI * 2.0)
        rotationAnim.fillMode = kCAFillModeForwards
        rotationAnim.removedOnCompletion = true
        
    //////scale animation
        let scaleAnimate:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimate.fromValue = 1
        scaleAnimate.toValue = 0.9
        scaleAnimate.duration = 0.2
        scaleAnimate.autoreverses = true
        scaleAnimate.removedOnCompletion = true
        scaleAnimate.setValue("scaleAnim", forKey: "name")
        scaleAnimate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = 1.5
        group.animations = [scaleAnimate,rotationAnim]

        self.menuButton.layer.addAnimation(group, forKey: "buttonAnim")
        
        
    }
    
    
    
    func animateEffectsView (toVisibilty toVisibilty:Bool) {
        UIView.animateWithDuration(0.3) {
            self.blurEffectView.alpha = CGFloat(toVisibilty)
        }
    }

    
    
    
    
    
    
}