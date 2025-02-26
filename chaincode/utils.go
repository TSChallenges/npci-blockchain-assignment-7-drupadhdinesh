package main

import (
	"encoding/json"
	"fmt"
	"strconv"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

// Helper functions
func (s *TokenContract) getToken(ctx contractapi.TransactionContextInterface) (*Token, error) {
	tokenBytes, _ := ctx.GetStub().GetState("token")
	if tokenBytes == nil {
		return nil, fmt.Errorf("token not initialized")
	}
	token := new(Token)
	json.Unmarshal(tokenBytes, token)
	return token, nil
}

func (s *TokenContract) saveToken(ctx contractapi.TransactionContextInterface, token *Token) error {
	tokenBytes, err := json.Marshal(token)
	if err != nil {
		return err
	}
	return ctx.GetStub().PutState("token", tokenBytes)
}

func (s *TokenContract) getAdmin(ctx contractapi.TransactionContextInterface) (struct{ ID string }, error) {
	admin := struct{ ID string }{}
	adminBytes, err := ctx.GetStub().GetState("admin")
	if err != nil {
		return admin, err
	}
	json.Unmarshal(adminBytes, &admin)
	return admin, nil
}

func (s *TokenContract) isAdmin(ctx contractapi.TransactionContextInterface, id string) bool {
	callerID, _ := ctx.GetClientIdentity().GetID()
	return callerID == id
}

func (s *TokenContract) getBalance(ctx contractapi.TransactionContextInterface, address string) int {
	balanceBytes, _ := ctx.GetStub().GetState("balance_" + address)
	if balanceBytes == nil {
		return 0
	}
	var balance Balance
	json.Unmarshal(balanceBytes, &balance)
	return balance.Balance
}

func (s *TokenContract) updateBalance(ctx contractapi.TransactionContextInterface, address string, delta int) error {
	balance := s.getBalance(ctx, address) + delta
	balanceBytes, _ := json.Marshal(Balance{balance})
	return ctx.GetStub().PutState("balance_"+address, balanceBytes)
}

func (s *TokenContract) getAllowance(ctx contractapi.TransactionContextInterface, owner, spender string) int {
	key, _ := ctx.GetStub().CreateCompositeKey("allowance", []string{owner, spender})
	allowanceBytes, _ := ctx.GetStub().GetState(key)
	if allowanceBytes == nil {
		return 0
	}
	amount, err := strconv.Atoi(string(allowanceBytes))
	if err != nil {
		return 0
	}
	return amount
}

func (s *TokenContract) updateAllowance(ctx contractapi.TransactionContextInterface, owner, spender string, delta int) error {
	key, _ := ctx.GetStub().CreateCompositeKey("allowance", []string{owner, spender})
	current := s.getAllowance(ctx, owner, spender)
	return ctx.GetStub().PutState(key, []byte(fmt.Sprintf("%d", current+delta)))
}
