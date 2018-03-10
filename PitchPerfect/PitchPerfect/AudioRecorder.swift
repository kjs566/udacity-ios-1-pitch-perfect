//
//  AudioRecorder.swift
//  PitchPerfect
//
//  Created by Jan Skála on 10.03.18.
//  Copyright © 2018 Jan Skála. All rights reserved.
//

import Foundation

//
//  AudioUtils.swift
//  PitchPerfect
//
//  Created by Jan Skála on 10.03.18.
//  Copyright © 2018 Jan Skála. All rights reserved.
//

import Foundation
import AVKit


/// Class providing audio recording from microphone. Saves the recording to the appropriate file.
class AudioRecorder{
    var audioRecorder : AVAudioRecorder? = nil
    let recordingName : String
    
    
    /// Inits AudioRecorded with provided file name.
    ///
    /// - Parameter recordingName: Optional name of file where the recording is saved
    init(recordingName : String = "recordedVoice.wav"){
        self.recordingName = recordingName
    }
    
    /// Starts sounds recording and saves it continually to the file. Taken parts from previous course content.
    func startRecording(audioRecorderDelegate: AVAudioRecorderDelegate){
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath ?? "")
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder?.delegate = audioRecorderDelegate
        audioRecorder?.isMeteringEnabled = true
        audioRecorder?.prepareToRecord()
        audioRecorder?.record()
    }
    
    /// Stops sounds recording
    func stopRecording(){
        audioRecorder?.stop()
        try! AVAudioSession.sharedInstance().setActive(false)
    }
}
