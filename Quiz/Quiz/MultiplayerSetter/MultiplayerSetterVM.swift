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
        if enemyResult == nil {
            enemyResult = MultiplayerResult(name: "Winner", gaveUp: false, result: 0, time: 120)
        }
        restart()
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
    
    func goBack() {
        alert = AlertConfirmation.goBackMP
    }
}

