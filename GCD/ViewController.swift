//
//  ViewController.swift
//  GCD
//
//  Created by Арген on 03.01.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        afterBlock(seconds: 2) {
//            print("Hello")
//
//            print(Thread.current)
//        }
        
//        afterBlock(seconds: 2, queue: .main) {
//            print("Hello")
//            self.craetAlert()
//            print(Thread.current)
//        }
    }

    func afterBlock(seconds: Int, queue: DispatchQueue = DispatchQueue.global(), completion: @escaping ()->()) {
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            completion()
        }
    }
    
    func craetAlert() {
        let alert = UIAlertController(title: nil, message: "Hello", preferredStyle: .alert)
        let action = UIAlertAction(title: "Next", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

}

