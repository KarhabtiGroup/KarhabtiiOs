//
//  GradientUtils.swift
//  karhabti
//
//  Created by Marwen Krichen on 10/5/2022.
//

import UIKit

extension UIColor {
    static func colorFromHex(_ hex: Int) -> UIColor {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static func colorFromHex(_ hex: Int, alpha: Double) -> UIColor {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public convenience init?(hex: String) {
            let r, g, b, a: CGFloat

            if hex.hasPrefix("#") {
                let start = hex.index(hex.startIndex, offsetBy: 1)
                let hexColor = String(hex[start...])

                if hexColor.count == 8 {
                    let scanner = Scanner(string: hexColor)
                    var hexNumber: UInt64 = 0

                    if scanner.scanHexInt64(&hexNumber) {
                        r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                        g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                        b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                        a = CGFloat(hexNumber & 0x000000ff) / 255

                        self.init(red: r, green: g, blue: b, alpha: a)
                        return
                    }
                }
            }

            return nil
        }
    static func getPriceContainerGradient() -> CAGradientLayer {
        let colorTop = UIColor(hex: "#4533AAff")!.cgColor
        let colorBottom = UIColor(hex: "#ffffff00")!.cgColor
        let gl = CAGradientLayer()
        gl.startPoint = CGPoint(x: 0.0, y: 1.0)
        gl.endPoint = CGPoint(x: 1.0, y: 1.0)
        gl.colors = [ colorTop, colorBottom]
        gl.locations = [ 0.0, 0.9]
        gl.frame = CGRect.zero
        return gl
    }
}
