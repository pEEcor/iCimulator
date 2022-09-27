//
//  _FakeCaptureMetadataOutput.swift
//  iCimulator
//
//  Created by Paavo Becker on 26.03.22.
//  Copyright © 2022 Yuiga Wada. All rights reserved.
//

import Foundation
import AVFoundation

open class _FakeCaptureMetadataOutput: FakeCaptureOutput {
    
    /**
     Initializer
     */
    public override init() {
        self.metadataObjectTypes = []
    }
    
    
    /**
     @method setMetadataObjectsDelegate:queue:
     @abstract
        Sets the receiver's delegate that will accept metadata objects and dispatch queue on which the delegate will be called.
     
     @param objectsDelegate
        An object conforming to the AVCaptureMetadataOutputObjectsDelegate protocol that will receive metadata objects after they are captured.
     @param objectsCallbackQueue
        A dispatch queue on which all delegate methods will be called.
     
     @discussion
        When new metadata objects are captured in the receiver's connection, they will be vended to the delegate using the captureOutput:didOutputMetadataObjects:fromConnection: delegate method. All delegate methods will be called on the specified dispatch queue.
     
        Clients that need to minimize the chances of metadata being dropped should specify a queue on which a sufficiently small amount of processing is performed along with receiving metadata objects.
     
        A serial dispatch queue must be used to guarantee that metadata objects will be delivered in order. The objectsCallbackQueue parameter may not be NULL, except when setting the objectsDelegate to nil.
     */
    open func setMetadataObjectsDelegate(_ objectsDelegate: FakeCaptureMetadataOutputObjectsDelegate?, queue objectsCallbackQueue: DispatchQueue?) {
        
    }
    
    
    /**
     @property metadataObjectsDelegate
     @abstract
        The receiver's delegate.
     
     @discussion
        The value of this property is an object conforming to the AVCaptureMetadataOutputObjectsDelegate protocol that will receive metadata objects after they are captured. The delegate is set using the setMetadataObjectsDelegate:queue: method.
     */
    open var metadataObjectsDelegate: FakeCaptureMetadataOutputObjectsDelegate? {
        nil
    }

    
    /**
     @property metadataObjectsCallbackQueue
     @abstract
        The dispatch queue on which all metadata object delegate methods will be called.
     
     @discussion
        The value of this property is a dispatch_queue_t. The queue is set using the setMetadataObjectsDelegate:queue: method.
     */
    open var metadataObjectsCallbackQueue: DispatchQueue? {
        nil
    }

    
    /**
     @property availableMetadataObjectTypes
     @abstract
        Indicates the receiver's supported metadata object types.
     
     @discussion
        The value of this property is an NSArray of NSStrings corresponding to AVMetadataObjectType strings defined in AVMetadataObject.h -- one for each metadata object type supported by the receiver. Available metadata object types are dependent on the capabilities of the AVCaptureInputPort to which this receiver's AVCaptureConnection is connected. Clients may specify the types of objects they would like to process by calling setMetadataObjectTypes:. This property is key-value observable.
     */
    open var availableMetadataObjectTypes: [AVMetadataObject.ObjectType] {
        [.ean8, .ean13, .pdf417]
    }

    
    /**
     @property metadataObjectTypes
     @abstract
        Specifies the types of metadata objects that the receiver should present to the client.
     
     @discussion
        AVCaptureMetadataOutput may detect and emit multiple metadata object types. For apps linked before iOS 7.0, the receiver defaults to capturing face metadata objects if supported (see -availableMetadataObjectTypes). For apps linked on or after iOS 7.0, the receiver captures no metadata objects by default. -setMetadataObjectTypes: throws an NSInvalidArgumentException if any elements in the array are not present in the -availableMetadataObjectTypes array.
     */
    open var metadataObjectTypes: [AVMetadataObject.ObjectType]

    
    /**
     @property rectOfInterest
     @abstract
        Specifies a rectangle of interest for limiting the search area for visual metadata.
     
     @discussion
        The value of this property is a CGRect that determines the receiver's rectangle of interest for each frame of video. The rectangle's origin is top left and is relative to the coordinate space of the device providing the metadata. Specifying a rectOfInterest may improve detection performance for certain types of metadata. The default value of this property is the value CGRectMake(0, 0, 1, 1). Metadata objects whose bounds do not intersect with the rectOfInterest will not be returned.
     
        As of iOS 13, this property can be set without requiring a lengthy rebuild of the session in which video preview is disrupted.
     */
    @available(iOS 7.0, *)
    open var rectOfInterest: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
}

/**
 @protocol AVCaptureMetadataOutputObjectsDelegate
 @abstract
    Defines an interface for delegates of AVCaptureMetadataOutput to receive emitted objects.
 */
@available(iOS 6.0, *)
public protocol FakeCaptureMetadataOutputObjectsDelegate : NSObjectProtocol {

    
    /**
     @method captureOutput:didOutputMetadataObjects:fromConnection:
     @abstract
        Called whenever an AVCaptureMetadataOutput instance emits new objects through a connection.
     
     @param output
        The AVCaptureMetadataOutput instance that emitted the objects.
     @param metadataObjects
        An array of AVMetadataObject subclasses (see AVMetadataObject.h).
     @param connection
        The AVCaptureConnection through which the objects were emitted.
     
     @discussion
        Delegates receive this message whenever the output captures and emits new objects, as specified by its metadataObjectTypes property. Delegates can use the provided objects in conjunction with other APIs for further processing. This method will be called on the dispatch queue specified by the output's metadataObjectsCallbackQueue property. This method may be called frequently, so it must be efficient to prevent capture performance problems, including dropped metadata objects.
     
        Clients that need to reference metadata objects outside of the scope of this method must retain them and then release them when they are finished with them.
     */
    func metadataOutput(_ output: FakeCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: FakeCaptureConnection)
}
