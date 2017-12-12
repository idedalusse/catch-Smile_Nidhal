//***********************
import UIKit
//***********************
class ViewController: UIViewController {
    //********** connexion des bouttons **********//
    @IBOutlet weak var ball: UIView!
    @IBOutlet weak var left_wall: UIView!
    @IBOutlet weak var top_wall: UIView!
    @IBOutlet weak var right_wall: UIView!
    @IBOutlet weak var bottom_wall: UIView!
    @IBOutlet weak var bloc1: UIView!
    @IBOutlet weak var bloc2: UIView!
    @IBOutlet weak var bloc3: UIView!
    @IBOutlet weak var player: UIView!
    @IBOutlet weak var paddle: UIView!

    //********* declarations des variables **************//
    var bounceObj: Bounce!
    var cos: Double!
    var sin: Double!
    var aTimer: Timer!
    var arr_of_blocs: [UIView]!
    //*************** function pour les paramettres de la ball ************//
    override func viewDidLoad() {
        super.viewDidLoad()
        bounceObj = Bounce(ball: ball, left_wall: left_wall, right_wall: right_wall, top_wall: top_wall, bottom_wall: paddle)
        ball.layer.cornerRadius = 12.5
        arr_of_blocs = [bloc1, bloc2, bloc3]
        startAnimation()
    }
    //******** function pour le debut de l'animation **********//
    func startAnimation() {
        let degrees = Double(arc4random_uniform(360))
        cos = __cospi(degrees/180)
        sin = __sinpi(degrees/180)
        aTimer = Timer.scheduledTimer(timeInterval: 0.002, target: self, selector: #selector(animateBall), userInfo: nil, repeats: true)
    }
    //************ alghoritme pour deplacement de la ball *************//
    @objc func animateBall() {
        ball.center.x += CGFloat(cos)
        ball.center.y += CGFloat(sin)
        
        for bloc in arr_of_blocs {
            if ball.frame.intersects(bloc.frame) {
                let forRandomX: UInt32 = 375 - 23 - 23 - 18 + 1
                let forRandomY: UInt32 = 667 - 23 - 136 - 18 + 1
                bloc.center.x = CGFloat(arc4random_uniform(forRandomX) + 23 + 9)
                bloc.center.y = CGFloat(arc4random_uniform(forRandomY) + 23 + 9)
                let degrees = Double(arc4random_uniform(360))
                cos = __cospi(degrees/180)
                sin = __sinpi(degrees/180)
            }
        }
        //***** pour disparaitre la ball qui a ete toucher ****//
        if ball.frame.intersects(bottom_wall.frame) {
            aTimer.invalidate()
            aTimer = nil
        }
        
        sin = bounceObj.returnCosSinAfterTouch(sin: sin, cos: cos)[0]
        cos = bounceObj.returnCosSinAfterTouch(sin: sin, cos: cos)[1]
    }
    //********* fonction pour toucher(faire bouger) le paddle *********//
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch: UITouch = touches.first!
        if touch.view == player {
            player.center.x = touch.location(in: self.view).x
            paddle.center.x = player.center.x
        }
    }
    //***********************
}
//***********************
