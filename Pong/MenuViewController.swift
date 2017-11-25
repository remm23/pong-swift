//
//  MenuViewController.swift
//  Pong
//
//  Created by Remi Tobias on 25/11/2017.
//  Copyright © 2017 Remi Tobias. All rights reserved.
//

import UIKit

enum GameType {
    case easy
    case medium
    case hard
    case twoPlayer
}

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func twoPlayer(_ sender: Any) {
        moveToGame(game: .twoPlayer)
    }
    
    @IBAction func easy(_ sender: Any) {
        moveToGame(game: .easy)
    }
    
    @IBAction func Medium(_ sender: Any) {
        moveToGame(game: .medium)
    }
    
    @IBAction func Haed(_ sender: Any) {
        moveToGame(game: .hard)
    }
    
    func moveToGame(game: GameType) {
        let gameViewController = self.storyboard?.instantiateViewController(withIdentifier: "gameViewController") as! GameViewController
        currentGameType = game
        self.navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    
    
}
