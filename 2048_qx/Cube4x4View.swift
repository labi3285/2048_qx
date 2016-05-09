//
//  Cube4x4View.swift
//  2048_qx
//
//  Created by Richard.q.x on 16/5/3.
//  Copyright © 2016年 labi3285_lab. All rights reserved.
//

import UIKit

class Cube4x4View: UIView {
    
    //MARK: - 接口
    
    var respondScore: ((score:CGFloat)->())?
    var respondYouWin: (()->())?
    var respondGameOver: (()->())?

    func initGame() {
        for cubeView in cubeViews {
            cubeView.empty = true
        }
        randomANewNumber()
        randomANewNumber()
        score = 0
        gameSet = false
    }
    
    func move(dir: Direction) {
        
        if gameSet {
            return
        }
        
        var needsRandomANewNumber: Bool = false
        
        switch dir {
        case .Up:
            for y in 0..<RowCount {
                for x in 0..<RowCount {
                    if let cubeView = getCubeView(x, y: y) {
                        if canMoveCubeViewOneStep(cubeView, dir: dir) {
                            moveCubeViewStepByStep(cubeView, dir: dir)
                            needsRandomANewNumber = true
                        }
                    }
                }
            }
        case .Down:
            for y in 0..<RowCount {
                for x in 0..<RowCount {
                    if let cubeView = getCubeView(x, y: RowCount - y - 1) {
                        if canMoveCubeViewOneStep(cubeView, dir: dir) {
                            moveCubeViewStepByStep(cubeView, dir: dir)
                            needsRandomANewNumber = true
                        }
                    }
                }
            }
        case .Left:
            for x in 0..<RowCount {
                for y in 0..<RowCount {
                    if let cubeView = getCubeView(x, y: y) {
                        if canMoveCubeViewOneStep(cubeView, dir: dir) {
                            moveCubeViewStepByStep(cubeView, dir: dir)
                            needsRandomANewNumber = true
                        }
                    }
                }
            }
        case .Right:
            for x in 0..<RowCount {
                for y in 0..<RowCount {
                    if let cubeView = getCubeView(RowCount - x - 1, y: y) {
                        if canMoveCubeViewOneStep(cubeView, dir: dir) {
                            moveCubeViewStepByStep(cubeView, dir: dir)
                            needsRandomANewNumber = true
                        }
                    }
                }
            }
        }
        
        if checkWin() {
            YOUWIN()

        } else {
            if needsRandomANewNumber {
                randomANewNumber()
            }
        }
        
        if getEmptyCubViews() == nil {
            GAMEOVER()
        }
        
    }
    
    //MARK: - 初始化
    
    private lazy var cubeViews: [CubeView] = {
        var cubeViews = [CubeView]()
        for i in 0..<(RowCount * RowCount) {
            cubeViews.append(CubeView(x: i % RowCount, y: i / RowCount))
        }
        return cubeViews;
    }()

    private var score: CGFloat = 0
    private var gameSet: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.cubeBack
        userInteractionEnabled = false
        
        layer.cornerRadius = Size.cubeBackCornerRadius
        clipsToBounds = true
        
        setUpCubeViews()
        initGame()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let winSize = bounds.size.width;
        let margin = Size.cubeMagin
        let cubeSize = (winSize - margin * (CGFloat(RowCount) + 1)) / CGFloat(RowCount);

        for cubeView in cubeViews {
            let row = cubeView.y
            let col = cubeView.x
            cubeView.frame = CGRectMake(margin + (cubeSize + margin) * CGFloat(col), margin + (cubeSize + margin) * CGFloat(row), cubeSize, cubeSize)
        }
    }
    
    //MARK: - 私有

    private func setUpCubeViews() {
        var i: Int = 0
        for cubeView in cubeViews {
            addSubview(cubeView)
            i = i + 1
        }
    }
    
    private func canMoveCubeViewOneStep(cubeView: CubeView, dir: Direction) -> Bool {
        if cubeView.empty {
            return false
        }
        if let _cubeView = getCubeView(cubeView, dir: dir) {
            if _cubeView.empty {
                return true
            } else {
                return _cubeView.number == cubeView.number
            }
        }
        return false
    }
    
    private func moveCubeViewStepByStep(cubeView: CubeView, dir: Direction) {
        if let next = getCubeView(cubeView, dir: dir) {
            if next.number == cubeView.number {
                next.number = next.number * 2
                addScore(next.number)
            } else {
                next.number = cubeView.number
                next.empty = cubeView.empty
            }
            cubeView.empty = true
            
            if canMoveCubeViewOneStep(next, dir: dir) {
                moveCubeViewStepByStep(next, dir: dir)
            }
        }
    }
    
    private func getCubeView(cubeView: CubeView, dir: Direction) -> CubeView? {
        let offset = dir.offset()
        return getCubeView(cubeView.x + offset.x, y: cubeView.y + offset.y)
    }
    
    private func getCubeView(x: Int, y: Int) -> CubeView? {
        let idx = y * RowCount + x;
        if x < 0 || y < 0 || x >= RowCount || y >= RowCount || idx > cubeViews.count - 1 {
            return nil
        }
        return cubeViews[idx]
    }
    
    private func getEmptyCubViews() -> [CubeView]? {
        var emptyCubViews = [CubeView]()
        for cubeView in cubeViews {
            if cubeView.empty {
                emptyCubViews.append(cubeView)
            }
        }
        if emptyCubViews.count > 0 {
            return emptyCubViews
        }
        return nil
    }
    
    private func randomANewNumber() {
        if let emptyCubViews = getEmptyCubViews() {
            let idx = Int(arc4random_uniform(UInt32(emptyCubViews.count)))
            let cubeView = emptyCubViews[idx]
            cubeView.number = 2
            cubeView.empty = false
        }
    }
    
    private func checkWin() -> Bool {
        for cubeView in cubeViews {
            if cubeView.number >= 2048 {
                return true
            }
        }
        return false
    }
    
    private func addScore(number: Int) {
        if let block = respondScore {
            let add = CGFloat(number)
            score += add
            block(score: score)
        }
    }
    
    private func YOUWIN() {
        gameSet = true
        if let block = respondYouWin {
            block()
        }
    }
    
    private func GAMEOVER() {
        gameSet = true
        if let block = respondGameOver {
            block()
        }
    }
    
}