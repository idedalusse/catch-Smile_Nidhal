//--------------------------------------------------
//--------------------------------------------------
import UIKit
import Foundation
//--------------------------------------------------
//--------------------------------------------------
class Bounce {
    //--------------------------------------------------
    var b: UIView!
    var lw: UIView!
    var rw: UIView!
    var tw: UIView!
    var bw: UIView!
    //--------------------------------------------------
    init(ball b: UIView,
         left_wall lw: UIView,
         right_wall rw: UIView,
         top_wall tw: UIView,
         bottom_wall bw: UIView) {
        self.b = b
        self.lw = lw
        self.rw = rw
        self.tw = tw
        self.bw = bw
    }
    //--------------------------------------------------
    func returnCosSinAfterTouch(sin s: Double, cos c: Double) -> [Double] {
        let r = atan2f(Float(s), Float(c))
        var d = r * (180 / Float(Double.pi))
        if b.frame.intersects(lw.frame) || b.frame.intersects(rw.frame) {
            if d > 175 && d < 185 {
                d = 185
            } else if d > -5 && d < 5 {
                d = 5
            }
            d = 180 - d
        }
        if b.frame.intersects(tw.frame) {
            let p = abs(d)
            d = p
        }
        if b.frame.intersects(bw.frame) {
            if d < 90 {
                d += 5
            } else {
                d -= 5
            }
            let n = (d) * -1
            d = n
        }
        return [__sinpi(Double(d/180.0)), __cospi(Double(d/180.0))]
    }
    //--------------------------------------------------
}
//--------------------------------------------------
//--------------------------------------------------

