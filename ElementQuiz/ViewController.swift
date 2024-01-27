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
    case score
}

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var elementImage: UIImageView!
    let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
    var currentElementIndex = 0
    var mode: Mode = .flashCard {
        didSet {
            switch mode {
            case .flashCard:
                setupFlashCards()
            case .quiz:
                setupQuiz()
            }
            
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
        currentElementIndex += 1
        if currentElementIndex >= elementList.count {
            currentElementIndex = 0
            if mode == .quiz {
                state = .score
                updateUI()
                return
            }
        }
        
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
        modeSelector.selectedSegmentIndex = 0
        
        switch state {
        case .question:
            answerLabel.text = "?"
        case .answer:
            answerLabel.text = elementList[currentElementIndex]
        case .score:
            answerLabel.text = ""
        }
            
    }
    
    func updateQuizUI(elementName: String) {
        
        textField.isHidden = false
        modeSelector.selectedSegmentIndex = 1
        
        switch state {
        case .question:
            textField.text = ""
            textField.becomeFirstResponder()
        case .answer:
            textField.resignFirstResponder()
        case .score:
            textField.isHidden = true
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
        case .score:
            answerLabel.text = ""
        }
        
        if state == .score {
            displayScoreAlert()
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
    
    func setupFlashCards() {
        state = .question
        currentElementIndex = 0
    }
    
    func setupQuiz() {
        state = .question
        currentElementIndex = 0
        isAnswerCorrect = false
        correctAnswerCount = 0
    }
    
    func displayScoreAlert() {
        let alert = UIAlertController(title: "Quiz Score", message: "Your score is \(correctAnswerCount) out of \(elementList.count).", preferredStyle: .alert)
        
        let dismissAlert = UIAlertAction(title: "Ok", style: .default, handler: scoreAlertDismissed(_:))
        alert.addAction(dismissAlert)
        
        present(alert, animated: true, completion: nil)
    }
    
    func scoreAlertDismissed(_ action: UIAlertAction) {
        mode = .flashCard
    }

}

