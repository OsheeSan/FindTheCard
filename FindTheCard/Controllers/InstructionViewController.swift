//
//  InstructionViewController.swift
//  FindTheCard
//
//  Created by admin on 22.08.2023.
//

import UIKit

class InstructionViewController: UIViewController {
    
    var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        view.backgroundColor = .clear
    }
    
    func setupTextView(){
        textView = UITextView()
        textView.font = UIFont(name: "AvenirNext-Regular", size: 10)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 10
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        if let filePath = Bundle.main.path(forResource: "instruction", ofType: "txt") {
            do {
                let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
                textView.text = fileContents
            } catch {
                print("Error reading file: \(error)")
            }
        }
    }
    
    
    
}
