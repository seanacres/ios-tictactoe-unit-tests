//
//  GameTests.swift
//  TicTacToeTests
//
//  Created by Sean Acres on 8/14/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import XCTest
@testable import TicTacToe

class GameTests: XCTestCase {
    
    func testGameRestart() {
        var game = Game()
        game.restart()
        
        XCTAssertFalse(game.gameIsOver)
        XCTAssertEqual(game.activePlayer, .x)
        XCTAssertNil(game.winningPlayer)
        
        for x in 0..<3 {
            for y in 0..<3 {
                XCTAssertNil(game.board[(x, y)])
            }
        }
    }
    
    func testPlacingWinningMark() {
        var game = Game()
        /*
         x o -
         x o -
         x - -
         */
        try! game.makeMark(at: (0, 0))
        try! game.makeMark(at: (1, 0))
        try! game.makeMark(at: (0, 1))
        try! game.makeMark(at: (1, 1))
        try! game.makeMark(at: (0, 2))
        
        XCTAssertTrue(game.winningPlayer == .x)
        XCTAssertTrue(game.gameIsOver)
        XCTAssertNil(game.activePlayer)
    }
    
    func testPlacingTieMark() {
        var game = Game()
        
        /*
         x o x
         x o o
         o x x
         */
        try! game.makeMark(at: (0, 0))
        try! game.makeMark(at: (1, 0))
        try! game.makeMark(at: (2, 0))
        try! game.makeMark(at: (1, 1))
        try! game.makeMark(at: (0, 1))
        try! game.makeMark(at: (2, 1))
        try! game.makeMark(at: (1, 2))
        try! game.makeMark(at: (0, 2))
        try! game.makeMark(at: (2, 2))
        
        XCTAssertNil(game.winningPlayer)
        XCTAssertTrue(game.gameIsOver)
    }
    
    func testPlacingMarkIncompleteGame() {
        var game = Game()
        
        /*
         x o x
         x o o
         - - -
         */
        try! game.makeMark(at: (0, 0))
        try! game.makeMark(at: (1, 0))
        try! game.makeMark(at: (2, 0))
        try! game.makeMark(at: (1, 1))
        try! game.makeMark(at: (0, 1))
        try! game.makeMark(at: (2, 1))
        
        XCTAssertNil(game.winningPlayer)
        XCTAssertFalse(game.gameIsOver)
    }
    
    func testActivePlayerSwitchAfterMark() {
        var game = Game()
        
        try! game.makeMark(at: (0, 0))
        
        XCTAssertTrue(game.activePlayer == .o)
    }
    
    func testIllegalMove() {
        var game = Game()
        
        try! game.makeMark(at: (0, 0))
        
        XCTAssertThrowsError(try game.makeMark(at: (0, 0)))
    }

}
