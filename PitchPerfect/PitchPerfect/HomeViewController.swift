//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Jan Skála on 08.03.18.
//  Copyright © 2018 Jan Skála. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var recordStopButton: UIButton!
    
    @IBOutlet weak var hintLabel: UILabel!
    
    static let hintRecordVoice = "Record your voice first and enjoy it's funny modifications";
    static let hintStopRecording = "Stop recording and start modifying your voice";
    
    enum RecordingState{
        case recording, not_recording
    }
    
    var currentState = RecordingState.not_recording
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    /// Called before showing views, setting initial helping instruction.
    ///
    /// - Parameter animated:
    override func viewWillAppear(_ animated: Bool) {
        updateView();
    }

    
    /// Called whan recording control button is clicked
    ///
    /// - Parameter sender: 
    @IBAction func recordStopClicked(_ sender: Any) {
        switch(currentState){
            case .recording:
                currentState = .not_recording
            case .not_recording:
                currentState = .recording
                stopRecording();
        }
        updateView()
    }
    
    
    /// Updates recording control button and hint label
    func updateView(){
        var buttonImage : UIImage!
        switch(currentState){
            case .recording:
                setHint(HomeViewController.hintStopRecording)
                buttonImage = #imageLiteral(resourceName: "Stop")
            default:
                setHint(HomeViewController.hintRecordVoice)
                buttonImage = #imageLiteral(resourceName: "Record")
        }
        setButtonImage(buttonImage)
    }
    
    
    func setHint(_ hint : String){
        hintLabel?.text = hint
    }
    
    func setButtonImage(_ image : UIImage){
        recordStopButton.setImage(image , for: .normal)
    }
    
    func stopRecording(){
        
    }
}

