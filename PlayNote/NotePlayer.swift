//
//  NotePlayer.swift
//  PlayNote
//
//  Created by Robert Linnemann on 4/12/19.
//  Copyright © 2019 Robert Linnemann. All rights reserved.
//

import Foundation
import AudioToolbox

class NotePlayer {
    
    var octave = 1
    var midiChannel = UInt32(0)
    var midiVelocity = 100
    //
    var processingGraph: AUGraph?
    var midisynthNode   = AUNode()
    var ioNode          = AUNode()
    var midisynthUnit: AudioUnit?

    init() {
        self.initAudio()
    }

    // MARK: Audio Init
    func initAudio() {
        // the graph is like a patch bay, where everything gets connected
        CheckError(osstatus: NewAUGraph(&processingGraph))
        createIONode()
        createSynthNode()
        CheckError(osstatus: AUGraphOpen(processingGraph!))
        CheckError(osstatus: AUGraphNodeInfo(processingGraph!, midisynthNode, nil, &midisynthUnit))
        let synthOutputElement:AudioUnitElement = 0
        let ioUnitInputElement:AudioUnitElement = 0
        CheckError(osstatus:
            AUGraphConnectNodeInput(processingGraph!, midisynthNode, synthOutputElement, ioNode, ioUnitInputElement))
        CheckError(osstatus: AUGraphInitialize(processingGraph!))
        CheckError(osstatus: AUGraphStart(processingGraph!))
    }

    // MARK: Audio Action
    func noteOn(note: UInt8) {
        let noteCommand = UInt32(0x90 | self.midiChannel)
        let base = note - 48
        let octaveAdjust = (UInt8(octave) * 12) + base
        let pitch = UInt32(octaveAdjust)

        CheckError(osstatus: MusicDeviceMIDIEvent(self.midisynthUnit!,
                                                  noteCommand, pitch, UInt32(self.midiVelocity), 0))
    }

    func noteOff(note: UInt8) {
        let noteCommand = UInt32(0x80 | self.midiChannel)
        let base = note - 48
        let octaveAdjust = (UInt8(octave) * 12) + base
        let pitch = UInt32(octaveAdjust)

        CheckError(osstatus: MusicDeviceMIDIEvent(self.midisynthUnit!,
                                                  noteCommand, pitch, 0, 0))
    }

    // Mark: - Audio Init Utility Methods
    private func createIONode() {
        var cd = AudioComponentDescription(
            componentType: OSType(kAudioUnitType_Output),
            componentSubType: OSType(kAudioUnitSubType_RemoteIO),
            componentManufacturer: OSType(kAudioUnitManufacturer_Apple),
            componentFlags: 0,componentFlagsMask: 0)
        CheckError(osstatus: AUGraphAddNode(processingGraph!, &cd, &ioNode))
    }

    private func createSynthNode() {
        var cd = AudioComponentDescription(
            componentType: OSType(kAudioUnitType_MusicDevice),
            componentSubType: OSType(kAudioUnitSubType_MIDISynth),
            componentManufacturer: OSType(kAudioUnitManufacturer_Apple),
            componentFlags: 0,componentFlagsMask: 0)
        CheckError(osstatus: AUGraphAddNode(processingGraph!, &cd, &midisynthNode))
    }
}
