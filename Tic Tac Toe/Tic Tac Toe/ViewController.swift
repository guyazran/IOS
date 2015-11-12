//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Guy Azran on 11/12/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let STATUS_BAR_HEIGHT:CGFloat = 20;
    let NUMBER_OF_AREAS_ON_THE_BOARD = 9;
    
    var boardImg:UIImageView!;
    var areas = [UIImageView]();
    var lblPlayerTurn:UILabel!;
    var btnResetGame:UIButton!;
    
    var game = TicTacToe();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBoardImg();
        initializeAreas();
        createPlayerTurnLabel();
        createResetButton();
        
    }
    
    func handleAreaTapped(sender: UITapGestureRecognizer){
        let area = sender.view as! UIImageView;
        let moveResult = game.makeMove(area.tag);
        if moveResult == .INVALID_MOVE{
            print("invalid move");
        } else{
            area.image = UIImage(named: !game.isXTurn ? "x" : "o");
        }
        
        if moveResult == .VICTORY{
            drawAndVictoryAlert("Victory!", winner: !game.isXTurn ? "Player 1 wins" : "Player 2 wins");
            game.playable = false;
        } else if moveResult == .DRAW{
            drawAndVictoryAlert("DRAW!", winner: nil);
            game.playable = false;
        }
        
        setPlayerTurnLabelText();
    }
    
    func drawAndVictoryAlert(title: String, winner: String?){
        
        let alertController = UIAlertController(title: title, message: winner, preferredStyle: .Alert);
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil));
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func resetGame(){
        game.newGame();
        for area in areas{
            area.image = nil;
        }
    }
    
    func createResetButton(){
        btnResetGame = UIButton(type: .System);
        btnResetGame.frame = CGRect(x: 0, y: 0, width: 50, height: 20);
        btnResetGame.setTitle("Reset", forState: .Normal);
        btnResetGame.addTarget(self, action: "resetGame", forControlEvents: .TouchUpInside);
        view.addSubview(btnResetGame);
    }
    
    func createPlayerTurnLabel(){
        lblPlayerTurn = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 20));
        lblPlayerTurn.center.x = view.center.x;
        lblPlayerTurn.textAlignment = .Center;
        setPlayerTurnLabelText();
        view.addSubview(lblPlayerTurn);
    }
    
    func setPlayerTurnLabelText(){
        lblPlayerTurn.text = game.isXTurn ? "Player 1's turn" : "Player 2's turn";
    }
    
    func createBoardImg(){
        boardImg = UIImageView(image: UIImage(named: "tic_tac_toe_board"));
        boardImg.frame = CGRect(x: 0, y: STATUS_BAR_HEIGHT, width: view.frame.width, height: view.frame.height - STATUS_BAR_HEIGHT);
        view.addSubview(boardImg);
    }
    
    func initializeAreas(){
        var x:CGFloat!;
        var y:CGFloat!;
        let width = view.frame.width / 3;
        let height = view.frame.height / 3;
        
        for i in 0..<NUMBER_OF_AREAS_ON_THE_BOARD{
            
            //determine x coordinate
            switch (i % 3){
            case 0:
                x = boardImg.frame.origin.x;
            case 1:
                x = boardImg.center.x - width / 2;
            case 2:
                x = boardImg.frame.maxX - width;
            default:
                x = 0;
            }
            
            //determine y coordinate
            switch(i){
            case 0..<3:
                y = boardImg.frame.origin.y;
            case 3..<6:
                y = boardImg.center.y - height / 2;
            case 6..<9:
                y = boardImg.frame.maxY - height;
            default:
                y = 0;
            }
            
            //create the ImageView
            areas.append(UIImageView(frame: CGRect(x: x, y: y, width: width, height: height)));
            
            //add tap recognizer
            areas[i].userInteractionEnabled = true;
            areas[i].addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleAreaTapped:"));
            
            //add tag for later use
            areas[i].tag = i;
            
            //add ImageView to main view
            view.addSubview(areas[i]);
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

