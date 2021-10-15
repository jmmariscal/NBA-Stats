//
//  ViewController.swift
//  NBAstats
//
//  Created by Juan M Mariscal on 10/11/21.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var questionLabel: UILabel!
    
    var dataFiltered: [String] = []
    
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let yearToSearch = Int(searchBar.text!)!
            answerLabel.text = ModelController.shared.checkChampion(year: yearToSearch)
        case 1:
            let team = searchBar.text!
            answerLabel.text = String(ModelController.shared.firstYearWon(team: team))
        case 2:
            let team = searchBar.text!
            let yearText = ModelController.shared.checkYearsForChampion(team: team)
            answerLabel.text = yearText.map({String($0)}).joined(separator: ", ")
        default:
            break
        }
    }
    
    @IBAction func segmentedIndexTapped(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            questionLabel.text = "Check for Champion by year: "
        case 1:
            questionLabel.text = "Check the first year a team was a Champion: "
        case 2:
            questionLabel.text = "Check all years a team won a Championship: "
        default:
            break
        }
        
    }
    
    
}

