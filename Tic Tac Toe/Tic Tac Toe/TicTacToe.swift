//
//  Game.swift
//  Tic Tac Toe
//
//  Created by Guy Azran on 11/12/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import Foundation

class TicTacToe {
    
    private var board:[AreaValue];
    private var _isXTurn:Bool;
    private var moveCount:Int;
    private var gameCount:Int;
    
    private var _playable:Bool;
    
    
    var isXTurn:Bool{
        get{
            return _isXTurn;
        }
    }
    
    var playable:Bool{
        get{
            return _playable
        } set{
            _playable = newValue;
        }
    }
    
    init(){
        board = [AreaValue]()
        _isXTurn = true;
        moveCount = 0;
        gameCount = 0;
        _playable = true;
        
        newGame();
    }
    
    
    func makeMove(area: Int) -> MoveResult{
        if area > 8 || area < 0 || !_playable{
            return .INVALID_MOVE;
        }
        
        if board[area] != .EMPTY{
            return .INVALID_MOVE;
        }
        
        moveCount++;
        _isXTurn = !_isXTurn
        
        board[area] = !_isXTurn ? .X : .O;
        
        if moveCount >= 5 && checkForVictory(area){
            return .VICTORY;
        } else if moveCount == 9{
            return .DRAW;
        }
        
        
        
        
        
        return .VALID_MOVE;
    }
    
    func checkForVictory(area: Int) -> Bool{
        
        var row = area / 3;
        let column = area % 3;
        if(board[column] == board[column+3] && board[column] == board[column+6]){
            return true;
        }
        row *= 3;
        if(board[row] == board[row+1] && board[row] == board[row+2]){
            return true;
        }
        
        let diagonal1 = board[0] != .EMPTY && board[0] == board[4] && board[0] == board[8];
        let diagonal2 = board[2] != .EMPTY && board[2] == board[4] && board[2] == board[6];
        
        return diagonal1 || diagonal2;
    }
    
    func newGame(){
        if gameCount == 0{
            for _ in 0..<9{
                board.append(.EMPTY);
            }
        } else{
            for i in 0..<board.count{
                board[i] = .EMPTY;
            }
        }
        
        moveCount = 0;
        gameCount++;
        
        switch(gameCount % 2){
        case 0:
            _isXTurn = false;
        case 2:
            _isXTurn = true;
        default:
            _isXTurn = true;
        }
        
        _playable = true;
    }
    
    enum AreaValue{
        case EMPTY;
        case X;
        case O;
    }
    
    enum MoveResult{
        case VALID_MOVE;
        case INVALID_MOVE;
        case VICTORY;
        case DRAW;
    }
    
    
}