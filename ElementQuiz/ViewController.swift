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

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var elementImage: UIImageView!
    let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
    var currentElementIndex = 0
    var mode: Mode = .flashCard {
        didSet {
            updateUI()
        }
    }
    var state: State = .question
    
    // keyboard handling var
    var isAnswerCorrect = false
    var correctAnswerCount = 0
    
    @IBOutlet weak var modeSelector: UISegmentedControl!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
        
    }
    @IBAction func showAnswer(_ sender: UIButton) {
        state = .answer
        updateUI()
    }
    @IBAction func next(_ sender: UIButton) {
        currentElementIndex = (currentElementIndex+1) % elementList.count
        
        state = .question
        updateUI()
    }
    @IBAction func switchModes(_ sender: Any) {
        if modeSelector.selectedSegmentIndex == 0 {
            mode = .flashCard
        } else {
            mode = .quiz
        }
    }
    
    func updateFlashCardUI(elementName: String) {
        textField.isHidden = true
        textField.resignFirstResponder()
        
        switch state {
        case .question:
            answerLabel.text = "?"
        case .answer:
            answerLabel.text = elementList[currentElementIndex]
        }
            
    }
    
    func updateQuizUI(elementName: String) {
        
        textField.isHidden = false
        switch state {
        case .question:
            textField.text = ""
            textField.becomeFirstResponder()
        case .answer:
            textField.resignFirstResponder()
        }

        switch state {
        case .question:
            answerLabel.text = ""
        case .answer:
            if isAnswerCorrect {
                answerLabel.text = "Correct!"
            } else {
                answerLabel.text = "❌"
            }
        }
    }
    
    func updateUI() {
        
        let elementName = elementList[currentElementIndex]
        let image = UIImage(named: elementName)
        elementImage.image = image
        
        switch mode {
        case .flashCard:
            updateFlashCardUI(elementName: elementName)
        case .quiz:
            updateQuizUI(elementName: elementName)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textFieldContents = textField.text!
        
        if textFieldContents.lowercased() == elementList[currentElementIndex].lowercased() {
            isAnswerCorrect = true
            correctAnswerCount += 1
        } else {
            isAnswerCorrect = false
        }
        
        state = .answer
        
        updateUI()
        
        return true
    }

}

