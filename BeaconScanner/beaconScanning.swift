//
//  beaconScanning.swift
//  BeaconScanner
//
//  Created by Christian Aldrich Darrien on 15/05/24.
//

import SwiftUI
import CoreBluetooth

struct beaconScanning: View {
    
    @StateObject private var beaconScanningClassCall = beaconScanningClass()
    
    var body: some View {
        Text("List of scanned devices")
            .font(.largeTitle)
            .underline(color : .red)
        
        List(beaconScanningClassCall.discoveredBeacons, id: \.identifier){ beacon in
            
            Text(beacon.name ?? beacon.identifier.uuidString)
            
        }
    }
}

class beaconScanningClass: NSObject, ObservableObject, CBCentralManagerDelegate{
    
    var centralManager : CBCentralManager!
    @Published var discoveredBeacons : [CBPeripheral] = []
    
    override init(){
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central : CBCentralManager){
        
        if central.state == .poweredOn {
            startScanning()
        }else{
            stopScanning()
        }
    }
    
    func startScanning(){
        guard let centralManager = centralManager else {
            return
        }
        
        if centralManager.state == .poweredOn{
            let uuids : [CBUUID] = []
            
            let options = [CBCentralManagerScanOptionAllowDuplicatesKey : true]
            
            centralManager.scanForPeripherals(withServices: uuids, options: options)
        }
    }
    
    func stopScanning(){
        centralManager.stopScan()
    }
    
    func centralManager(_ central : CBCentralManager, didDiscover peripheral : CBPeripheral, advertisementData adivertisementData : [String : Any], rssi RSSI : NSNumber){
        
        if !discoveredBeacons.contains(peripheral){
            if RSSI.intValue > -40 {
                discoveredBeacons.append(peripheral)
            }
        }
    }
    
    
}



#Preview {
    beaconScanning()
}
