//
//  AdditionalClasses.swift
//  ChatPlayground
//
//  Created by David Salzer on 18/10/2020.
//

import Foundation
import UIKit

class CustomRoundedCornerRectangle: UIView {
    lazy var shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        // apply properties related to the path
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.strokeColor = UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 1.0).cgColor
        shapeLayer.position = CGPoint(x: 0, y: 0)
        
        // add the new layer to our custom view
        //self.layer.addSublayer(shapeLayer)
        self.layer.insertSublayer(shapeLayer, at: 0)
    }
    
    override func layoutSubviews() {
        
        let path = UIBezierPath()
        let largeCornerRadius: CGFloat = 18
        let smallCornerRadius: CGFloat = 10
        let upperCornerSpacerRadius: CGFloat = 2
        let imageToArcSpace: CGFloat = 5
        let rect = bounds
        
        // move to starting point
        path.move(to: CGPoint(x: rect.minX + smallCornerRadius, y: rect.maxY))
        
        // draw bottom left corner
        path.addArc(withCenter: CGPoint(x: rect.minX + smallCornerRadius, y: rect.maxY - smallCornerRadius), radius: smallCornerRadius,
                    startAngle: .pi / 2, // straight down
                    endAngle: .pi, // straight left
                    clockwise: true)
        
        // draw left line
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + smallCornerRadius))
        
        // draw top left corner
        path.addArc(withCenter: CGPoint(x: rect.minX + smallCornerRadius, y: rect.minY + smallCornerRadius), radius: smallCornerRadius,
                    startAngle: .pi, // straight left
                    endAngle: .pi / 2 * 3, // straight up
                    clockwise: true)
        
        // draw top line
        path.addLine(to: CGPoint(x: rect.maxX - largeCornerRadius, y: rect.minY))
        
        // draw concave top right corner
        // first arc
        path.addArc(withCenter: CGPoint(x: rect.maxX + largeCornerRadius, y: rect.minY + upperCornerSpacerRadius), radius: upperCornerSpacerRadius, startAngle: .pi / 2 * 3, // straight up
                    endAngle: .pi / 2, // straight left
                    clockwise: true)
        
        // second arc
        path.addArc(withCenter: CGPoint(x: rect.maxX + largeCornerRadius + imageToArcSpace, y: rect.minY + largeCornerRadius + upperCornerSpacerRadius * 2 + imageToArcSpace), radius: largeCornerRadius + imageToArcSpace, startAngle: CGFloat(240.0).toRadians(), // up with offset
                    endAngle: .pi, // straight left
                    clockwise: false)
        
        // draw right line
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - smallCornerRadius))
        
        // draw bottom right corner
        path.addArc(withCenter: CGPoint(x: rect.maxX - smallCornerRadius, y: rect.maxY - smallCornerRadius), radius: smallCornerRadius,
                    startAngle: 0, // straight right
                    endAngle: .pi / 2, // straight down
                    clockwise: true)
        
        // draw bottom line to close the shape
        path.close()
        
        shapeLayer.path = path.cgPath
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}

class RoundImageView: UIImageView {
    override func layoutSubviews() {
        layer.masksToBounds = true
        layer.cornerRadius = bounds.size.height * 0.5
    }
}

class GrayGradientView: UIView {
    private var gradLayer: CAGradientLayer!
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    func commonInit() -> Void {
        
        let myColors: [UIColor] = [
            UIColor(white: 0.95, alpha: 1.0),
            UIColor(white: 0.90, alpha: 1.0),
        ]
        
        gradLayer = self.layer as? CAGradientLayer
        
        // assign the colors (we're using map to convert UIColors to CGColors
        gradLayer.colors = myColors.map({$0.cgColor})
        
        // start at the top
        gradLayer.startPoint = CGPoint(x: 0.25, y: 0.0)
        
        // end at the bottom
        gradLayer.endPoint = CGPoint(x: 0.75, y: 1.0)
        
    }
}
