//
//  AboutViewController.swift
//  PitchPerfect
//
//  Created by Jan Skála on 08.03.18.
//  Copyright © 2018 Jan Skála. All rights reserved.
//

import UIKit


/// About me and about app controller.
class AboutViewController: UIViewController {
    @IBOutlet weak var aboutText: UITextView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    var currentSegment = 0;
    let aboutTexts = [
        0: "Hi, my name is Jan Skála.\n\nI'm currently studying Artificial Intelligence at Czech Technical Univercity in Prague and working as Android and hybrid app developer at CGI.\n\nMy hobies are squash, programming and biking.  In the mean time I'm learning new stuff - and that's the reason why this app was created.\n\nHope you will enjoy it!",
        1: "This app was created as the first project during Udacity's iOS Developer Nanodegree program.\n\nThe purpose doing this app was to learn basic stuff from iOS development framework and basics of XCode IDE. It is not intended to be published to users."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "About"
        
        updateView();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        currentSegment = segmentedControl.selectedSegmentIndex;
        updateView();
    }
    
    private func updateView(){
        aboutText?.text = aboutTexts[currentSegment]
    }
    
}
