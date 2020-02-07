//
//  FifthViewController.swift
//  music
//
//  Created by Sabrina on 1/28/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import UIKit
import AVFoundation

class FifthViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    //variables
    let audioSession = AVAudioSession.sharedInstance()
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
    //constant file name so always overwriting insetead of creating new
    let filename = "audio.m4a" //can also use aif possibly
    
    
    //connections
    @IBOutlet weak var recordAudio: UIButton!
    @IBOutlet weak var stopAudio: UIButton!
    @IBOutlet weak var playAudio: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) //userdomainmask: portion of system where user gets to modify files
        //above, returns an array
        let docDir = dirPath[0] //only want first one
        let audioFilePath = docDir.appendingPathComponent(filename)
        print(audioFilePath)
        
        //configre audio session
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .init(rawValue: 1)) //options set volume baseline
        } catch {
            print(error)
        }
        
        //dictionary of settings, these are pretty standard settings
        let settings = [
            //dif settings listed on avaudiorecorder documentation, some required
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC), //audio codec
            AVSampleRateKey: 1200, //sample rate hZ
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue //bit rate
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilePath, settings: settings)
            audioRecorder?.prepareToRecord() //assuming we got audio recordder we need to prepar it to record
            print("Audio recorder ready!")
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        if let recorder = audioRecorder {
            //we have an instance of AudioRecorder
            if recorder.isRecording == false {
                playAudio.isEnabled = false
                stopAudio.isEnabled = true
                recorder.delegate = self //lets recorder know its responsible for responsidng to itself, like handling errors etc
                
                recorder.record()
            }
        } else {
            print("No recorder!")
        }
    }
    
    @IBAction func playAudio(_ sender: Any) {
        if audioRecorder?.isRecording == false {
            stopAudio.isEnabled = true
            recordAudio.isEnabled = false
            
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: (audioRecorder?.url)!)
                try audioSession.setCategory(AVAudioSession.Category.playback) //so it will be loud enough
                
                audioPlayer!.delegate = self //so can respond to its own events
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
            } catch {
                print("could not play audio")
            }
        }
    }
    
    @IBAction func stopAudio(_ sender: Any) {
        //stop recording or playing based on what's happening
        stopAudio.isEnabled = false
        playAudio.isEnabled = true
        recordAudio.isEnabled = true
        
        if audioRecorder?.isRecording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
            //rset session mode
            do {
                try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            } catch {
                print(error)
            }
        }
    }
    
    //delegate method for audioPlayer
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordAudio.isEnabled = true
        stopAudio.isEnabled = false
        
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
        } catch {
            print(error)
        }

    }

}
