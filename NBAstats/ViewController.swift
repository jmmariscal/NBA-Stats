//
//  ViewController.swift
//  NBAstats
//
//  Created by Juan M Mariscal on 10/11/21.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var questionLabel: UILabel!
    
    var dataFiltered: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSearchFor(questionType: .champByYear)
    }
    
    private var inputQuestionType = QuestionType.firstYear {
        didSet {
            updateSearchFor(questionType: inputQuestionType)
        }
        
    }
    
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let yearToSearch = Int((searchTextField.text!.trimmingCharacters(in: .whitespaces)))!
            answerLabel.text = ModelController.shared.checkChampion(year: yearToSearch)
        case 1:
            let team = searchTextField.text!.trimmingCharacters(in: .whitespaces)
            answerLabel.text = String(ModelController.shared.firstYearWon(team: team))
        case 2:
            let team = searchTextField.text!.trimmingCharacters(in: .whitespaces)
            let yearText = ModelController.shared.checkYearsForChampion(team: team)
            answerLabel.text = yearText.map({String($0)}).joined(separator: ", ")
        default:
            break
        }
    }
    
    @IBAction func segmentedIndexTapped(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            inputQuestionType = .champByYear
        case 1:
            inputQuestionType = .firstYear
        case 2:
            inputQuestionType = .allYears
        default:
            break
        }
    }
    
    func keyboardTypeAndLabelText() {
        
    }
    
    
    enum QuestionType {
        case firstYear, champByYear, allYears
    }
    
    func updateSearchFor(questionType: QuestionType) {
        func updateKeyboarType(to keyboardType: UIKeyboardType, andQuestionText questionText: String) {
            searchTextField.text = ""
            searchTextField.resignFirstResponder()
            searchTextField.keyboardType = keyboardType
            searchTextField.becomeFirstResponder()
            questionLabel.text = questionText
        }
        
        switch questionType {
        case .firstYear:
            updateKeyboarType(to: .default, andQuestionText: "Check the first year a team won a championship")
        case .champByYear:
            updateKeyboarType(to: .numberPad, andQuestionText: "Check for Champion by year: ")
        case .allYears:
            updateKeyboarType(to: .default, andQuestionText: "Find all the years a team won a championship")
        }
    }
}

