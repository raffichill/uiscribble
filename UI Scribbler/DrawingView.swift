//
//  DrawingView.swift
//  UI Scribbler
//
//  Created by Raffi Chilingaryan on 2/1/24.
//

import Foundation
import UIKit

// A UIView subclass for handling drawing
class DrawingView: UIView {
    // Stores all the paths drawn
    var paths: [UIBezierPath] = []
    
    // Current path
    private var currentPath: UIBezierPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.black.setStroke()
        paths.forEach { path in
            path.stroke()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentPath = UIBezierPath()
        currentPath?.lineWidth = 2
        if let touch = touches.first {
            currentPath?.move(to: touch.location(in: self))
        }
        if let currentPath = currentPath {
            paths.append(currentPath)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let currentPath = currentPath {
            currentPath.addLine(to: touch.location(in: self))
            setNeedsDisplay()
        }
    }
    
    func undo() {
        _ = paths.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        paths.removeAll()
        setNeedsDisplay()
    }
    
    func imageFromDrawing() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        self.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    
}
