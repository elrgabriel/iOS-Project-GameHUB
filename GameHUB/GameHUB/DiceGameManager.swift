import Foundation

struct DiceGameManager {
    
    private var _playerNumber: Int = 2
    private var _dicesToPlay: Int?
    private var _roundsToPlay: Int?
    var playerScores: [Int:Int] = [:]
    
    
//    variaveis Get e Set para lidar com as variaveis privates, lidando tambem com os unwraps dos optionals
    var playerNumber: Int {
        get {
            return _playerNumber
        }
        set (newValue){
            self._playerNumber = newValue
        }
    }
    
    var dicesToPlay: Int {
        get {
            let tryUnrwap = self._dicesToPlay
            guard  let tryUnrwap else {return 0}
            return tryUnrwap
        }
        set (newValue) {
            self._dicesToPlay = newValue
        }
    }
    var roundsToPlay: Int {
        get {
            let tryUnrwap = self._roundsToPlay
            guard  let tryUnrwap else {return 0}
            return tryUnrwap
        }
        set (newValue) {
            self._roundsToPlay = newValue
        }
    }
    
   
   
    //    metodo para selecionar configurações por lançamento de dado
        func diceSelector() -> Int{
    //        cria objeto a partir da struct DiceGame para acesso ao método throwDice
            let dice = DiceGame()
            return dice.throwDice()
        }
    mutating func updateRoundsToPlay(rounds: Int){
        roundsToPlay = rounds
    }
    
    mutating func resetGame(){
        self.playerNumber = 2
        self._dicesToPlay = nil
        self._roundsToPlay = nil
        
    }
    
}
