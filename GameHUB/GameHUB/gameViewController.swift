import UIKit

class gameViewController: UIViewController {
  
    
    @IBOutlet weak var roundsLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var leftImageStack: UIStackView!
    @IBOutlet weak var rightImageStack: UIStackView!
    
    @IBOutlet weak var singleImageView: UIImageView!
    @IBOutlet var leftImageViews: [UIImageView]!
    @IBOutlet var rightImageViews: [UIImageView]!
    
    
    var diceGameManager = DiceGameManager()
//    cria uma lista com cada jogador de acordo com o numero de jogadores previamente definido
    var playerList: [Int] = []
//    armazena o index do atual jogador em jogo
    var currentPlayerIndex: Int = 0
    var totalRounds: Int = 0
    var playerScore: [Int:Int] = [:]

    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    
        
        hideImageStacks()
        showRoundsToPlay(roundNumber: diceGameManager.roundsToPlay)
        createPlayerList()
        showPlayerToPlay(playerNumber: playerList[0])
        setDicesToAppear()
        
    }
    
   
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard let scoreViewControler = segue.destination as? ScoreViewController else {return}
         scoreViewControler.gameManager = diceGameManager
     }
     
    
    //    metodo controla o numero de ImageViews que aparecem baseado no numero de dados a serem jogados
    func updateDiceImageView(this imageView: UIImageView) -> Int{
        let throwResult = self.diceGameManager.diceSelector()
        imageView.image = UIImage(named: "dado" + String(throwResult))
        
//        Retorna o resultado do lançamento do dado para popular os parâmetros do jogo,
//        numero de dados e rounds a serem jogados
        return throwResult
    }
    
    func selectImageViewToUpdate() -> Int {
        var playerResults: [Int] = []
        let diceViews: Set = [
                              rightImageViews[0],
                              rightImageViews[1],
                              rightImageViews[2],
                              leftImageViews[0],
                              leftImageViews[1],
                              leftImageViews[2]]
        //Controla o aparecimento das views de acordo com o numero de dados a ser jogados
        if !singleImageView.isHidden{
            playerResults.append(updateDiceImageView(this: singleImageView))
        } else {
            for view in diceViews{
                if !view.isHidden{
                    // a função updateDiceImageView retorna o valor do lançamento de dados e é utilizado para popular a array de playerResult
                    playerResults.append(updateDiceImageView(this: view))
                }
            }
        }
        return playerResults.reduce(0,+)
        
        
    }
   
    
    func setDicesToAppear(){
        switch diceGameManager.dicesToPlay {
        case 1:
            leftImageStack.isHidden = true
            rightImageStack.isHidden = true
            singleImageView.isHidden = false
        case 2:
            leftImageStack.isHidden = true
            leftImageViews[0].isHidden = true
            leftImageViews[1].isHidden = true
            leftImageViews[2].isHidden = true
            rightImageViews[1].isHidden = true
            
        case 3:
            rightImageStack.isHidden = true
            rightImageViews[0].isHidden = true
            rightImageViews[1].isHidden = true
            rightImageViews[2].isHidden = true
            
       
        case 4:
            rightImageViews[1].isHidden = true
            leftImageViews[1].isHidden = true
        case 5:
            rightImageViews[2].isHidden = true
        case 6:
            leftImageStack.isHidden = false
            rightImageStack.isHidden = false
            
        default:
            return
        }
    }
    
    //    Verifica o estado das imageStackViews, se estiverem hidden, torna-as visiveis
    func checkStackViewHiddenState(){
        if leftImageStack.isHidden, rightImageStack.isHidden{
            leftImageStack.isHidden = false
            rightImageStack.isHidden = false
        }
    }
    
    //    oculta as imagestacks
    func hideImageStacks(){
        leftImageStack.isHidden = true
        rightImageStack.isHidden = true
    }
    //    mostra a rounds label com o numero de rodadas a serem jogadas
    func showRoundsToPlay(roundNumber: Int = 0){
        roundsLabel.text = "Rounds: \(roundNumber)"
    }
    
    //    mostra a player label com o jogador a jogar no momento
    func showPlayerToPlay(playerNumber: Int = 0){
        
        playerLabel.text = "Jogador: \(playerNumber)"
    }
    //    cria uma lista com os jogadores a jogar
    func createPlayerList(){
        for number in 1...diceGameManager.playerNumber{
            playerList.append(number)
            print(playerList)
        }
    }
    
    
    
    func updateGameLabels() {
//        usa o index do atual jogador em jogo para mostrar na tela o seu respectivo numero
        let currentPlayer = playerList[currentPlayerIndex]
        showPlayerToPlay(playerNumber: currentPlayer)
        showRoundsToPlay(roundNumber: diceGameManager.roundsToPlay)
    }
    

    
    func updateRoundsToPlayLabel(rounds: Int){
        var showRound = rounds
        if showRound > 0 {
            showRound -= 1
            showRoundsToPlay(roundNumber: rounds)
            
        }
        
    }
    
    
    @IBAction func throwDiceButton(_ sender: UIButton) {

        var control = 0
       // UI functionality
        checkStackViewHiddenState()
        setDicesToAppear()
        
        // Enquanto houver rounds a serem jogados, executa jogadas, atualizando a UI com os respectivos valores
        if diceGameManager.roundsToPlay > 0 {
            diceGameManager.roundsToPlay -= 1
            showRoundsToPlay(roundNumber: diceGameManager.roundsToPlay)
            diceGameManager.playerScores[currentPlayerIndex] =  selectImageViewToUpdate() + (diceGameManager.playerScores[currentPlayerIndex] ?? 0)
            
            
        }
        // quando não há rounds a serem jogados, verifica se há mais jogadores por jogar, se houve muda o jogador e permite jogar os rounds necessários
        if diceGameManager.roundsToPlay == 0 {
            if currentPlayerIndex < playerList.count - 1{
                print(playerList.count)
                print(currentPlayerIndex)
                currentPlayerIndex += 1
                showPlayerToPlay(playerNumber: playerList[currentPlayerIndex])
                showRoundsToPlay(roundNumber: totalRounds)
                diceGameManager.roundsToPlay = totalRounds
            // se não mais jogadores por jogar e os rounds do ultimo jogador tiverem chegado a 0, muda o valor do controle para permitir
            // a execução do performSegue e troca de tela
            } else if currentPlayerIndex == playerList.count - 1, diceGameManager.roundsToPlay == 0 {
                control = 1
                showRoundsToPlay(roundNumber: 0)
            }
            
            if control == 1 {
                performSegue(withIdentifier: "highScoreSegue", sender: nil)
            }
        }
        
                
        
        
    }
}
