// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract sushiOrder {

 	address payable public owner;
	address public customer;
	

	struct Order {
		uint ID;
		string sushiName;	
		uint price;
		uint paymentAmount;
		uint orderDate;
		uint deliveryDate;
		bool created;	
		bool paid;		
	}
	

	mapping (uint => Order) orders;		// list of orders	
	uint orderIndex;

	
	event newOrder(address customer, string sushiName, uint orderID);
	event priceSent(address customer, uint orderID, uint price);
	event paymentSent(address customer, uint orderID, uint value, uint now);
	event paymentConfirmed(address customer, uint orderID, uint delivery_date);
	event orderCompleted(address customer, uint orderID, uint real_delivey_date);


	modifier onlyCustomer() {
        require(msg.sender == customer, "Only the buyer can call this function");
        _;
    }


	modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
	

	// constructor
	constructor(address customerAddress) payable {		
		owner = payable(msg.sender);
		customer = customerAddress;
	}


	function orderSushi(string memory sushiName) payable public onlyCustomer {		

		//require(msg.sender == customer);

		orderIndex++;
		orders[orderIndex] = Order(orderIndex, sushiName, 0, 0, 0, 0, true, false);	// ID, name, price, payment amount, orderdate, delivery date, created, paid
		
		emit newOrder(msg.sender, sushiName, orderIndex);
	}


	function sendPrice(uint orderID, uint price) payable public onlyOwner {	

		//require(msg.sender == owner);			// only owner
		require(orders[orderID].created);		// order exists
		
		orders[orderID].price = price;			// set price
		
		emit priceSent(customer, orderID, price);
	}


	function sendPayment(uint orderID) payable public onlyCustomer {

		//require(customer == msg.sender);		// only customer
		require(orders[orderID].created);		// order exists			

		orders[orderID].paymentAmount = msg.value;	// set payment amount

		emit paymentSent(msg.sender, orderID, msg.value, block.timestamp);
	}
	

	function confirmPayment(uint orderID, uint order_date) payable public onlyOwner {

		//require(owner == msg.sender);			// only owner
		require(orders[orderID].created);		// order exists

		orders[orderID].orderDate = order_date;	// order date

		orders[orderID].paid=true;				// set to paid
		
		emit paymentConfirmed(customer, orderID, order_date);
	}
	

	function completeOrder(uint orderID, uint delivery_date) payable public onlyCustomer {

		//require(customer == msg.sender);		// only customer

		orders[orderID].deliveryDate = delivery_date;

		emit orderCompleted(customer, orderID, delivery_date);
		
		owner.transfer(orders[orderID].paymentAmount);		// transfer payment amount to owner
	}

}