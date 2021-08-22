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
    
    let synthesizer = AVSpeechSynthesizer()
    
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

    @IBAction func showSliderValue(_ sender: Any) {
        speedRateText.text = String(format: "%.1f", speedRateSlider.value)
        voicePitchText.text = String(format: "%.1f", voicePitchSlider.value)
    }
    
    @IBAction func speedRandomBtn(_ sender: Any) {
        speedRateSlider.value = Float.random(in: 0.1...1)
        speedRateText.text = String(format: "%.1f", speedRateSlider.value)
        
        if (synthesizer.isSpeaking) {
            let alert = UIAlertController.init(title: "語速遭變換", message: "請重新點擊播放鍵!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
            speakBtn.setImage(UIImage(named: "playIcon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func voicePitchRandomBtn(_ sender: Any) {
        voicePitchSlider.value = Float.random(in: 0.1...1)
        voicePitchText.text = String(format: "%.1f", voicePitchSlider.value)
        
        if (synthesizer.isSpeaking) {
            let alert = UIAlertController.init(title: "音調遭變換", message: "請重新點擊播放鍵!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
            speakBtn.setImage(UIImage(named: "playIcon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func segmentDidSwitch(_ sender: UISegmentedControl) {
        
        if (sender.selectedSegmentIndex == 1) {
            language = "en-US"
        } else if (sender.selectedSegmentIndex == 2) {
            language = "zh-HK"
        } else if (sender.selectedSegmentIndex == 0) {
            language = "zh-TW"
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
        
        //印出當前這兩個的值
        print("synthesizer.isSpeaking = \(synthesizer.isSpeaking)")
        print("synthesizer.isPaused = \(synthesizer.isPaused)")
        //isSpeaking我錯誤的理解他了，isSpeaking停下來應該是整段句子講完，甚至應該使用stopSpeaking，單純使用isPaused只是中斷他播放，但他還是在Speaking，透過在錯誤的地方print出行數來debug，例如在95行的地方寫print("Line = 95")，檢查程式是否有執行到這裡，進而debug出是不是判斷式有問題
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
        var soundUrl:URL!
        //"解包"後的寫法，在if裡試著做東西，成功才執行if內的功能
        if sender == bassBtn {
            if let url = Bundle.main.url(forResource: "bassSound", withExtension: "mp3") {
                soundUrl = url
//            soundUrl = Bundle.main.url(forResource: "bassSound", withExtension: "mp3")!
        }
        if sender == snareBtn {
             soundUrl = Bundle.main.url(forResource: "snareSound", withExtension: "mp3")!
        }
        if sender == rightHiHatBtn {
             soundUrl = Bundle.main.url(forResource: "hihatSound", withExtension: "mp3")!
        }
        if sender == leftHiHatBtn {
             soundUrl = Bundle.main.url(forResource: "hihatSound2", withExtension: "mp3")!
        }
        if sender == crashBtn {
             soundUrl = Bundle.main.url(forResource: "crashSound", withExtension: "mp3")!
        }
        if sender == tom1Btn {
             soundUrl = Bundle.main.url(forResource: "tom1Sound", withExtension: "mp3")!
        }
        if sender == tom2Btn {
             soundUrl = Bundle.main.url(forResource: "tom2Sound", withExtension: "mp3")!
        }
        if sender == rideBtn {
             soundUrl = Bundle.main.url(forResource: "rideSound", withExtension: "mp3")!
        }
        if sender == floortomBtn {
             soundUrl = Bundle.main.url(forResource: "floortomSound", withExtension: "mp3")!
        }
        
        let playerItem = AVPlayerItem(url: soundUrl)
        player.replaceCurrentItem(with: playerItem)
        playerPlay()
        
        }

    func playerPlay() {
        player.volume = 1
        player.play()
    }
}
}
