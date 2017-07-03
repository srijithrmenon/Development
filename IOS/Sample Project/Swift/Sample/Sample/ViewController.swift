//
//  ViewController.swift
//  Sample
//
//  Created by Hari Shankar on 21/06/17.
//  Copyright © 2017 Hari Shankar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let trova:Trova = Trova()
    var currentViewController:UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        currentViewController = storyBoard.instantiateViewController(withIdentifier: "ViewControllerIdentifier") as! ViewController
        
        trova.updateCurrentViewController(self, from: currentViewController)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func ChatButtonTapped(_ sender: Any) {
         trova.makeChat("agentKey")
    }

    @IBAction func VideoButtonTapped(_ sender: Any) {
         trova.makeVideoCall("agentKey")
    }
    
    @IBAction func AudioButtonTapped(_ sender: Any) {
         trova.makeAudioCall("agentKey")
    }
    
}

