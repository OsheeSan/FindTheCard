//
//  ViewController.swift
//  FindTheCard
//
//  Created by admin on 19.08.2023.
//

import UIKit
import FloatingPanel

class ViewController: UIViewController {
    
    var floatingMenuVC: FloatingMenuVC!
    
    var card1: Card!
    var card2: Card!
    var card3: Card!
    
    //CHOSEN CARD
    var logo: cardLogo?
    var number: cardNumber?
    var color: cardColor?
    
    var backgroundView: UIImageView!
    
    var viewToMove: UIView?
    var touchPoint: CGPoint!
    let padding:CGFloat = 20
    var startPointOfMovedView: CGPoint!
    
    var turnTable: UIView!
    var first: UIImageView!
    var second: UIImageView!
    var third: UIImageView!
    
    //Cards
    private var firstCard: UIImageView!
    private var secondCard: UIImageView!
    private var thirdCard: UIImageView!
    
    //Buttons
    private var playButton: UIButton!
    private var homeButton: UIButton!
    
    var skullIV: UIImageView!
    var birdIV: UIImageView!
    var heartIV: UIImageView!
    var oneIV: UIImageView!
    var twoIV: UIImageView!
    var threeIV: UIImageView!
    var blueIV: UIImageView!
    var pinkIV: UIImageView!
    var yellowIV: UIImageView!
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        
        GameManager.shared.newGame()
        setupBackground()
        setupButtons()
        setupCards()
        setupBoard()
        setupHomeButton()
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    //MARK: - setupBackground
    func setupBackground(){
        backgroundView = UIImageView(frame: view.frame)
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.image = UIImage(named: "background")
        view.addSubview(backgroundView)
    }
    
    //MARK: - objc showBetMenu
    @objc func showBetMenu() {
        if logo == nil && number == nil && color == nil {
            let alertController = UIAlertController(title: "Hey!", message: "Choose at least one sign.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            floatingMenuVC = FloatingMenuVC()
            floatingMenuVC.delegate = self
            self.present(floatingMenuVC, animated: true)
        }
    }
    
    //MARK: - setupHomeButton
    func setupHomeButton() {
        homeButton = UIButton(type: .custom)
        homeButton.imageView?.contentMode = .scaleAspectFit
        homeButton.setImage(UIImage(named: "gameLogoPin"), for: .normal)
        view.addSubview(homeButton)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            homeButton.rightAnchor.constraint(equalTo: turnTable.leftAnchor),
            homeButton.heightAnchor.constraint(equalTo: turnTable.heightAnchor),
            homeButton.centerYAnchor.constraint(equalTo: turnTable.centerYAnchor),
        ])
        homeButton.addTarget(self, action: #selector(mainMenu), for: .touchUpInside)
    }
    
