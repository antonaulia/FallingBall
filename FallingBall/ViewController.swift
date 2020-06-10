//
//  ViewController.swift
//  FallingBall
//
//  Created by Antonius F Aulia on 10/06/20.
//  Copyright © 2020 Antonius F Aulia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dynamicAnimator : UIDynamicAnimator!
    var gravityBehavior = UIGravityBehavior()
    var collisionBehavior = UICollisionBehavior()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupDynamicAnimator()
    }
    
    private func setupDynamicAnimator(){
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        collisionBehavior.collisionMode = .everything
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        dynamicAnimator.addBehavior(gravityBehavior)
        dynamicAnimator.addBehavior(collisionBehavior)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let coordinateTouch = touches.first?.location(in: view)
        guard let coordinate = coordinateTouch else {return}
//        membatasi area pembuatan bola
        let widthView = view.frame.size.width
        if coordinate.x < (widthView/2) {
//            createBall(at: coordinate)
            createSquare(at: coordinate)
        }
    }
    
    func createSquare(at coordinate:CGPoint?) {
        let square = UIView()
        
        guard let coordinate = coordinate else {return}
        let size = CGSize(width: 50, height: 50)
        
        square.frame = CGRect(origin: coordinate, size: size)
        square.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        view.addSubview(square)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        
        let cornerRadiusAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius))
        cornerRadiusAnimation.fromValue = 0
        cornerRadiusAnimation.toValue = 10
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(3)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear))
        
        square.layer.add(scaleAnimation, forKey: "scaling_animation")
        square.layer.add(cornerRadiusAnimation, forKey: "corner_radius_animation")
        
        CATransaction.setCompletionBlock({
            square.frame.size = CGSize(width: size.width*2, height: size.height)
            square.layer.cornerRadius = 10
            square.layer.masksToBounds = true
        })
        CATransaction.commit()
        
    }
    
    func createBall(at coordinate:CGPoint?){
        let ball = UIView()
        guard let coordinate = coordinate else {return}
        
        let diameter = CGFloat(Int.random(in: 10...60))
        let size = CGSize(width: diameter, height: diameter)
        
        ball.frame = CGRect(origin: coordinate, size: size)
        
        ball.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        
        ball.layer.cornerRadius = diameter/2
        ball.layer.masksToBounds = true
        
        ball.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ball.layer.borderWidth = 2
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(BallTapped(_:)))
        ball.addGestureRecognizer(tap)
        
        view.addSubview(ball)
        
        gravityBehavior.addItem(ball)
        collisionBehavior.addItem(ball)
        
    }
    
    @objc func BallTapped(_ sender: UITapGestureRecognizer){
        let ball = sender.view
        UIView.animate(withDuration: 1, animations: {
            ball?.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            ball?.alpha = 0
        }) { (isAnimated) in
            ball?.removeFromSuperview()
            self.collisionBehavior.removeItem(ball!)
        }
        
    }


}

