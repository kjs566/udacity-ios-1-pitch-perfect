//
//  ModifyVoiceViewController.swift
//  PitchPerfect
//
//  Created by Jan Skála on 08.03.18.
//  Copyright © 2018 Jan Skála. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Foundation


/// Controller for selecting and applying sound effects.
class ModifyVoiceViewController: UIViewController, AudioPlayerDelegate {
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    var recordedAudioURL : URL!
    var audioPlayer : AudioPlayer!

    enum ButtonType: Int { case slow = 0, fast, chipmunk, vader, echo, reverb }
    
    enum PlayingState { case playing, notPlaying }
    
    let hints = [
        -1: "Modify the recording",
        0: "Going slower...",
        1: "Going faster...",
        2: "Higher pitch...",
        3: "Lower pitch...",
        4: "Playing echo...",
        5: "Playing reverb..."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AudioPlayer(recordedAudioURL: recordedAudioURL, delegate: self)
        self.title = "Voice modification"
        showHint(-1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateView(.notPlaying)
    }

    @IBAction func playSoundForButton(_ sender : UIButton){
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            audioPlayer.playSound(rate: 0.5)
        case .fast:
            audioPlayer.playSound(rate: 1.5)
        case .chipmunk:
            audioPlayer.playSound(pitch: 1000)
        case .vader:
            audioPlayer.playSound(pitch: -1000)
        case .echo:
            audioPlayer.playSound(echo: true)
        case .reverb:
            audioPlayer.playSound(reverb: true)
        }
        
        updateView(.playing)
        showHint(sender.tag)
    }

    @IBAction func stopButtonPressed(_ sender : UIButton){
        print("stop button pressed")
        audioPlayer.stopAudio();
        showHint(-1)
    }
    
    private func showHint(_ hintCase : Int){
        hintLabel.text = hints[hintCase]
    }
    
    private func updateView(_ playState: PlayingState) {
        switch(playState) {
        case .playing:
            setPlayButtonsEnabled(false)
            stopButton.isEnabled = true
        case .notPlaying:
            setPlayButtonsEnabled(true)
            stopButton.isEnabled = false
        }
    }
    
    private func setPlayButtonsEnabled(_ enabled: Bool) {
        slowButton.isEnabled = enabled
        highPitchButton.isEnabled = enabled
        fastButton.isEnabled = enabled
        lowPitchButton.isEnabled = enabled
        echoButton.isEnabled = enabled
        reverbButton.isEnabled = enabled
    }
    
    func audioPlayingStopped() {
        updateView(.notPlaying)
        showHint(-1)
    }
    
    func audioPlayerFailed(errorTitle : String, errorMessage: String) {
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}

