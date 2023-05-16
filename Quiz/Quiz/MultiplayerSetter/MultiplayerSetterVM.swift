//
//  MultiplayerSetterVM.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/10/23.
//

import SwiftUI
import MultipeerConnectivity

final class MultiplayerSetterVM: NSObject, ObservableObject {
    
    @Published var game: MultilPlayerGameVM
    @Published var alert: AlertItem?
    @Published var enemyResult: MultiplayerResult?
    @Published var remainingTime: Double = 0
    @Published var connected = false
    
    private var didGaveUp = false
    
    var peerId: MCPeerID
    var session: MCSession
    var nearbyServiceAdvertiser: MCNearbyServiceAdvertiser?
    
    init(info: Info) {
        self.game = MultilPlayerGameVM(info: info)
        self.peerId = MCPeerID(displayName: UIDevice.current.name)
        self.session = MCSession(peer: peerId, securityIdentity: nil, encryptionPreference: .required)
        super.init()
        session.delegate = self
    }
    
    func surrender() {
        didGaveUp = true
        sendResult()
        StorageManager.shared.addResult(myResult: 0, enemyResult: 0, didWin: false, name: "Player2")
    }
    
    func sendData(data: String) {
        guard let data = data.data(using: .utf8) else { return }
        try? session.send(data, toPeers: session.connectedPeers, with: .reliable)
    }
    
    func restart() {
        session.disconnect()
        session.delegate = nil
        session = MCSession(peer: peerId, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        connected = false
    }
    
    func sendRemainingTime() {
        let data = String(game.timeDisplay)
        sendData(data: data)
    }
    
    func createResult() -> MultiplayerResult {
        return MultiplayerResult(name: UIDevice.current.name,
                                 gaveUp: didGaveUp,
                                 result: game.getResult(),
                                 time: game.timeDisplay)
    }
    
    func sendResult() {
        let data = createResult().incodeResult()
        sendData(data: data)
    }
    
    func createGame() {
        nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerId, discoveryInfo: nil, serviceType: "gt-conn4")
        nearbyServiceAdvertiser?.delegate = self
        nearbyServiceAdvertiser?.startAdvertisingPeer()
    }
    
    func jointToTheGame() {
        let browser = MCBrowserViewController(serviceType: "gt-conn4", session: session)
        browser.delegate = self
        UIApplication.shared.windows.first?.rootViewController?.present(browser, animated: true)
    }
    
    func didWin() -> Bool? {
        guard let enemyResult = enemyResult else { return nil }
        guard enemyResult.gaveUp != true else { return true }
        if enemyResult.result > game.getResult() {
            return false
        }
        else if enemyResult.result < game.getResult() {
            return true
        } else {
            if enemyResult.time > game.timeDisplay {
                return false
            }
            else {
                return true
            }
        }
    }
    
    func saveResult() {
        guard let enemyResult = enemyResult else { return surrender() }
        StorageManager.shared.addResult(myResult: game.getResult(),
                                        enemyResult: enemyResult.result,
                                        didWin: didWin() ?? true,
                                        name: enemyResult.name)
    }
    
    func goBack() {
        alert = AlertConfirmation.goBackMP
    }
}

