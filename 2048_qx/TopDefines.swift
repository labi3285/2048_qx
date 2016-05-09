//
//  TopDefines.swift
//  2048_qx
//
//  Created by Richard.q.x on 16/5/3.
//  Copyright © 2016年 labi3285_lab. All rights reserved.
//

import UIKit

let RowCount: Int = 4

enum Direction {
    case Up
    case Down
    case Left
    case Right
    
    func string() -> String {
        switch self {
        case Up:
            return "⬆️"
        case Down:
            return "⬇️"
        case Left:
            return "⬅️"
        case Right:
            return "➡️"
        }
    }
    
    func offset() -> (x: Int, y: Int) {
        switch self {
        case Up:
            return (0, -1)
        case Down:
            return (0, 1)
        case Left:
            return (-1, 0)
        case Right:
            return (1, 0)
        }
    }
}

enum Size {
    static let cubeBackCornerRadius: CGFloat = 3.0
    static let cubeCornerRadius: CGFloat = 3.0
    
    static let cubeMagin: CGFloat = 6.0

}

enum Color {
    
    static func RGB(R: Int, _ G: Int, _ B: Int) -> UIColor {
        return UIColor(red: CGFloat(R) / 255.0, green: CGFloat(G) / 255.0, blue: CGFloat(B) / 255.0, alpha: 1.0)
    }
    
    static let cubeBack = Color.RGB(188, 173, 162)
    
    static let cube0    = Color.RGB(204, 192, 180)
    static let cube2    = Color.RGB(238, 228, 218)
    static let cube4    = Color.RGB(236, 224, 200)
    static let cube8    = Color.RGB(242, 177, 121)
    static let cube16   = Color.RGB(236, 141, 83)
    static let cube32   = Color.RGB(245, 124, 95)
    static let cube64   = Color.RGB(233, 89, 55)
    static let cube128  = Color.RGB(243, 217, 107)
    static let cube256  = Color.RGB(241, 208, 75)
    static let cube512  = Color.RGB(228, 192, 42)
    static let cube1024 = Color.RGB(227, 186, 20)
    
    static let cube2048 = Color.RGB(230, 170, 10)
    
    static let cubeTextDark  = Color.RGB(99, 91, 82)
    static let cubeTextLight = Color.RGB(245, 245, 245)
    
    static func cubeColor(num: Int) -> (cube: UIColor, text: UIColor) {
        switch num {
        case 0:
            return (cube0, cubeTextDark)
        case 2:
            return (cube2, cubeTextDark)
        case 4:
            return (cube4, cubeTextDark)
        case 8:
            return (cube8, cubeTextDark)
        case 16:
            return (cube16, cubeTextLight)
        case 32:
            return (cube32, cubeTextLight)
        case 64:
            return (cube64, cubeTextLight)
        case 128:
            return (cube128, cubeTextDark)
        case 256:
            return (cube256, cubeTextDark)
        case 512:
            return (cube512, cubeTextDark)
        case 1024:
            return (cube1024, cubeTextDark)
        case 2048:
            return (cube2048, cubeTextLight)
        default:
            return (cube0, cubeTextDark)
        }
    }
    
}
