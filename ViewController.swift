//
//  ViewController.swift
//  Concentration
//
//  Created by Youssef Ali on 7/1/19.
//  Copyright © 2019 Youssef Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var numberOfPairs: Int = 0
    private var game = Concentration(numberOfPairs: 1)
    
    var emoji: [Card:String] = [:]
    
    private(set) var flipCount: Int = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private var emojiChoices = ""
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var newGameButton: UIButton!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.index(of: sender) {
            flipCount += 1
            if let matchingPairIndices = game.chooseCard(at: cardIndex) {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
                    self.hideCardAndDisableButtons(at: matchingPairIndices)
                })
            }
            updateViewFromModel()
        }
    }
    
    @IBAction private func newGame(_ sender: Any) {
        newGameButton.isHidden = true
        initAttributes()
        initButtons()
    }
    
    override func viewDidLoad(){
        print("Function: \(#function)")
        super.viewDidLoad()
        updateFlipCountLabel()
        initAttributes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Function: \(#function)")
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Function: \(#function)")
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Function: \(#function)")
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Function: \(#function)")
        super.viewWillDisappear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        print("Function: \(#function)")
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        print("Function: \(#function)")
        super.viewDidLayoutSubviews()
    }
    
    func initButtons() {
        for button in cardButtons {
            button.isEnabled = true
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
    }
    
    func initAttributes() {
        numberOfPairs = (cardButtons.count + 1) / 2
        game = Concentration(numberOfPairs: numberOfPairs)
        emoji = [Card:String]()
        flipCount = 0
        emojiChoices = "😎😍👻🍔🐵🍗🚗⚽️🧩🔑"
    }
    
    func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)",attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    func hideCardAndDisableButtons(at indices: [Int]) {
        for index in indices {
            hideCardAndDisableButton(cardButtons[index])
        }
    }
    
    func hideCardAndDisableButton(_ button: UIButton) {
        button.isEnabled = false
        button.setTitle("", for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
    }
    
    func updateViewFromModel() {
        var numberOfMatchedCards = 0
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
                if card.isFaceUp {
                    button.setTitle(self.emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
                else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                }
            
            if card.isMatched {
                numberOfMatchedCards += 1
            }
        }
        
        if isGameEnded(numberOfMatchedCards){
            offerNewGame()
        }
        
    }
    
    func isGameEnded(_ numberOfMatchedCards: Int) -> Bool {
        return numberOfMatchedCards / 2 == numberOfPairs
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil && emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    func offerNewGame() {
        newGameButton.isHidden = false
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
    }
}
