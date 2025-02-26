package main

import (
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

const (
	maxSupply int = 200_000_000
)

type Token struct {
	Name        string `json:"name"`
	Symbol      string `json:"symbol"`
	Decimals    int    `json:"decimals"`
	TotalSupply int    `json:"totalSupply"`
}

type TokenContract struct {
	contractapi.Contract
}

type Balance struct {
	Balance int `json:"balance"`
}

func (s *TokenContract) InitLedger(ctx contractapi.TransactionContextInterface) error {

	clientId, _ := ctx.GetClientIdentity().GetID()
	fmt.Printf("clientId: %v\n", clientId)

	existingToken, _ := s.getToken(ctx)
	if existingToken != nil {
		return fmt.Errorf("token already initialized")
	}

	callerID, err := ctx.GetClientIdentity().GetID()
	if err != nil {
		return fmt.Errorf("failed to get caller ID: %v", err)
	}

	admin := struct{ ID string }{callerID}
	adminBytes, _ := json.Marshal(admin)
	ctx.GetStub().PutState("admin", adminBytes)

	token := &Token{
		Name:        "BNB-Token",
		Symbol:      "BNB",
		Decimals:    18,
		TotalSupply: 0,
	}
	return s.saveToken(ctx, token)
}

func (s *TokenContract) MintTokens(ctx contractapi.TransactionContextInterface, amount int) error {
	admin, err := s.getAdmin(ctx)
	if err != nil {
		return err
	}

	if !s.isAdmin(ctx, admin.ID) {
		return fmt.Errorf("only admin can mint")
	}

	token, _ := s.getToken(ctx)
	token.TotalSupply += amount

	if token.TotalSupply > maxSupply {
		return fmt.Errorf("total token is supply exceeding the maxSupply of 200_000_000")
	}

	err = s.saveToken(ctx, token)
	if err != nil {
		return err
	}

	err = s.updateBalance(ctx, admin.ID, amount)
	if err != nil {
		return err
	}
	return nil
}

func (s *TokenContract) TransferTokens(ctx contractapi.TransactionContextInterface, to string, amount int) error {
	from, _ := ctx.GetClientIdentity().GetID()

	if s.getBalance(ctx, from) < amount {
		return fmt.Errorf("insufficient balance")
	}

	err := s.updateBalance(ctx, from, -amount)
	if err != nil {
		return err
	}
	err = s.updateBalance(ctx, to, amount)
	if err != nil {
		return err
	}
	return nil
}

func (s *TokenContract) GetBalance(ctx contractapi.TransactionContextInterface, address string) (int, error) {
	return s.getBalance(ctx, address), nil
}

func (s *TokenContract) ApproveSpender(ctx contractapi.TransactionContextInterface, spender string, amount int) error {
	owner, _ := ctx.GetClientIdentity().GetID()
	key, _ := ctx.GetStub().CreateCompositeKey("allowance", []string{owner, spender})
	return ctx.GetStub().PutState(key, []byte(fmt.Sprintf("%d", amount)))
}

func (s *TokenContract) TransferFrom(ctx contractapi.TransactionContextInterface, from, to string, amount int) error {
	spender, _ := ctx.GetClientIdentity().GetID()

	allowance := s.getAllowance(ctx, from, spender)
	if allowance < amount {
		return fmt.Errorf("exceeds allowance")
	}

	if s.getBalance(ctx, from) < amount {
		return fmt.Errorf("insufficient balance")
	}

	err := s.updateAllowance(ctx, from, spender, -amount)
	if err != nil {
		return err
	}
	err = s.updateBalance(ctx, from, -amount)
	if err != nil {
		return err
	}
	err = s.updateBalance(ctx, to, amount)
	if err != nil {
		return err
	}
	return nil
}

// Admin burns tokens
func (s *TokenContract) BurnTokens(ctx contractapi.TransactionContextInterface, amount int) error {
	admin, err := s.getAdmin(ctx)
	if err != nil {
		return err
	}

	if !s.isAdmin(ctx, admin.ID) {
		return fmt.Errorf("only admin can burn")
	}

	if s.getBalance(ctx, admin.ID) < amount {
		return fmt.Errorf("insufficient balance")
	}

	token, err := s.getToken(ctx)
	if err != nil {
		return err
	}
	token.TotalSupply -= amount
	err = s.saveToken(ctx, token)
	if err != nil {
		return err
	}

	err = s.updateBalance(ctx, admin.ID, -amount)
	if err != nil {
		return err
	}
	return nil
}

func main() {
	chaincode, err := contractapi.NewChaincode(&TokenContract{})
	if err != nil {
		fmt.Printf("Error creating chaincode: %v", err)
		return
	}

	if err := chaincode.Start(); err != nil {
		fmt.Printf("Error starting chaincode: %v", err)
	}
}
