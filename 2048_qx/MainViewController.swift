//
//  MainViewController.swift
//  2048_qx
//
//  Created by Richard.q.x on 16/5/3.
//  Copyright © 2016年 labi3285_lab. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var cubesView: Cube4x4View = Cube4x4View()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 4.0
        label.clipsToBounds = true
        label.text = "0"
        label.font = UIFont.boldSystemFontOfSize(20.0)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.lightGrayColor()
        return label
    }()
    
    lazy var gameSetLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 5.0
        label.clipsToBounds = true
        label.font = UIFont.boldSystemFontOfSize(30.0)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.hidden = true
        return label
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(cubesView)
        view.addSubview(scoreLabel)
        view.addSubview(gameSetLabel)

        cubesView.respondScore =  { [weak self] score in
            self?.scoreLabel.text = "\(Int(score))"
        }
        
        cubesView.respondYouWin = { [weak self] in
            self?.gameSetLabel.hidden = false
            self?.gameSetLabel.text = "You Win"
            self?.gameSetLabel.backgroundColor = UIColor.lightGrayColor()
        }
        
        cubesView.respondGameOver = { [weak self] in
            self?.gameSetLabel.text = "Game Over"
            self?.gameSetLabel.hidden = false
            self?.gameSetLabel.backgroundColor = UIColor.redColor()
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let winW = UIScreen.mainScreen().bounds.size.width
        let winH = UIScreen.mainScreen().bounds.size.height
        if winH >= winW {
            let size = winW - 20 * 2;
            cubesView.frame = CGRectMake(20, (winH - size) / 2, size, size)
            scoreLabel.frame = CGRectMake(CGRectGetMaxX(cubesView.frame) - 100, CGRectGetMinY(cubesView.frame) - 35, 100, 30)
        } else {
            let size = winH - 20 * 2;
            cubesView.frame = CGRectMake((winW - size) / 2, 20, size, size)
            scoreLabel.frame = CGRectMake(CGRectGetMaxX(cubesView.frame) + 10, CGRectGetMinY(cubesView.frame) , 100, 30)
        }
        gameSetLabel.bounds = CGRectMake(0, 0, 200, 70)
        gameSetLabel.center = view.center

    }
    
    //MARK: - 交互
    
    var x0: CGFloat!
    var y0: CGFloat!
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let point = touch!.locationInView(view)
        x0 = point.x
        y0 = point.y
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let point = touch!.locationInView(view)
        let x1 = point.x
        let y1 = point.y
        
        let dx = x0 - x1
        let dy = y0 - y1
        
        let s = sqrt(pow(x0 - x1, 2) + pow(y0 - y1, 2))
        
        if s < 50 { return }
        
        var dir: Direction
        
        if x0 <= x1 {
            if y0 <= y1 {
                dir = abs(dx) >= abs(dy) ? .Right : .Down
            } else {
                dir = abs(dx) >= abs(dy) ? .Right : .Up
            }
        } else {
            if y0 <= y1 {
                dir = abs(dx) >= abs(dy) ? .Left : .Down
            } else {
                dir = abs(dx) >= abs(dy) ? .Left : .Up
            }
        }
        
        cubesView.move(dir)
        print(dir.string())
    }

}
