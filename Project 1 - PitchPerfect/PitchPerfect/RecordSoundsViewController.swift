//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Girish Rawat on 8/24/18.
//  Copyright © 2018 Girish. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController,  AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingLabel: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    enum PlayingState { case recording, notRecording }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopRecordingButton.isHidden = true
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioRecorder?.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func configureUI(_ playState: PlayingState) {
        switch(playState) {
        case .recording:
            recordingLabel.text = "Recording in progress"
            stopRecordingButton.isHidden = false
            recordButton.isEnabled = false
        case .notRecording:
            recordingLabel.text = "Tap to record"
            stopRecordingButton.isEnabled = false
        }
    }
    

    @IBAction func recordButton(_ sender: UIButton) {
        
        configureUI(.recording)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        
        configureUI(.notRecording)
        
        audioRecorder?.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder!, successfully flag: Bool) {
        print("finished recording")
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
            print("recording successfull!")
        }else{
            print("Problem saving audio file")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            playSoundsVC.recordedAudioUrl = sender as! URL
        }
    }
}

