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

enum State {
    case question
    case answer
}

class ViewController: UIViewController {

    @IBOutlet weak var elementImage: UIImageView!
    let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
    var currentElementIndex = 0
    var mode: Mode = .flashCard
    var state: State = .question
    
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet var textField: UIView!
    @IBOutlet weak var answerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFlashCardUI()
        // Do any additional setup after loading the view.
        
    }
    @IBAction func showAnswer(_ sender: UIButton) {
        state = .answer
        updateFlashCardUI()
    }
    @IBAction func next(_ sender: UIButton) {
        currentElementIndex = (currentElementIndex+1) % elementList.count
        
        state = .question
        updateFlashCardUI()
    }
    
    func updateFlashCardUI() {
        let elementName = elementList[currentElementIndex]
        let image = UIImage(named: elementName)
        elementImage.image = image
        
        switch state {
        case .question:
            answerLabel.text = "?"
        case .answer:
            answerLabel.text = elementList[currentElementIndex]
        }
            
    }

}

