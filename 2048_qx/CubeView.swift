//
//  CubeView.swift
//  2048_qx
//
//  Created by Richard.q.x on 16/5/3.
//  Copyright © 2016年 labi3285_lab. All rights reserved.
//

import UIKit

class CubeView: UIView {
    
    //MARK: - 接口
    
    private(set) var x: Int
    private(set) var y: Int
    
    var empty: Bool = true {
        didSet {
            if empty {
                number = 0
            }
        }
    }
    
    var number: Int = 0 {
        didSet {
            backgroundColor = Color.cubeColor(number).cube
            numberLabel.textColor = Color.cubeColor(number).text
            numberLabel.text = "\(number)"
            numberLabel.hidden = number == 0

            if number < 10 {
                numberLabel.font = UIFont.boldSystemFontOfSize(30)
            } else if number < 100 {
                numberLabel.font = UIFont.boldSystemFontOfSize(25)
            } else if number < 1000 {
                numberLabel.font = UIFont.boldSystemFontOfSize(20)
            }
        }
    }
    
    //MARK: - 私有
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.boldSystemFontOfSize(20.0)
        return label
    }()
    
    required init(x: Int, y: Int) {
        self.x = x
        self.y = y
        super.init(frame: CGRectZero)
        
        addSubview(numberLabel)
        
        layer.cornerRadius = Size.cubeCornerRadius
        clipsToBounds = true
        backgroundColor = Color.cube0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        numberLabel.frame = bounds
    }
    
}
