//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Girish Rawat on 8/24/18.
//  Copyright © 2018 Girish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingLabel: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear called")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordButton(_ sender: UIButton) {
        print("button was pressed")
        recordingLabel.text = "Recording in progress"
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        print("Recording Stopped")
        recordingLabel.text = "Tap to record"
    }
}