    //MARK: - objc mainMenu
    @objc func mainMenu(){
        Vibration.light.vibrate()
        let alertController = UIAlertController(title: "You sure?", message: "All the progress will be deleted", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Main Menu", style: .destructive) { (_) in
            Vibration.error.vibrate()
            self.dismiss(animated: true)
        }
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: {
        })
    }
    
    //MARK: - setupButtons
    func setupButtons(){
        playButton = UIButton(type: .custom)
        playButton.setTitle("Make a Bet", for: .normal)
        playButton.backgroundColor = .orange
        view.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        playButton.addTarget(self, action: #selector(showBetMenu), for: .touchUpInside)
    }
    
    //MARK: - setupCards
    func setupCards(){
        firstCard = UIImageView()
        firstCard.contentMode = .scaleToFill
        firstCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstCard)
        secondCard = UIImageView()
        secondCard.contentMode = .scaleToFill
        secondCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(secondCard)
        thirdCard = UIImageView()
        thirdCard.contentMode = .scaleToFill
        thirdCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(thirdCard)
        let safeArea = view.safeAreaLayoutGuide
        firstCard.image = UIImage(named: "cardDown")
        secondCard.image = UIImage(named: "cardDown")
        thirdCard.image = UIImage(named: "cardDown")
        firstCard.isUserInteractionEnabled = true
        secondCard.isUserInteractionEnabled = true
        thirdCard.isUserInteractionEnabled = true
        
        if GameManager.shared.gameType == .oneCard {
            firstCard.isHidden = true
            thirdCard.isHidden = true
        }
        
        NSLayoutConstraint.activate([
            firstCard.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.2),
            firstCard.widthAnchor.constraint(equalTo: firstCard.heightAnchor, multiplier: 0.7),
            firstCard.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: -safeArea.layoutFrame.size.width/3),
            firstCard.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: firstCard.frame.height*1.5),
            secondCard.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.2),
            secondCard.widthAnchor.constraint(equalTo: firstCard.heightAnchor, multiplier: 0.7),
            secondCard.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            secondCard.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: firstCard.frame.height*1.5),
            thirdCard.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.2),
            thirdCard.widthAnchor.constraint(equalTo: firstCard.heightAnchor, multiplier: 0.7),
            thirdCard.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: safeArea.layoutFrame.size.width/3),
            thirdCard.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: firstCard.frame.height*1.5)
        ])}
    
    //MARK: - openCards
    func openCards(){
        switch GameManager.shared.gameType {
        case .oneCard:
            self.card2 = GameManager.shared.getRandomCard()
            let image = UIImage(named: self.card2.imageName())
            self.secondCard.image = image
            UIView.transition(with: self.secondCard, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: {_ in
                sleep(1)
                let res  = Bet.shared.checkWin(card1: self.card2)
                self.checkWinOrLose()
                if res < 0 {
                    let alertController = UIAlertController(title: "You lose \(abs(res)) coins", message: "Don't worry, try again!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        self.checkWinOrLose()
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: {
                    })
                    Vibration.error.vibrate()
                } else if res == 0 {
                    let alertController = UIAlertController(title: "You earn nothing", message: "Let's try again!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    Vibration.heavy.vibrate()
                } else if res > 0 {
                    let alertController = UIAlertController(title: "You earn \(res) coins!", message: "That's it, move on", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        self.checkWinOrLose()
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: {
                        
                    })
                    Vibration.success.vibrate()
                }
            })
            break
        case .threeCards:
            card1 = GameManager.shared.getRandomCard()
            let image = UIImage(named: card1.imageName())
            firstCard.image = image
            UIView.transition(with: firstCard, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: { _ in
                sleep(1)
                self.card2 = GameManager.shared.getRandomCard()
                let image = UIImage(named: self.card2.imageName())
                self.secondCard.image = image
                UIView.transition(with: self.secondCard, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: {_ in
                    sleep(1)
                    self.card3 = GameManager.shared.getRandomCard()
                    let image = UIImage(named: self.card3.imageName())
                    self.thirdCard.image = image
                    UIView.transition(with: self.thirdCard, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: { _ in
                        sleep(1)
                        let res  = Bet.shared.checkWin(card1: self.card1, card2: self.card2, card3: self.card3)
                        self.checkWinOrLose()
                        if res < 0 {
                            let alertController = UIAlertController(title: "You lose \(abs(res)) coins", message: "Don't worry, try again!", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                                self.checkWinOrLose()
                            }
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: {
                            })
                            Vibration.error.vibrate()
                        } else if res == 0 {
                            let alertController = UIAlertController(title: "You earn nothing", message: "Let's try again!", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                            }
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                            Vibration.heavy.vibrate()
                        } else if res > 0 {
                            let alertController = UIAlertController(title: "You earn \(res) coins!", message: "That's it, move on", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                                self.checkWinOrLose()
                            }
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: {
                                
                            })
                            Vibration.success.vibrate()
                        }
                    })
                })
            })
            
            break
        case .none:
            print("Error game type: Nil")
            break
        }
    }
    
    //MARK: - checkWinOrLose
    func checkWinOrLose() {
        print(GameManager.shared.points)
        if GameManager.shared.points <=  0 {
            let alertController = UIAlertController(title: "You lose", message: "Next time!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Main Menu", style: .default) { (_) in
                self.dismiss(animated: true)
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            Vibration.error.vibrate()
        } else if GameManager.shared.points >= 100 {
            let alertController = UIAlertController(title: "You win", message: "You reached 100 coins!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Main Menu", style: .default) { (_) in
                self.dismiss(animated: true)
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            Vibration.oldSchool.vibrate()
        }
    }
    
    //MARK: - objc removeButton1
    @objc func removeButton1() {
        switch logo {
        case .heart:
            heartIV.isHidden = false
        case.skull:
            skullIV.isHidden = false
        case .bird:
            birdIV.isHidden = false
        case .none:
            break
        }
        logo = nil
        first.image = nil
        Vibration.medium.vibrate()
    }
    
    //MARK: - objc removeButton2
    @objc func removeButton2() {
        switch number {
        case .one:
            oneIV.isHidden = false
        case.two:
            twoIV.isHidden = false
        case .three:
            threeIV.isHidden = false
        case .none:
            break
        }
        number = nil
        second.image = nil
        Vibration.medium.vibrate()
    }
    
    //MARK: - objc removeButton3
    @objc func removeButton3() {
        switch color {
        case .pink:
            pinkIV.isHidden = false
        case.yellow:
            yellowIV.isHidden = false
        case .blue:
            blueIV.isHidden = false
        case .none:
            break
        }
        color = nil
        third.image = nil
        Vibration.medium.vibrate()
    }
    
    //MARK: - setupBoard
    func setupBoard() {
        skullIV = UIImageView()
        skullIV.contentMode  = .scaleToFill
        skullIV.translatesAutoresizingMaskIntoConstraints = false
        skullIV.image = UIImage(named: "skull")
        skullIV.layer.zPosition = 2
        view.addSubview(skullIV)
        
        birdIV = UIImageView()
        birdIV.contentMode  = .scaleToFill
        birdIV.translatesAutoresizingMaskIntoConstraints = false
        birdIV.image = UIImage(named: "bird")
        birdIV.layer.zPosition = 2
        view.addSubview(birdIV)
        
        heartIV = UIImageView()
        heartIV.contentMode  = .scaleToFill
        heartIV.translatesAutoresizingMaskIntoConstraints = false
        heartIV.image = UIImage(named: "heart")
        heartIV.layer.zPosition = 2
        view.addSubview(heartIV)
        
        oneIV = UIImageView()
        oneIV.contentMode  = .scaleToFill
        oneIV.translatesAutoresizingMaskIntoConstraints = false
        oneIV.image = UIImage(named: "1")
        oneIV.layer.zPosition = 2
        view.addSubview(oneIV)
        
        twoIV = UIImageView()
        twoIV.contentMode  = .scaleToFill
        twoIV.translatesAutoresizingMaskIntoConstraints = false
        twoIV.image = UIImage(named: "2")
        twoIV.layer.zPosition = 2
        view.addSubview(twoIV)
        
        threeIV = UIImageView()
        threeIV.contentMode  = .scaleToFill
        threeIV.translatesAutoresizingMaskIntoConstraints = false
        threeIV.image = UIImage(named: "3")
        threeIV.layer.zPosition = 2
        view.addSubview(threeIV)
        
        blueIV = UIImageView()
        blueIV.contentMode  = .scaleToFill
        blueIV.translatesAutoresizingMaskIntoConstraints = false
        blueIV.image = UIImage(named: "blue")
        blueIV.layer.zPosition = 2
        view.addSubview(blueIV)
        
        pinkIV = UIImageView()
        pinkIV.contentMode  = .scaleToFill
        pinkIV.translatesAutoresizingMaskIntoConstraints = false
        pinkIV.image = UIImage(named: "pink")
        pinkIV.layer.zPosition = 2
        view.addSubview(pinkIV)
        
        yellowIV = UIImageView()
        yellowIV.contentMode  = .scaleToFill
        yellowIV.translatesAutoresizingMaskIntoConstraints = false
        yellowIV.image = UIImage(named: "yellow")
        yellowIV.layer.zPosition = 2
        view.addSubview(yellowIV)
        
        turnTable = UIView()
        turnTable.clipsToBounds = true
        turnTable.layer.cornerRadius = 20
        turnTable.backgroundColor = .brown
        turnTable.translatesAutoresizingMaskIntoConstraints = false
        turnTable.layer.zPosition = 0
        view.addSubview(turnTable)
        turnTable.isUserInteractionEnabled = true
        first = UIImageView()
        first.contentMode  = .scaleToFill
        first.translatesAutoresizingMaskIntoConstraints = false
        first.layer.zPosition = 2
        first.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeButton1)))
        turnTable.addSubview(first)
        
        second = UIImageView()
        second.contentMode  = .scaleToFill
        second.translatesAutoresizingMaskIntoConstraints = false
        second.layer.zPosition = 2
        second.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeButton2)))
        turnTable.addSubview(second)
        
        third = UIImageView()
        third.contentMode  = .scaleToFill
        third.translatesAutoresizingMaskIntoConstraints = false
        third.layer.zPosition = 2
        third.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeButton3)))
        turnTable.addSubview(third)
        first.isUserInteractionEnabled = true
        second.isUserInteractionEnabled = true
        third.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            skullIV.centerXAnchor.constraint(equalTo: firstCard.centerXAnchor),
            skullIV.topAnchor.constraint(equalTo: firstCard.bottomAnchor, constant: padding),
            skullIV.heightAnchor.constraint(equalTo: firstCard.widthAnchor, multiplier: 0.7),
            skullIV.widthAnchor.constraint(equalTo: skullIV.heightAnchor),
            birdIV.centerXAnchor.constraint(equalTo: secondCard.centerXAnchor),
            birdIV.topAnchor.constraint(equalTo: firstCard.bottomAnchor, constant: padding),
            birdIV.heightAnchor.constraint(equalTo: firstCard.widthAnchor, multiplier: 0.7),
            birdIV.widthAnchor.constraint(equalTo: birdIV.heightAnchor),
            heartIV.centerXAnchor.constraint(equalTo: thirdCard.centerXAnchor),
            heartIV.topAnchor.constraint(equalTo: firstCard.bottomAnchor, constant: padding),
            heartIV.heightAnchor.constraint(equalTo: firstCard.widthAnchor, multiplier: 0.7),
            heartIV.widthAnchor.constraint(equalTo: heartIV.heightAnchor),
            
            
            oneIV.centerXAnchor.constraint(equalTo: firstCard.centerXAnchor),
            oneIV.topAnchor.constraint(equalTo: skullIV.bottomAnchor, constant: padding),
            oneIV.heightAnchor.constraint(equalTo: firstCard.widthAnchor, multiplier: 0.7),
            oneIV.widthAnchor.constraint(equalTo: oneIV.heightAnchor),
            twoIV.centerXAnchor.constraint(equalTo: secondCard.centerXAnchor),
            twoIV.topAnchor.constraint(equalTo: skullIV.bottomAnchor, constant: padding),
            twoIV.heightAnchor.constraint(equalTo: firstCard.widthAnchor, multiplier: 0.7),
            twoIV.widthAnchor.constraint(equalTo: twoIV.heightAnchor),
            threeIV.centerXAnchor.constraint(equalTo: thirdCard.centerXAnchor),
            threeIV.topAnchor.constraint(equalTo: skullIV.bottomAnchor, constant: padding),
            threeIV.heightAnchor.constraint(equalTo: firstCard.widthAnchor, multiplier: 0.7),
            threeIV.widthAnchor.constraint(equalTo: threeIV.heightAnchor),
            
            pinkIV.centerXAnchor.constraint(equalTo: firstCard.centerXAnchor),
            pinkIV.topAnchor.constraint(equalTo: oneIV.bottomAnchor, constant: padding),
            pinkIV.heightAnchor.constraint(equalTo: firstCard.widthAnchor, multiplier: 0.7),
            pinkIV.widthAnchor.constraint(equalTo: pinkIV.heightAnchor),
            blueIV.centerXAnchor.constraint(equalTo: secondCard.centerXAnchor),
            blueIV.topAnchor.constraint(equalTo: oneIV.bottomAnchor, constant: padding),
            blueIV.heightAnchor.constraint(equalTo: firstCard.widthAnchor, multiplier: 0.7),
            blueIV.widthAnchor.constraint(equalTo: blueIV.heightAnchor),
            yellowIV.centerXAnchor.constraint(equalTo: thirdCard.centerXAnchor),
            yellowIV.topAnchor.constraint(equalTo: oneIV.bottomAnchor, constant: padding),
            yellowIV.heightAnchor.constraint(equalTo: firstCard.widthAnchor, multiplier: 0.7),
            yellowIV.widthAnchor.constraint(equalTo: yellowIV.heightAnchor),
            
            turnTable.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            turnTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            turnTable.heightAnchor.constraint(equalToConstant: 70),
            turnTable.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -padding),
            
            first.heightAnchor.constraint(equalTo: turnTable.heightAnchor, multiplier: 0.7),
            first.widthAnchor.constraint(equalTo: first.heightAnchor),
            first.centerYAnchor.constraint(equalTo: turnTable.centerYAnchor),
            first.leftAnchor.constraint(equalTo: turnTable.leftAnchor, constant: padding),
            
            second.heightAnchor.constraint(equalTo: turnTable.heightAnchor, multiplier: 0.7),
            second.widthAnchor.constraint(equalTo: second.heightAnchor),
            second.centerYAnchor.constraint(equalTo: turnTable.centerYAnchor),
            second.centerXAnchor.constraint(equalTo: turnTable.centerXAnchor),
            
            third.heightAnchor.constraint(equalTo: turnTable.heightAnchor, multiplier: 0.7),
            third.widthAnchor.constraint(equalTo: third.heightAnchor),
            third.centerYAnchor.constraint(equalTo: turnTable.centerYAnchor),
            third.rightAnchor.constraint(equalTo: turnTable.rightAnchor, constant: -padding),
        ])
    }
    
    
}

