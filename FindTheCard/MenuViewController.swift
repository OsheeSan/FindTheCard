//
//  MenuViewController.swift
//  FindTheCard
//
//  Created by admin on 22.08.2023.
//

import UIKit

class MenuViewController: UIViewController {
    
    let padding:CGFloat = 20
    
    var game1Button: UIButton!
    var game3Button: UIButton!
    var instruction: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    func setupButtons(){
        game1Button = UIButton(type: .custom)
        game1Button.translatesAutoresizingMaskIntoConstraints = false
        game1Button.setTitle("Single Card Game", for: .normal)
        game1Button.clipsToBounds = true
        game1Button.layer.cornerRadius = 20
        game1Button.backgroundColor = .orange
        game1Button.addTarget(self, action: #selector(game1), for: .touchUpInside)
        view.addSubview(game1Button)
        game3Button = UIButton(type: .custom)
        game3Button.translatesAutoresizingMaskIntoConstraints = false
        game3Button.setTitle("Three Cards Game", for: .normal)
        game3Button.clipsToBounds = true
        game3Button.layer.cornerRadius = 20
        game3Button.backgroundColor = .orange
        game3Button.addTarget(self, action: #selector(game3), for: .touchUpInside)
        view.addSubview(game3Button)
        instruction = UIButton(type: .custom)
        instruction.translatesAutoresizingMaskIntoConstraints = false
        instruction.setTitle("Instruction", for: .normal)
        instruction.clipsToBounds = true
        instruction.layer.cornerRadius = 20
        instruction.backgroundColor = .orange
//        instruction.addTarget(self, action: #selector(game3), for: .touchUpInside)
        view.addSubview(instruction)
        
        NSLayoutConstraint.activate([
            game1Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            game1Button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: padding),
            game1Button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            game3Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            game3Button.topAnchor.constraint(equalTo: game1Button.bottomAnchor, constant: padding),
            game3Button.widthAnchor.constraint(equalTo: game1Button.widthAnchor),
            instruction.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instruction.topAnchor.constraint(equalTo: game3Button.bottomAnchor, constant: padding),
            instruction.widthAnchor.constraint(equalTo: game1Button.widthAnchor),
        ])
    }
    
    @objc func game1() {
        Vibration.light.vibrate()
        self.performSegue(withIdentifier: "game1", sender: game1Button)
    }
    
    @objc func game3() {
        Vibration.light.vibrate()
        self.performSegue(withIdentifier: "game3", sender: game3Button)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "game1":
            GameManager.shared.cardsToOpen = 1
        case "game3":
            GameManager.shared.cardsToOpen = 3
        default:
            break
        }
    }
    
}
