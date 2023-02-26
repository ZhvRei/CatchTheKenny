//  CatchTheKenny
//
//  Created by c7j on 22.02.2023.

import UIKit

class ViewController: UIViewController {
    
    //Variable
    var score = 0
    var timer = Timer()
    var counter = 30
    var arrayKenny = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //Views
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        //Highscore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        //Images
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let gestureRecognize1 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        let gestureRecognize2 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        let gestureRecognize3 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        let gestureRecognize4 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        let gestureRecognize5 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        let gestureRecognize6 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        let gestureRecognize7 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        let gestureRecognize8 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        let gestureRecognize9 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        
        kenny1.addGestureRecognizer(gestureRecognize1)
        kenny2.addGestureRecognizer(gestureRecognize2)
        kenny3.addGestureRecognizer(gestureRecognize3)
        kenny4.addGestureRecognizer(gestureRecognize4)
        kenny5.addGestureRecognizer(gestureRecognize5)
        kenny6.addGestureRecognizer(gestureRecognize6)
        kenny7.addGestureRecognizer(gestureRecognize7)
        kenny8.addGestureRecognizer(gestureRecognize8)
        kenny9.addGestureRecognizer(gestureRecognize9)
        
        arrayKenny = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        //Timers
        counter = 10
        timerLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
    }

    @objc func hideKenny() {
        
        for kenny in arrayKenny {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(arrayKenny.count - 1)))
        arrayKenny[random].isHidden = false
        
    }
    
    @objc func tapKenny() {
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    @objc func timerFunction() {
        
        hideKenny()
        
        counter -= 1
        timerLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()

            for kenny in arrayKenny {
                kenny.isHidden = true
            }
            
            //Highscore
            
            if self.score > self.highScore {
                self.highScore = self.score
                self.highscoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
                
            }
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            let repeatButon = UIAlertAction(title: "Repeat", style: UIAlertAction.Style.default) { [self] UIAlertAction in
                
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timerLabel.text = String(self.counter)
                
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
                hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(repeatButon)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}

