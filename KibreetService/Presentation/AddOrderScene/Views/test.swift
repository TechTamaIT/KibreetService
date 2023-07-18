//
//  test.swift
//  KibreetService
//
//  Created by Essam Orabi on 18/07/2023.
//

import UIKit
import CoreNFC

class NFCViewController: UIViewController, NFCNDEFWriterSessionDelegate {

    // Create a text field for the user to enter the data to be written to the NFC tag
    let dataTextField: UITextField = UITextField()

    // Cre ate a button to start the NFC write session
    let writeButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the text field and button
        dataTextField.placeholder = "Enter data to write to NFC tag"
        writeButton.setTitle("Write to NFC tag", for: .normal)
        writeButton.addTarget(self, action: #selector(startWriteSession), for: .touchUpInside)
    }

    // Start the NFC write session when the button is tapped
    @objc func startWriteSession() {
        // Get the data from the text field
        let data = dataTextField.text!.data(using: .utf8)

        // Create an NFC NDEF message with the data
            let ndefMessage = NFCNDEFMessage(records: [NFCNDEFPayload.wellKnownTypeURIPayload(data!)])

        // Create an NFC write session
        let nfcSession = NFCNDEFWriterSession(delegate: self, queue: nil, invalidateAfterFirstWrite: true)

        // Start the write session
        nfcSession.begin(message: ndefMessage, completionHandler: { (error: Error?) in
            if let error = error {
                // Handle the error
                print("Error writing to NFC tag: \(error)")
            } else {
                // Writing to the NFC tag was successful
                print("Successfully wrote to NFC tag")
            }
        })
    }

    // Implement the required NFCNDEFWriterSessionDelegate method
    func writerSession(_ session: NFCNDEFWriterSession, didDetect tags: [NFCNDEFTag]) {
        // An NFC tag has been detected, so you can write the data to it here

        // Get the first tag from the array
        let tag = tags[0]

        // Write the data to the tag
        session.connect(to: tag) { (error: Error?) in
            if let error = error {
                // Handle the error
                print("Error connecting to NFC tag: \(error)")
            } else {
                // Connecting to the NFC tag was successful
                session.writeNDEF(session.message, completionHandler: { (error: Error?) in
                    if let error = error {
                        // Handle the error
                        print("Error writing to NFC tag: \(error)")
                    } else {
                        // Writing to the NFC tag was successful
                        print("Successfully wrote to NFC tag")
                    }
                })
            }
        }
    }
}
