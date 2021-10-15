//
//  ModelController.swift
//  NBAstats
//
//  Created by Juan M Mariscal on 10/11/21.
//

import Foundation
import UIKit


final class ModelController {
    static let shared = ModelController()
    private var championships: [Championship] = []
    
    func start() {
        let data = NSDataAsset(name: "Data")!.data
        let newText = String(data: data, encoding: .utf8)!.trimmingCharacters(in: .whitespacesAndNewlines)
        let nbaLines = newText.components(separatedBy: "\n")
        
        
        for line in nbaLines {
            let splitLine = line.split(separator: ",")
            let year = Int(splitLine[0])!
            let team = String(splitLine[1])
            let runnerUp = String(splitLine[2])
            let seriesSummary = String(splitLine[3])
            let mvp: String?
            
            if splitLine.count == 5, !splitLine[4].isEmpty {
                mvp = String(splitLine[4].trimmingCharacters(in: .whitespacesAndNewlines))
            } else {
                mvp = nil
            }
            
            let championship = Championship(year: year, winner: team, runnerUp: runnerUp, seriesSummary: seriesSummary, mvp: mvp)
            championships.append(championship)
        }
    }
    
    func checkChampion(year: Int) -> String {
        return championships.first(where: { $0.year == year })?.winner ?? "No Champion for that year"
    }

    func checkYearsForChampion(team: String) -> [Int] {
        
        return championships.filter({ $0.winner == team })
                            .map({ $0.year })
    }

    func firstYearWon(team: String) -> Int {
        return championships.last(where: { $0.winner == team })?.year ?? 0
    }

    // Print out list of teams played in a Final but have never won a championship
    func teamsPlayedFinalNeverWon() -> [String] {
        //loop through championships, compare runnerup to the winner of every year
        var noChampionshipTeams: [String] = []
        for line in championships {
            noChampionshipTeams.append(line.runnerUp)
        }
        for line in championships {
            for team in noChampionshipTeams{
                if team == line.winner {
                    let indexOfTeam = noChampionshipTeams.firstIndex(of: team)
                    noChampionshipTeams.remove(at: indexOfTeam!)
                }
            }
        }
        let results = Array(Set(noChampionshipTeams))
        return results
    }

    // Print out ranking of who has won MVP more than once, by times won
    // 6 times: Michael Jordan
    // 3 times: Shaquille O'Neal, LeBron James
    // 2 times: etc...
    func mvpRanking() {
        // Fill dictionary with mvp's as Key and as a Value the number of times won
        
        var mvps: [String:Int] = [:]
        
        for line in championships {
            if let teamMvp = line.mvp {
                mvps[teamMvp, default: 0] += 1
            }
        }
        
        var mvpDic: [Int:[String]] = [:]
        //mvps.filter({!$0.key.isEmpty}).forEach({mvps[$0.key] = nil})
        for (key, value) in mvps {
            mvpDic[value, default: [] ].append(key)
        }
        
        for (key, value) in mvpDic.sorted(by: { $0.key > $1.key }){
            let string = value.joined(separator: ", ")
            if string.isEmpty {
                continue
            }
            print("\(key) times: \(string)")
        }
        
    }
}


struct Championship {
    let year: Int
    let winner: String
    let runnerUp: String
    let seriesSummary: String
    var mvp: String?
}



