//
//  ViewController.swift
//  sayThatAgainApp
//
//  Created by CheChenLiu on 2021/8/11.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let player = AVPlayer()
    
    lazy var synthesizer:AVSpeechSynthesizer = {
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.delegate = self
        return synthesizer
    }()
    
    var language:String = "zh-TW"
    
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var speedRateSlider: UISlider!
    @IBOutlet weak var voicePitchSlider: UISlider!
    @IBOutlet weak var speedRateText: UILabel!
    @IBOutlet weak var voicePitchText: UILabel!
    @IBOutlet weak var speakVolumnSlider: UISlider!
    @IBOutlet weak var crashBtn: UIButton!
    @IBOutlet weak var rightHiHatBtn: UIButton!
    @IBOutlet weak var leftHiHatBtn: UIButton!
    @IBOutlet weak var snareBtn: UIButton!
    @IBOutlet weak var bassBtn: UIButton!
    @IBOutlet weak var tom1Btn: UIButton!
    @IBOutlet weak var tom2Btn: UIButton!
    @IBOutlet weak var rideBtn: UIButton!
    @IBOutlet weak var floortomBtn: UIButton!
    @IBOutlet weak var speakBtn: UIButton!
    @IBOutlet weak var colorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        speakBtn.setImage(UIImage(named: "playIcon"), for: UIControl.State.normal)
        
        colorView.layer.cornerRadius = 30
        colorView.clipsToBounds = true
        colorView.backgroundColor = UIColor(red: 247/255, green:247/255, blue: 247/255, alpha: 1)
    }

    @IBAction func changeSlider(_ sender: Any) {
        speedRateText.text = String(format: "%.1f", speedRateSlider.value)
        voicePitchText.text = String(format: "%.1f", voicePitchSlider.value)
    }
    
    @IBAction func speedRandomBtn(_ sender: Any) {
        speedRateSlider.value = Float.random(in: 0.1...1)
        speedRateText.text = String(format: "%.1f", speedRateSlider.value)
    }
    
    @IBAction func voicePitchRandomBtn(_ sender: Any) {
        voicePitchSlider.value = Float.random(in: 0.1...1)
        voicePitchText.text = String(format: "%.1f", voicePitchSlider.value)
    }
    
    @IBAction func segmentDidSwitch(_ sender: UISegmentedControl) {
        
        if (sender.selectedSegmentIndex == 1) {
            language = "en-US"
        } else if (sender.selectedSegmentIndex == 2) {
            language = "zh-HK"
        }
        
        if (synthesizer.isSpeaking) {
            let alert = UIAlertController.init(title: "語言轉換", message: "請重新點擊播放鍵!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
            speakBtn.setImage(UIImage(named: "playIcon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func speak(_ sender: Any) {
        
        let speechUtterance = AVSpeechUtterance(string: wordTextField.text!)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: language)
        speechUtterance.rate = speedRateSlider.value
        speechUtterance.pitchMultiplier = voicePitchSlider.value
        speechUtterance.volume = speakVolumnSlider.value
        
        print("synthesizer.isSpeaking = \(synthesizer.isSpeaking)")
        print("synthesizer.isPaused = \(synthesizer.isPaused)")
        
        if wordTextField.text != nil  {
            if !synthesizer.isSpeaking,
               !synthesizer.isPaused {
                
                synthesizer.speak(speechUtterance)
                setPauseIcon()
                
            } else if synthesizer.isSpeaking,
                      !synthesizer.isPaused {
                
                synthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
                setPlayIcon()
                
            } else if synthesizer.isSpeaking,
                      synthesizer.isPaused {
                
                synthesizer.continueSpeaking()
                setPauseIcon()
                
            } else {
                
                setPlayIcon()
                
            }
        }
    }

    private func setPlayIcon(){
        speakBtn.setImage(UIImage(named: "playIcon"), for: UIControl.State.normal)
    }
    
    private func setPauseIcon(){
        speakBtn.setImage(UIImage(named: "pauseIcon"), for: UIControl.State.normal)
    }
    
    @IBAction func hitDrumSet(_ sender: UIButton) {
        if sender == bassBtn {
            let soundUrl = Bundle.main.url(forResource: "bassSound", withExtension: "mp3")!
            let playerItem = AVPlayerItem(url: soundUrl)
            player.replaceCurrentItem(with: playerItem)
            playerPlay()
        }
        if sender == snareBtn {
            let soundUrl = Bundle.main.url(forResource: "snareSound", withExtension: "mp3")!
            let playerItem = AVPlayerItem(url: soundUrl)
            player.replaceCurrentItem(with: playerItem)
            playerPlay()
        }
        if sender == rightHiHatBtn {
            let soundUrl = Bundle.main.url(forResource: "hihatSound", withExtension: "mp3")!
            let playerItem = AVPlayerItem(url: soundUrl)
            player.replaceCurrentItem(with: playerItem)
            playerPlay()
        }
        if sender == leftHiHatBtn {
            let soundUrl = Bundle.main.url(forResource: "hihatSound2", withExtension: "mp3")!
            let playerItem = AVPlayerItem(url: soundUrl)
            player.replaceCurrentItem(with: playerItem)
            playerPlay()
        }
        if sender == crashBtn {
            let soundUrl = Bundle.main.url(forResource: "crashSound", withExtension: "mp3")!
            let playerItem = AVPlayerItem(url: soundUrl)
            player.replaceCurrentItem(with: playerItem)
            playerPlay()
        }
        if sender == tom1Btn {
            let soundUrl = Bundle.main.url(forResource: "tom1Sound", withExtension: "mp3")!
            let playerItem = AVPlayerItem(url: soundUrl)
            player.replaceCurrentItem(with: playerItem)
            playerPlay()
        }
        if sender == tom2Btn {
            let soundUrl = Bundle.main.url(forResource: "tom2Sound", withExtension: "mp3")!
            let playerItem = AVPlayerItem(url: soundUrl)
            player.replaceCurrentItem(with: playerItem)
            playerPlay()
        }
        if sender == rideBtn {
            let soundUrl = Bundle.main.url(forResource: "rideSound", withExtension: "mp3")!
            let playerItem = AVPlayerItem(url: soundUrl)
            player.replaceCurrentItem(with: playerItem)
            playerPlay()
        }
        if sender == floortomBtn {
            let soundUrl = Bundle.main.url(forResource: "floortomSound", withExtension: "mp3")!
            let playerItem = AVPlayerItem(url: soundUrl)
            player.replaceCurrentItem(with: playerItem)
            playerPlay()
        }
    }

    func playerPlay() {
        player.volume = 1
        player.play()
    }
}

extension ViewController :AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        setPlayIcon()
    }
}
