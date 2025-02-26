#!/bin/bash

CHANNEL_NAME=mychannel
CHAINCODE_NAME=token
CHAINCODE_VERSION=1.0
CHAINCODE_PATH=./../chaincode
FABRIC_SAMPLES=/workspaces/npci-blockchain-assignment-7-drupadhdinesh/fabric-samples

export PATH=${FABRIC_SAMPLES}/bin:$PATH
export FABRIC_CFG_PATH=${FABRIC_SAMPLES}/config

# Set the environment variables for Org1
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_MSPCONFIGPATH=${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:7051
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_TLS_ROOTCERT_FILE=${FABRIC_SAMPLES}/test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt

# Query Token admin balance
echo "Admin Balance : "
peer chaincode query -C mychannel -n token -c '{"Args":["GetBalance", "eDUwOTo6Q049QWRtaW5Ab3JnMS5leGFtcGxlLmNvbSxPVT1hZG1pbixMPVNhbiBGcmFuY2lzY28sU1Q9Q2FsaWZvcm5pYSxDPVVTOjpDTj1jYS5vcmcxLmV4YW1wbGUuY29tLE89b3JnMS5leGFtcGxlLmNvbSxMPVNhbiBGcmFuY2lzY28sU1Q9Q2FsaWZvcm5pYSxDPVVT"]}'

# Query User1 balance
echo "User1 Balance : "
peer chaincode query -C mychannel -n token -c '{"Args":["GetBalance", "eDUwOTo6Q049VXNlcjFAb3JnMS5leGFtcGxlLmNvbSxPVT1jbGllbnQsTD1TYW4gRnJhbmNpc2NvLFNUPUNhbGlmb3JuaWEsQz1VUzo6Q049Y2Eub3JnMS5leGFtcGxlLmNvbSxPPW9yZzEuZXhhbXBsZS5jb20sTD1TYW4gRnJhbmNpc2NvLFNUPUNhbGlmb3JuaWEsQz1VUw=="]}'