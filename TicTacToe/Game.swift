//
//  Game.swift
//  TicTacToe
//
//  Created by Sean Acres on 8/14/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Game {
    init() {
        self.board = GameBoard()
        self.activePlayer = .x
        self.winningPlayer = nil
        self.gameIsOver = false
    }
    
    mutating internal func restart() {
        activePlayer = .x
        winningPlayer = nil
        board = GameBoard()
        gameIsOver = false
    }
    
    mutating internal func makeMark(at coordinate: Coordinate) throws {
        guard let player = activePlayer else {
            gameIsOver = true
            NSLog("Game is over")
            return
        }
        
        do {
            try board.place(mark: player, on: coordinate)
            if game(board: board, isWonBy: player) {
                gameIsOver = true
                winningPlayer = player
                activePlayer = nil
            } else if board.isFull {
                gameIsOver = true
                activePlayer = nil
                //                gameState = .cat
            } else {
                let newPlayer = player == .x ? GameBoard.Mark.o : GameBoard.Mark.x
                activePlayer = newPlayer
            }
        } catch {
            NSLog("Illegal move")
        }
    }
    
    private(set) var board: GameBoard
    
    internal var activePlayer: GameBoard.Mark?
    internal var gameIsOver: Bool
    internal var winningPlayer: GameBoard.Mark?
}
