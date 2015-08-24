//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Richard Trevivian on 8/23/15.
//  Copyright (c) 2015 Richard Trevivian. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playAudio(rate: Float) {
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        playAudioWithEffect(changePitchEffect)
    }
    
    func playAudioWithEffect(audioNode: AVAudioNode){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(audioNode)
        
        audioEngine.connect(audioPlayerNode, to: audioNode, format: nil)
        audioEngine.connect(audioNode, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func playSlowAudio(sender: UIButton) {
        playAudio(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudio(1.5)
    }
   
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playBarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }

    @IBAction func playEchoAudio(sender: UIButton) {
        var addEchoEffect = AVAudioUnitDelay()
        addEchoEffect.wetDryMix = 100
        playAudioWithEffect(addEchoEffect)
    }
    
    @IBAction func playReverbAudio(sender: UIButton) {
        var addReverbEffect = AVAudioUnitReverb()
        addReverbEffect.wetDryMix = 100
        playAudioWithEffect(addReverbEffect)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
    }
}
