//
//  UIVIew Extension.swift
//  karhabti
//
//  Created by Marwen Krichen on 10/5/2022.
//

import UIKit

extension UIView {
 
    func addViewAnchorEqualConstraints(view: UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalTo: self.widthAnchor),
            view.heightAnchor.constraint(equalTo: self.heightAnchor),
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    func removeAllsubViews(){
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    func addShadow(color: CGColor?, opacity: Float, offset: CGSize, radius: CGFloat) {
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowColor = color
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
    
    func addCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    func addBorder(color: CGColor?, width: CGFloat) {
        layer.borderColor = color
        layer.borderWidth = width
    }
    
    @discardableResult
    func addBorder(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {

        var borders = [UIView]()

        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }


        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }

        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }

        return borders
    }
    
    func makeCircular() {
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true
    }
    
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    
    func addGradientColorBackground(gradient: CAGradientLayer) {
        self.backgroundColor = UIColor.clear
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
          let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
          let mask = CAShapeLayer()
          mask.path = path.cgPath
          layer.mask = mask
      }

}
