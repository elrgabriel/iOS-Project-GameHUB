import Foundation

struct DiceGame{
    
    func throwDice() -> Int{
        let throwResult = Int.random(in: 1...6)
        return throwResult
    }
    
    
    
}