extension ViewController {
    //MARK: - touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if view.isUserInteractionEnabled {
            if let touch = touches.first {
                var isFound = false
                touchPoint = touch.location(in: self.view)
                
                for view in view.subviews {
                    if view.frame.contains(touchPoint) && view != firstCard && view != secondCard && view != thirdCard && view != turnTable && view != playButton && !view.isHidden && view != backgroundView {
                        viewToMove = view
                        startPointOfMovedView = view.layer.position
                        isFound = true
                        Vibration.light.vibrate()
                        break
                    }
                }
                if !isFound {
                    viewToMove = nil
                }
            }
        }
    }
    
    //MARK: - touchesMoved
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if view.isUserInteractionEnabled {
            if let touch = touches.first {
                let newTouchPoint = touch.location(in: self.view)
                let deltaX = newTouchPoint.x - touchPoint.x
                let deltaY = newTouchPoint.y - touchPoint.y
                
                viewToMove?.center.x += deltaX
                viewToMove?.center.y += deltaY
                
                touchPoint = newTouchPoint
            }
        }
    }
    
    //MARK: - touchesEnded
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if view.isUserInteractionEnabled {
            touchPoint = nil
            if let viewToMove = viewToMove {
                if turnTable.frame.contains(viewToMove.center) {
                    Vibration.light.vibrate()
                    switch viewToMove {
                    case birdIV:
                        first.image = birdIV.image
                        skullIV.isHidden = false
                        heartIV.isHidden = false
                        logo = .bird
                    case skullIV:
                        first.image = skullIV.image
                        birdIV.isHidden = false
                        heartIV.isHidden = false
                        logo = .skull
                    case heartIV:
                        first.image = heartIV.image
                        skullIV.isHidden = false
                        birdIV.isHidden = false
                        logo = .heart
                    case oneIV:
                        second.image = oneIV.image
                        twoIV.isHidden = false
                        threeIV.isHidden = false
                        number = .one
                    case twoIV:
                        second.image = twoIV.image
                        oneIV.isHidden = false
                        threeIV.isHidden = false
                        number = .two
                    case threeIV:
                        second.image = threeIV.image
                        oneIV.isHidden = false
                        twoIV.isHidden = false
                        number = .three
                    case blueIV:
                        third.image = blueIV.image
                        pinkIV.isHidden = false
                        yellowIV.isHidden = false
                        color = .blue
                    case yellowIV:
                        third.image = yellowIV.image
                        blueIV.isHidden = false
                        pinkIV.isHidden = false
                        color = .yellow
                    case pinkIV:
                        third.image = pinkIV.image
                        blueIV.isHidden = false
                        yellowIV.isHidden = false
                        color = .pink
                    default:
                        break
                    }
                    viewToMove.isHidden = true
                } else {
                    Vibration.light.vibrate()
                }
                viewToMove.layer.position = startPointOfMovedView
            }
        }
    }
    
}
extension ViewController {
    
    //MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        enableTouchHandling(true)
    }
    
    //MARK: - viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        enableTouchHandling(false)
    }
    
    //MARK: - enableTouchHanding
    func enableTouchHandling(_ enabled: Bool) {
        if enabled {
            view.isUserInteractionEnabled = true
        } else {
            view.isUserInteractionEnabled = false
        }
    }
}
