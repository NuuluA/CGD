//
//  SecondViewController.swift
//  GCD
//
//  Created by Арген on 03.01.2022.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        for i in 0...2000 {
//            print(i)
//        }
        
//        let queue = DispatchQueue.global(qos: .utility)
//        queue.async {
//            DispatchQueue.concurrentPerform(iterations: 20000) { _ in
//
//            }
//        }
        myInactiveQueue()
    }
    
    func myInactiveQueue() {
        let inactiveQueue = DispatchQueue(label: "The Swift Dev", attributes: [.concurrent, .initiallyInactive])
        
        inactiveQueue.async {
            print("Done!!!")
        }
        
        print("Nor yet started")
        inactiveQueue.activate()
        print("Activate")
        inactiveQueue.suspend()
        print("Pause")
        inactiveQueue.resume()
    }

}
