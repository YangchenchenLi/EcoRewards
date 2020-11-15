//
//  ViewController.swift
//  QRtest
//
//  Created by Yiwei Gao on 2020/9/2.
//  Copyright © 2020 YiweiGao. All rights reserved.
//  Adopted from code by the 抢手的哥
//  Source: https://www.jianshu.com/p/e16a4380d7b2

import UIKit

import AVFoundation

class QRScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {


    
    @IBOutlet weak var productInfo: UITextField!
    //captureSession to connects input and output
    fileprivate var captureSession = AVCaptureSession()
    // provide the preview layer
    fileprivate var videoPreviewLayer = AVCaptureVideoPreviewLayer()
    fileprivate var qrCodeFrameView = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        captureSession.startRunning()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false

        let captureDevice = AVCaptureDevice.default(for: .video)!

        do {
            //set the captured session to the  input of the capute Session
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            // captured data
            let captureMetadataOutput = AVCaptureMetadataOutput()
            // put the captured data as the output of the captureSession
            captureSession.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            // set the tyoe of output to the qr code
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
         
            // set the captured data to the preview layer
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer.frame = view.layer.bounds
            videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            view.layer.addSublayer(videoPreviewLayer)
            captureSession.startRunning()

            // set the frame of qrcode
            qrCodeFrameView.layer.borderWidth = 2
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor //QR code green frame
            
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)

        } catch {
            print(error)
        }
    }

// capture the data contained in the qr code

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView.frame = CGRect.zero
            
            return
        }
        
        let metadata = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metadata.type == AVMetadataObject.ObjectType.qr {
            let barCodeObject = videoPreviewLayer.transformedMetadataObject(for: metadata)

            qrCodeFrameView.frame = barCodeObject!.bounds

            if let value = metadata.stringValue {

                if value.hasPrefix("http") {
                    captureSession.stopRunning()
                    performSegue(withIdentifier: "webview", sender: value)
                }else{
                    captureSession.stopRunning()
                    performSegue(withIdentifier: "text", sender: value)
                }
            }
        }
    }
    
    // if the data is the url, turn to the webview page, otherwise, turn to the text view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let str = sender as? NSString
        
        if str!.hasPrefix("http") {
            let webviewVC = segue.destination as! WebViewCtrl
            webviewVC.url = sender as? NSString
        }else{
            let webviewVC = segue.destination as! TextViewCtrl
            webviewVC.text = sender as? NSString
        }
    }
}



