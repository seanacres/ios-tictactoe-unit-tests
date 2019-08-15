//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Andrew R Madsen on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, BoardViewControllerDelegate {
    
    @IBAction func restartGame(_ sender: Any) {
        game.restart()
    }
    
    // MARK: - BoardViewControllerDelegate
    
    func boardViewController(_ boardViewController: BoardViewController, markWasMadeAt coordinate: Coordinate) {
        guard game.activePlayer != nil else {
            NSLog("Game is over")
            return
        }
        
        do {
           try game.makeMark(at: coordinate)
        } catch  {
           NSLog("Illegal move")
        }
    }
    
    // MARK: - Private
    
    private func updateViews() {
        guard isViewLoaded else { return }
        
        if let player = game.activePlayer {
            statusLabel.text = "Player \(player.stringValue)'s turn"
        } else if let winningPlayer = game.winningPlayer {
            statusLabel.text = "Player \(winningPlayer.stringValue) won!"
        } else {
            statusLabel.text = "Cat's game!"
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedBoard" {
            boardViewController = segue.destination as? BoardViewController
        }
    }
    
    private var boardViewController: BoardViewController! {
        willSet {
            boardViewController?.delegate = nil
        }
        didSet {
            boardViewController?.board = game.board
            boardViewController?.delegate = self
        }
    }
    
    @IBOutlet weak var statusLabel: UILabel!
    
    var game = Game() {
        didSet {
            updateViews()
            boardViewController.board = game.board
        }
    }
}
