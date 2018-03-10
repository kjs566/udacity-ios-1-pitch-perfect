//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Jan Skála on 08.03.18.
//  Copyright © 2018 Jan Skála. All rights reserved.
//

import UIKit
import AVFoundation


/// Controller for recording the sound.
class HomeViewController: UIViewController, AVAudioRecorderDelegate  {
    @IBOutlet weak var recordStopButton: UIButton!
    
    @IBOutlet weak var hintLabel: UILabel!
    
    static let hintRecordVoice = "Record your voice first and enjoy it's funny modifications.";
    static let hintStopRecording = "Now stop recording and start modifying your voice.";
    
    let audioRecorder : AudioRecorder = AudioRecorder()
    
    enum RecordingState{
        case recording, not_recording
    }
    
    var currentState = RecordingState.not_recording
    
    
    /// Called before showing views, setting initial helping instruction.
    override func viewWillAppear(_ animated: Bool) {
        updateView();
    }

    
    /// Called whan recording control button is clicked
    @IBAction func recordStopClicked(_ sender: Any) {
        switch(currentState){
            case .recording:
                currentState = .not_recording
                audioRecorder.stopRecording()
            case .not_recording:
                currentState = .recording
                audioRecorder.startRecording(audioRecorderDelegate: self)
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
    
    
    /// Called after recording is saved and performs seque to ModifyVoiceViewController
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: recorder.url)
        }else{
            print("Recording saving failed")
        }
    }
    
    
    
    /// Prepares the next controller and sets the back button title
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! ModifyVoiceViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
}

