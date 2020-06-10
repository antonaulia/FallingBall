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
       
        createBall(at: coordinateTouch)
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
        
        view.addSubview(ball)
        
        gravityBehavior.addItem(ball)
        collisionBehavior.addItem(ball)
        
    }


}

