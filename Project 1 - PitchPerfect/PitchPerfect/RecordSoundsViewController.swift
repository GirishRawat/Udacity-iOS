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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print("view will appear called")
        stopRecordingButton.isHidden = true
        recordButton.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioRecorder?.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func recordButton(_ sender: UIButton) {
        print("Recording audio..")
        recordingLabel.text = "Recording in progress"
        stopRecordingButton.isHidden = false
        recordButton.isEnabled = false
        
        print(" See logs here ")
        
        print(audioRecorder)
        
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
//        print("Recording Stopped")
        recordingLabel.text = "Tap to record"
        stopRecordingButton.isEnabled = false
        
        audioRecorder?.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder!, successfully flag: Bool) {
        print("finished recording")
        if flag {
//            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
            print("recording successfull!")
        }else{
            print("Problem saving audio file")
        }
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "recordingDoneSegue"){
//            let playSoundsVC = segue.destination as! PlaySoundsViewController
//            playSoundsVC.recordedAudioURL = sender as! URL
//        }
//    }
}

