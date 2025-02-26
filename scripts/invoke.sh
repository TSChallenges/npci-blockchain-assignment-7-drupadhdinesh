#!/bin/bash

CHANNEL_NAME=mychannel
CHAINCODE_NAME=token
CHAINCODE_VERSION=1.0
CHAINCODE_PATH=./../chaincode
FABRIC_SAMPLES=/workspaces/npci-blockchain-assignment-7-drupadhdinesh/fabric-samples

export PATH=${FABRIC_SAMPLES}/bin:$PATH
export FABRIC_CFG_PATH=${FABRIC_SAMPLES}/config

# Set the environment variables for Org1
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_ADDRESS=localhost:7051
export CORE_PEER_TLS_ROOTCERT_FILE=${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt

# Init Ledger
# export CORE_PEER_MSPCONFIGPATH=${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
# peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${FABRIC_SAMPLES}/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n token --peerAddresses localhost:7051 --tlsRootCertFiles "${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"InitLedger","Args":[]}'

# Invoke minting
# export CORE_PEER_MSPCONFIGPATH=${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
# peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${FABRIC_SAMPLES}/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n token --peerAddresses localhost:7051 --tlsRootCertFiles "${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"MintTokens","Args":["10000"]}'

# Invoke transfer tokens
# export CORE_PEER_MSPCONFIGPATH=${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
# peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${FABRIC_SAMPLES}/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n token --peerAddresses localhost:7051 --tlsRootCertFiles "${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"TransferTokens","Args":["eDUwOTo6Q049VXNlcjFAb3JnMS5leGFtcGxlLmNvbSxPVT1jbGllbnQsTD1TYW4gRnJhbmNpc2NvLFNUPUNhbGlmb3JuaWEsQz1VUzo6Q049Y2Eub3JnMS5leGFtcGxlLmNvbSxPPW9yZzEuZXhhbXBsZS5jb20sTD1TYW4gRnJhbmNpc2NvLFNUPUNhbGlmb3JuaWEsQz1VUw==", "100"]}'

# Invoke approve spender
# export CORE_PEER_MSPCONFIGPATH=${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp
# peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${FABRIC_SAMPLES}/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n token --peerAddresses localhost:7051 --tlsRootCertFiles "${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"ApproveSpender","Args":["eDUwOTo6Q049VXNlcjFAb3JnMS5leGFtcGxlLmNvbSxPVT1jbGllbnQsTD1TYW4gRnJhbmNpc2NvLFNUPUNhbGlmb3JuaWEsQz1VUzo6Q049Y2Eub3JnMS5leGFtcGxlLmNvbSxPPW9yZzEuZXhhbXBsZS5jb20sTD1TYW4gRnJhbmNpc2NvLFNbeicdbGlmb3JuaWEsQz1VUw==", "50"]}'

# Invoke burn token
# export CORE_PEER_MSPCONFIGPATH=${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
# peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${FABRIC_SAMPLES}/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n token --peerAddresses localhost:7051 --tlsRootCertFiles "${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"BurnTokens","Args":["9400"]}'