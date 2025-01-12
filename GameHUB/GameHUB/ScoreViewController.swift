//
//  ScoreViewController.swift
//  GameHUB
//
//  Created by Aluno ISTEC on 23/07/2024.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet var scoreLabels: [UILabel]!
    
    
var gameManager = DiceGameManager()
    private let scoreRanking: [Int] = []

    var finalScore: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(gameManager.playerNumber)

      showRankingLabels()
        populateRanking()
        
    }
    
    func populateRanking(){
        var labelIndex: Int = 0
        var currentPlayerIndex: Int = 1
         
        for playerScore in gameManager.playerScores {
            scoreLabels[labelIndex].text = "Jogador \(currentPlayerIndex): \(playerScore.value)"
            labelIndex += 1
            currentPlayerIndex += 1
        }
    }
    
    func showRankingLabels(){
        switch gameManager.playerNumber{
        case 2:
            scoreLabels[0].isHidden = false
            scoreLabels[1].isHidden = false
            scoreLabels[2].isHidden = true
            scoreLabels[3].isHidden = true
            scoreLabels[4].isHidden = true
            scoreLabels[5].isHidden = true
        case 3:
            scoreLabels[0].isHidden = false
            scoreLabels[1].isHidden = false
            scoreLabels[2].isHidden = false
            scoreLabels[3].isHidden = true
            scoreLabels[4].isHidden = true
            scoreLabels[5].isHidden = true
        case 4:
            scoreLabels[0].isHidden = false
            scoreLabels[1].isHidden = false
            scoreLabels[2].isHidden = false
            scoreLabels[3].isHidden = false
            scoreLabels[4].isHidden = true
            scoreLabels[5].isHidden = true
        case 5:
            scoreLabels[0].isHidden = false
            scoreLabels[1].isHidden = false
            scoreLabels[2].isHidden = false
            scoreLabels[3].isHidden = false
            scoreLabels[4].isHidden = false
            scoreLabels[5].isHidden = true
        case 6:
            scoreLabels[0].isHidden = false
            scoreLabels[1].isHidden = false
            scoreLabels[2].isHidden = false
            scoreLabels[3].isHidden = false
            scoreLabels[4].isHidden = false
            scoreLabels[5].isHidden = false
        default:
            return
        }
    }
    

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let settingsVC = segue.destination as? settingsViewController else {return}
        
        gameManager.resetGame()
        settingsVC.diceGameManager = gameManager
        
        
    }
    

}
