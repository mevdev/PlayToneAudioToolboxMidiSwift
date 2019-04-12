//
//  AudioHelpers.swift
//  PlayNote
//
//  Created by Robert Linnemann on 4/12/19.
//  Copyright © 2019 Robert Linnemann. All rights reserved.
//

import Foundation
import AudioToolbox

public func CheckError(osstatus: OSStatus) {
    switch osstatus {
    case noErr:
        return
    // These are the error codes returned from the APIs found through Core Audio related frameworks.
    case kAudio_UnimplementedError:
        print("Error: kAudio_UnimplementedError Unimplemented core routine.")
    case kAudio_FileNotFoundError:
        print("Error: kAudio_FileNotFoundError File not found.")
    case kAudio_FilePermissionError:
        print("Error: kAudio_FilePermissionError File cannot be opened due to either file, directory, or sandbox permissions.")
    case kAudio_TooManyFilesOpenError:
        print("Error: kAudio_TooManyFilesOpenError File cannot be opened because too many files are already open.")
    case kAudio_BadFilePathError:
        print("Error: kAudio_BadFilePathError File cannot be opened because the specified path is malformed.")
    case kAudio_ParamError:
        print("Error: kAudio_ParamError Error in user parameter list.")
    case kAudio_MemFullError:
        print("Error: kAudio_MemFullError Not enough room in heap zone.")
    // These are the error codes returned from the AUGraph API.
    case kAUGraphErr_NodeNotFound:
        print("Error: kAUGraphErr_NodeNotFound The specified node cannot be found")
    case kAUGraphErr_InvalidConnection:
        print("Error: kAUGraphErr_InvalidConnection The attempted connection between two nodes cannot be made")
    case kAUGraphErr_OutputNodeErr:
        print("Error: kAUGraphErr_OutputNodeErr AUGraphs can only contain one OutputUnit.")
    case kAUGraphErr_CannotDoInCurrentContext:
        print( "Error: kAUGraphErr_CannotDoInCurrentContext To avoid spinning or waiting in the render thread (a bad idea!), many of the calls to AUGraph can return: kAUGraphErr_CannotDoInCurrentContext. This result is only generated when you call an AUGraph API from its render callback. It means that the lock that it required was held at that time, by another thread. If you see this result code, you can generally attempt the action again - typically the NEXT render cycle (so in the mean time the lock can be cleared), or you can delegate that call to another thread in your app. You should not spin or put-to-sleep the render thread.")
    case kAUGraphErr_InvalidAudioUnit:
        print("Error: kAUGraphErr_InvalidAudioUnit")
        // These are the error constants that are unique to Core MIDI. Note that Core MIDI functions may return other codes that are not listed here.
    case kMIDIInvalidClient:
        print("kMIDIInvalidClient An invalid MIDIClientRef was passed.")
    case kMIDIInvalidPort:
        print("Error: kMIDIInvalidPort An invalid MIDIPortRef was passed.")
    case kMIDIWrongEndpointType:
        print("Error: kMIDIWrongEndpointType A source endpoint was passed to a function expecting a destination, or vice versa.")
    case kMIDINoConnection:
        print("Error: kMIDINoConnection Attempt to close a non-existant connection.")
    case kMIDIUnknownEndpoint:
        print("Error: kMIDIUnknownEndpoint An invalid MIDIEndpointRef was passed.")
    case kMIDIUnknownProperty:
        print("Error: kMIDIUnknownProperty Attempt to query a property not set on the object.")
    case kMIDIWrongPropertyType:
        print("Error: kMIDIWrongPropertyType Attempt to set a property with a value not of the correct type.")
    case kMIDINoCurrentSetup:
        print("Error: kMIDINoCurrentSetup Internal error; there is no current MIDI setup object.")
    case kMIDIMessageSendErr:
        print("kError: MIDIMessageSendErr Communication with MIDIServer failed.")
    case kMIDIServerStartErr:
        print("kError: MIDIServerStartErr Unable to start MIDIServer.")
    case kMIDISetupFormatErr:
        print("Error: kMIDISetupFormatErr Unable to read the saved state.")
    case kMIDIWrongThread :
        print("Error: kMIDIWrongThread A driver is calling a non-I/O function in the server from a thread other than the server's main thread.")
    case kMIDIObjectNotFound:
        print("Error: kMIDIObjectNotFound The requested object does not exist.")
    case kMIDIIDNotUnique:
        print("Error: kMIDIIDNotUnique Attempt to set a non-unique kMIDIPropertyUniqueID on an object.")
    case kMIDINotPermitted:
        print( "Error: kMIDINotPermitted: The process does not have privileges for the requested operation. Audio background mode enabled?")
    case kMIDIUnknownError:
        print("Error: kMIDIUnknownError Internal error; unable to perform the requested operation.")
    // MusicPlayerErrors
    case kAudioToolboxErr_InvalidSequenceType:
        print("Error: kAudioToolboxErr_InvalidSequenceType")
    case kAudioToolboxErr_TrackIndexError:
        print("Error: kAudioToolboxErr_TrackIndexError")
    case kAudioToolboxErr_TrackNotFound:
        print("Error: kAudioToolboxErr_TrackNotFound")
    case kAudioToolboxErr_EndOfTrack:
        print("Error: kAudioToolboxErr_EndOfTrack")
    case kAudioToolboxErr_StartOfTrack:
        print("Error: kAudioToolboxErr_StartOfTrack")
    case kAudioToolboxErr_IllegalTrackDestination:
        print("Error: kAudioToolboxErr_IllegalTrackDestination")
    case kAudioToolboxErr_NoSequence:
        print("Error: kAudioToolboxErr_NoSequence")
    case kAudioToolboxErr_InvalidEventType:
        print("Error: kAudioToolboxErr_InvalidEventType")
    case kAudioToolboxErr_InvalidPlayerState:
        print("Error: kAudioToolboxErr_InvalidPlayerState")
    case kAudioToolboxErr_CannotDoInCurrentContext:
        print("Error: kAudioToolboxErr_CannotDoInCurrentContext")
    // Audio unit errors: These are the various errors that can be returned by AudioUnit... API calls
    case kAudioUnitErr_InvalidProperty:
        print("Error: kAudioUnitErr_InvalidProperty The property is not supported")
    case kAudioUnitErr_InvalidParameter:
        print("Error: kAudioUnitErr_InvalidParameter The parameter is not supported")
    case kAudioUnitErr_InvalidElement:
        print("Error: kAudioUnitErr_InvalidElement The specified element is not valid")
    case kAudioUnitErr_NoConnection:
        print("Error: kAudioUnitErr_NoConnection There is no connection (generally an audio unit is asked to render but it has not input from which to gather data)")
    case kAudioUnitErr_FailedInitialization:
        print("Error: kAudioUnitErr_FailedInitialization The audio unit is unable to be initialized")
    case kAudioUnitErr_TooManyFramesToProcess:
        print("Error: kAudioUnitErr_TooManyFramesToProcess When an audio unit is initialized it has a value which specifies the max number of frames it will be asked to render at any given time. If an audio unit is asked to render more than this, this error is returned.")
    case kAudioUnitErr_InvalidFile:
        print( "Error: kAudioUnitErr_InvalidFile If an audio unit uses external files as a data source, this error is returned if a file is invalid (Apple's DLS synth returns this error)")
    case kAudioUnitErr_UnknownFileType:
        print("Error: kAudioUnitErr_UnknownFileType If an audio unit uses external files as a data source, this error is returned if a file is invalid (Apple's DLS synth returns this error)")
    case kAudioUnitErr_FileNotSpecified:
        print("Error: kAudioUnitErr_FileNotSpecified If an audio unit uses external files as a data source, this error is returned if a file hasn't been set on it (Apple's DLS synth returns this error)")
    case kAudioUnitErr_FormatNotSupported:
        print("Error: kAudioUnitErr_FormatNotSupported Returned if an input or output format is not supported")
    case kAudioUnitErr_Uninitialized:
        print("Error: kAudioUnitErr_Uninitialized Returned if an operation requires an audio unit to be initialized and it is not.")
    case kAudioUnitErr_InvalidScope:
        print("Error: kAudioUnitErr_InvalidScope The specified scope is invalid")
    case kAudioUnitErr_PropertyNotWritable:
        print("Error: kAudioUnitErr_PropertyNotWritable The property cannot be written")
    case kAudioUnitErr_CannotDoInCurrentContext:
        print("Error: kAudioUnitErr_CannotDoInCurrentContext Returned when an audio unit is in a state where it can't perform the requested action now - but it could later. Its usually used to guard a render operation when a reconfiguration of its internal state is being performed.")
    case kAudioUnitErr_InvalidPropertyValue:
        print("Error: kAudioUnitErr_InvalidPropertyValue The property is valid, but the value of the property being provided is not")
    case kAudioUnitErr_PropertyNotInUse:
        print("Error: kAudioUnitErr_PropertyNotInUse Returned when a property is valid, but it hasn't been set to a valid value at this time.")
    case kAudioUnitErr_Initialized:
        print( "Error: kAudioUnitErr_Initialized Indicates the operation cannot be performed because the audio unit is initialized.")
    case kAudioUnitErr_InvalidOfflineRender:
        print("Error: kAudioUnitErr_InvalidOfflineRender Used to indicate that the offline render operation is invalid. For instance, when the audio unit needs to be pre-flighted, but it hasn't been.")
    case kAudioUnitErr_Unauthorized:
        print("Error: kAudioUnitErr_Unauthorized Returned by either Open or Initialize, this error is used to indicate that the audio unit is not authorised, that it cannot be used. A host can then present a UI to notify the user the audio unit is not able to be used in its current state.")
    case kAudioUnitErr_MIDIOutputBufferFull:
        print("Error: kAudioUnitErr_MIDIOutputBufferFull Returned during the render call, if the audio unit produces more MIDI output, than the default allocated buffer. The audio unit can provide a size hint, in case it needs a larger buffer. See the documentation for AUAudioUnit's MIDIOutputBufferSizeHint property.")
    case kAudioComponentErr_InstanceInvalidated:
        print("Error: kAudioComponentErr_InstanceInvalidated The component instance's implementation is not available, most likely because the process that published it is no longer running.")
    case kAudioUnitErr_RenderTimeout:
        print("Error: kAudioUnitErr_RenderTimeout The audio unit did not satisfy the render request in time.")
    case kAudioUnitErr_ExtensionNotFound:
        print("Error: kAudioUnitErr_ExtensionNotFound The specified identifier did not match any Audio Unit Extensions.")
    case kAudioUnitErr_InvalidParameterValue:
        print("Error: kAudioUnitErr_InvalidParameterValue The parameter value is not supported, e.g. the value specified is NaN or infinite.")
        // AudioComponent errors for inter-app audio
    case kAudioComponentErr_DuplicateDescription:
        print("Error: kAudioComponentErr_DuplicateDescription a non-unique component description was provided to AudioOutputUnitPublish")
    case kAudioComponentErr_UnsupportedType:
        print("Error: kAudioComponentErr_UnsupportedType an unsupported component type was provided to AudioOutputUnitPublish")
    case kAudioComponentErr_TooManyInstances:
        print("Error: kAudioComponentErr_TooManyInstances components published via AudioOutputUnitPublish may only have one instance")
    case kAudioComponentErr_NotPermitted:
        print("Error: kAudioComponentErr_NotPermitted app needs 'inter-app-audio' entitlement or host app needs 'audio' in its UIBackgroundModes. Or app is trying to register a component not declared in its Info.plist.")
    case kAudioComponentErr_InitializationTimedOut:
        print("Error: kAudioComponentErr_InitializationTimedOut host did not render in a timely manner; must uninitialize and reinitialize.")
    case kAudioComponentErr_InvalidFormat:
        print("Error: kAudioComponentErr_InvalidFormat inter-app AU element formats must have sample rates matching the hardware.")
    default:
        print("Error: \(osstatus)")
    }
}

