//
//  AddNewWastePresenter.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 15/10/20.
//

import Foundation

protocol AddNewWasteDelegate {
    func addWasteSuccess(wasteAdded: [WasteAdded])
    func addWasteError(err: Error)
}

class AddNewWastePresenter {
    private var delegate: AddNewWasteDelegate
    private var listSelectedWaste = [WasteAdded]()
    
    init(delegate: AddNewWasteDelegate) {
        self.delegate = delegate
    }
    
    func addWaste(selectedWaste: Waste, numOfWaste: Int) {
        let wasteAdded = WasteAdded(waste: selectedWaste, numOfWaste: numOfWaste)
        listSelectedWaste.append(wasteAdded)
        delegate.addWasteSuccess(wasteAdded: listSelectedWaste)
    }
}
