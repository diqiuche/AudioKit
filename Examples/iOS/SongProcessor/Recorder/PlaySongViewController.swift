//
//  PlaySongViewController.swift
//  SongProcessor
//
//  Created by Kanstantsin Linou on 6/17/16.
//  Copyright © 2016 AudioKit. All rights reserved.
//

import UIKit
import AudioKit

class PlaySongViewController: UIViewController, AKAudioPlayerDelegate {
    
    @IBOutlet var playingButton: UIButton!
    @IBOutlet var stopPlayingButton: UIButton!
    @IBOutlet var cutoffFrequencyLabel: UILabel!
    @IBOutlet var resonanceLabel: UILabel!
    var recordedSongURL: NSURL!
    var player: AKAudioPlayer!
    var songFile: AKAudioFile!
    var moogLadder: AKMoogLadder!
    
    
    
    @IBAction func stopSong(sender: AnyObject) {
        player?.stop()
        updateUI(for: PlayerState.Stopped)
    }
    
    @IBAction func playSong(sender: AnyObject) {
        player?.play()
        updateUI(for: PlayerState.Playing)
    }
    
    @IBAction func setCutoffFrequency(sender: UISlider) {
        moogLadder.cutoffFrequency = Double(sender.value)
        cutoffFrequencyLabel!.text = "Cutoff Frequency: \(String(format: "%0.0f", moogLadder.cutoffFrequency))"
    }
    
    @IBAction func setResonance(sender: UISlider) {
        moogLadder.resonance = Double(sender.value)
        resonanceLabel!.text = "Resonance: \(String(format: "%0.3f", moogLadder.resonance))"
    }
    func playerStoppedOrFinished() {
        dispatch_async(dispatch_get_main_queue()) {
            self.updateUI(for: PlayerState.Stopped)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI(for: PlayerState.Stopped)
        setupFile()
        setupSongEffects()
    }
    
    func setupFile() {
        do {
            let fileName = (recordedSongURL.URLByDeletingPathExtension?.lastPathComponent)!
            let fileExtension = (recordedSongURL.pathExtension)!
            songFile = try AKAudioFile(forReadingFileName: fileName, withExtension: fileExtension, fromBaseDirectory: AKAudioFile.BaseDirectory.temp)
            player = try? AKAudioPlayer(file: songFile)
            player?.delegate = self
        } catch {
            print("\((recordedSongURL.lastPathComponent)!) wasn't found.")
        }
    }
    
    func setupSongEffects() {
        moogLadder = AKMoogLadder(player)
        AudioKit.output = moogLadder
        AudioKit.start()
    }
    
    func updateUI(for state: PlayerState) {
        switch state {
        case .Playing:
            playingButton.enabled = false
            stopPlayingButton.enabled = true
        case .Stopped:
            playingButton.enabled = true
            stopPlayingButton.enabled = false
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        AudioKit.stop()
    }
}