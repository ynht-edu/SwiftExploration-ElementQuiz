//
//  ViewController.swift
//  ElementQuiz
//
//  Created by Yayat Nurhidayat on 25/01/24.
//

import UIKit

enum Mode {
    case flashCard
    case quiz
}

class ViewController: UIViewController {

    @IBOutlet weak var elementImage: UIImageView!
    let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
    var currentElementIndex = 0
    var mode: Mode = .flashCard
    
    @IBOutlet weak var modeSelector: UISegmentedControl!
    
    @IBOutlet var textField: UIView!
    @IBOutlet weak var answerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateElement()
        // Do any additional setup after loading the view.
        
    }
    @IBAction func showAnswer(_ sender: UIButton) {
        answerLabel.text = elementList[currentElementIndex]
    }
    @IBAction func next(_ sender: UIButton) {
        currentElementIndex = (currentElementIndex+1) % elementList.count
        updateElement()
    }
    
    func updateElement() {
        let elementName = elementList[currentElementIndex]
        let image = UIImage(named: elementName)
        elementImage.image = image
        
        answerLabel.text = "?"
    }

}

