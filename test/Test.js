var sushiOrder = artifacts.require('sushiOrder');

contract('sushiOrder', function(accounts) {

	var seller = accounts[0];
	var customer = accounts[1];	
	var orderID = 1;
	var price = web3.utils.toWei('5', 'ether');
	var sushiName = "California roll";
	var orderDate = (new Date()).getTime();


	it("The restaurant account owns the contract.", function(){

		return sushiOrder.new(customer, {from: seller}).then(function(contract){
			return contract.owner();
		}).then(function(owner){
			assert.equal(seller, owner, "The restaurant account does not own the contract.");
		});

	});


	it("The customer account is the second account.", function(){

		return sushiOrder.new(customer, {from: seller}).then(function(contract){
			return contract.customer();
		}).then(function(customer){
			assert.equal(accounts[1], customer, "The second account is not the customer.");
		});

	});


	it("Funds transfered from contract to owner after the order is completed.", function(){

		var contract;

		return sushiOrder.new(customer, {from: seller}).then(function(_contract){
			contract = _contract;

			return contract.orderSushi(sushiName, {from: customer});
		}).then(function(){
			return contract.sendPrice(orderID, price, {from: seller});
		}).then(function(){
			return contract.sendPayment(orderID, {from: customer, value: price});
		}).then(function(){
			return contract.confirmPayment(orderID, orderDate, {from: seller});
		}).then(function(){
			return contract.completeOrder(orderID, (new Date()).getTime(), {from: customer});	// ID, delivery date
		}).then(function(){
		return new Promise(function(resolve, reject){
			return web3.eth.getBalance(contract.address, function(err, hash){
				if(err){
					reject(err);
				}
					resolve(hash);
				});
			});
		}).then(function(balance){
			assert.equal(balance.toString(), 0);
		});
	});

});