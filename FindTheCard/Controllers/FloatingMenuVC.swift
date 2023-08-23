//
//  FloatingMenuVC.swift
//  FindTheCard
//
//  Created by admin on 21.08.2023.
//

import UIKit

class FloatingMenuVC: UIViewController {
    
    let padding: CGFloat = 20
    
    var scrollView: UIScrollView!
    
    var delegate: ViewController!
    
    var coinsLabel: UILabel!
    
    var logo: cardLogo?
    var logoBet = 0
    var number: cardNumber?
    var numberBet = 0
    var color: cardColor?
    var colorBet = 0
    
    var turnTable: UIView!
    var first: UIImageView!
    var second: UIImageView!
    var third: UIImageView!
    
    var View1: BetView!
    var View2: BetView!
    var View3: BetView!
    
    var betButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setupChosen()
        setupCoinsLabel()
        setupBetButton()
        setupBetViews()
        hideKeyboardWhenTappedAround()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    func setupChosen(){
        self.logo = delegate.logo
        self.color = delegate.color
        self.number = delegate.number
        
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
        turnTable.addSubview(first)
        
        second = UIImageView()
        second.contentMode  = .scaleToFill
        second.translatesAutoresizingMaskIntoConstraints = false
        second.layer.zPosition = 2
        turnTable.addSubview(second)
        
        third = UIImageView()
        third.contentMode  = .scaleToFill
        third.translatesAutoresizingMaskIntoConstraints = false
        third.layer.zPosition = 2
        turnTable.addSubview(third)
        first.isUserInteractionEnabled = true
        second.isUserInteractionEnabled = true
        third.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            turnTable.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            turnTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            turnTable.heightAnchor.constraint(equalToConstant: 70),
            turnTable.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            
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
        
        switch logo {
        case .bird:
            first.image  = UIImage(named: "bird")
        case .skull:
            first.image  = UIImage(named: "skull")
        case .heart:
            first.image  = UIImage(named: "heart")
        default:
            break
        }
        
        switch number {
        case .one:
            second.image  = UIImage(named: "1")
        case .two:
            second.image  = UIImage(named: "2")
        case .three:
            second.image  = UIImage(named: "3")
        default:
            break
        }
        
        switch color {
        case .blue:
            third.image  = UIImage(named: "blue")
        case .yellow:
            third.image  = UIImage(named: "yellow")
        case .pink:
            third.image  = UIImage(named: "pink")
        default:
            break
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        delegate.enableTouchHandling(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        delegate.enableTouchHandling(false)
    }
    

    private func setBackground(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemChromeMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        let hookView = UIView()
        hookView.backgroundColor = .label
        hookView.translatesAutoresizingMaskIntoConstraints = false
        hookView.clipsToBounds = true
        hookView.layer.cornerRadius = 3
        view.addSubview(hookView)
        NSLayoutConstraint.activate([
            hookView.topAnchor.constraint(equalTo: view.topAnchor, constant: 7),
            hookView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            hookView.heightAnchor.constraint(equalToConstant: 6),
            hookView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupCoinsLabel(){
        coinsLabel = UILabel()
        coinsLabel.text = "\(GameManager.shared.points)"
        coinsLabel.font = UIFont(name: "AvenirNext-Bold", size: 30)
        coinsLabel.textAlignment = .center
        coinsLabel.textColor = .white
        coinsLabel.translatesAutoresizingMaskIntoConstraints  = false
        view.addSubview(coinsLabel)
        NSLayoutConstraint.activate([
            coinsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coinsLabel.topAnchor.constraint(equalTo: turnTable.bottomAnchor, constant: padding),
        ])
    }
    
    func setupBetViews() {
        View1 = BetView()
        View1.translatesAutoresizingMaskIntoConstraints = false
        View1.clipsToBounds = true
        View1.layer.cornerRadius = 10
        View1.backgroundColor = .brown
        View1.delegate = self
        View1.enumValue =  logo
        if logo == nil {
            View1.numberTextField.isEnabled = false
            View1.imageView.image = UIImage(named: "gameLogoPin")
            View1.numberTextField.placeholder = "Choose logo sign to edit"
            View1.backgroundColor = .gray
        } else {
            View1.imageView.image = first.image
        }
        view.addSubview(View1)
        NSLayoutConstraint.activate([
            View1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            View1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            View1.topAnchor.constraint(equalTo: coinsLabel.bottomAnchor, constant: padding),
            View1.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])
        
        View2 = BetView()
        View2.translatesAutoresizingMaskIntoConstraints = false
        View2.clipsToBounds = true
        View2.layer.cornerRadius = 10
        View2.backgroundColor = .brown
        View2.delegate = self
        View2.enumValue =  number
        if number == nil {
            View2.numberTextField.isEnabled = false
            View2.numberTextField.placeholder = "Choose number sign to edit"
            View2.imageView.image = UIImage(named: "gameLogoPin")
            View2.backgroundColor = .gray
        } else {
            View2.imageView.image = second.image
        }
        view.addSubview(View2)
        NSLayoutConstraint.activate([
            View2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            View2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            View2.topAnchor.constraint(equalTo: View1.bottomAnchor, constant: padding),
            View2.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])
        
        View3 = BetView()
        View3.translatesAutoresizingMaskIntoConstraints = false
        View3.clipsToBounds = true
        View3.layer.cornerRadius = 10
        View3.backgroundColor = .brown
        View3.enumValue =  color
        View3.delegate = self
        if color == nil {
            View3.numberTextField.isEnabled = false
            View3.imageView.image = UIImage(named: "gameLogoPin")
            View3.numberTextField.placeholder = "Choose color sign to edit"
            View3.backgroundColor = .gray
        }  else {
            View3.imageView.image = third.image
        }
        view.addSubview(View3)
        NSLayoutConstraint.activate([
            View3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            View3.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            View3.topAnchor.constraint(equalTo: View2.bottomAnchor, constant: padding),
            View3.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])
    }
    
    func hideKeyboardWhenTappedAround() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    func setupBetButton(){
        betButton = UIButton(type: .custom)
        betButton.translatesAutoresizingMaskIntoConstraints = false
        betButton.setTitle("Play", for: .normal)
        betButton.clipsToBounds = true
        betButton.layer.cornerRadius = 20
        betButton.backgroundColor = .orange
        view.addSubview(betButton)
        betButton.addTarget(self, action: #selector(bet), for: .touchUpInside)
        NSLayoutConstraint.activate([
            betButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            betButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            betButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            betButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func bet(){
        Vibration.light.vibrate()
        print("LOGO: \(logoBet)")
        print("COLOR: \(colorBet)")
        print("number: \(numberBet)")
        print(GameManager.shared.points)
        if logo == nil {
            logoBet = 0
        } 
        if color == nil {
            colorBet = 0
        }
        if number == nil {
            numberBet = 0
        }
        print("LOGO1: \(logoBet)")
        print("COLOR1: \(colorBet)")
        print("number1: \(numberBet)")
        if logoBet + colorBet + numberBet > GameManager.shared.points {
            print("NO")
            let alertController = UIAlertController(title: "Hey!", message: "You have no \(logoBet + colorBet + numberBet) coins!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: {
            })
        } else {
            print("YES")
            self.dismiss(animated: true)
            Bet.shared = Bet(logo: logo, logoBet: logoBet, number: number, numberBet: numberBet, color: color, colorBet: colorBet)
            delegate.openCards()
        }
    }
    
}
