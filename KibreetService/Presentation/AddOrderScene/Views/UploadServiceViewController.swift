//
//  UploadServiceViewController.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import UIKit
import Combine

class UploadServiceViewController: UIViewController {

    @IBOutlet weak var serviceNameHeaderLabel: UILabel!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var kilometersTF: UITextField!
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var picturesCollectionView: UICollectionView!
    @IBOutlet weak var submitButton: UIButton!
    var serviceName = ""
    var visiteId = 0
    var availabilityId = 0
    var images = [UIImage]()
    var attachments = [Attachment]()
    let picker = UIImagePickerController()
    private let submitServiceViewModel = SubmitServiceViewModel()
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionview()
        bindViewToSubmitViewModel()
        bindingViewModelToView()

    }
    
    func setupCollectionview() {
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picturesCollectionView.delegate = self
        picturesCollectionView.dataSource = self
        picturesCollectionView.register(UINib(nibName: CarImageCell.idetifier, bundle: nil), forCellWithReuseIdentifier: CarImageCell.idetifier)
        picturesCollectionView.register(UINib(nibName: SelectImageCell.idetifier, bundle: nil), forCellWithReuseIdentifier: SelectImageCell.idetifier)
    }
    
    func setupView() {
        serviceNameLabel.text = serviceName
        serviceNameHeaderLabel.text = serviceName + " " + "Service".localized()
        submitButton.layer.cornerRadius = 10
    }
    
    func bindViewToSubmitViewModel(){
        amountTF.textPublisher.sink(receiveValue: { [unowned self] text in
            submitServiceViewModel.amount.send(text)
        }).store(in: &bindings)
        kilometersTF.textPublisher.sink(receiveValue: { [unowned self] text in
            submitServiceViewModel.kilometers.send(text)
        }).store(in: &bindings)
    }
    
    func bindingViewModelToView(){
        submitServiceViewModel.result.sink(receiveCompletion: {completion in
            switch completion {
            case .failure(let error):
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: error.localizedDescription, buttonTitle: "Ok".localized())
            case .finished:
                print("SUCCESS ")
            }
        }, receiveValue: {[unowned self] value in
            self.finishSubmitting()
        }).store(in: &bindings)
        
        submitServiceViewModel.message.sink(receiveCompletion: {completion in
            switch completion {
            case .failure(let error):
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: error.localizedDescription, buttonTitle: "Ok".localized())
            case .finished:
                print("SUCCESS ")
            }
        }, receiveValue: {[unowned self] value in
            if value != nil {
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: value!, buttonTitle: "Ok".localized())
            }
        }).store(in: &bindings)
    }
    
    func finishSubmitting() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    
    
    func openCameraPicker() {
        self.present(picker, animated: true)
    }

    @IBAction func backButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func submitButtonDidPressed(_ sender: UIButton) {
        if images.count <= 0 {
            self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: "You must upload at least one photo".localized(), buttonTitle: "Ok".localized())
        } else {
            for item in images {
                if let imageData = item.jpegData(compressionQuality: 0.1) {
                    attachments.append(Attachment(data: imageData, keyName: "Images", mimeType: .image))
                } else {
                    print("Failed to convert image to data")
                }

            }
            submitServiceViewModel.submitServiceRequest(visiteId: visiteId, availabilityId: availabilityId, attachments: attachments)
        }
    }
}

extension UploadServiceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectImageCell.idetifier, for: indexPath) as? SelectImageCell else {return UICollectionViewCell()}
            cell.openCameraTapped = {[weak self] in
                self?.openCameraPicker()
            }
            return cell
        } else  {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarImageCell.idetifier, for: indexPath) as? CarImageCell else {return UICollectionViewCell()}
            cell.configureCell(image: images[indexPath.item - 1])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 94, height: 76)
    }
}


extension UploadServiceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            print("Error: could not retrieve image")
            return
        }
        
        images.append(image)
        picturesCollectionView.reloadData()
    }
}
