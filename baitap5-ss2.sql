create database baitap5;
use baitap5;

create table customers (
	customer_id int primary key,
    fullName varchar(100) not null,
    email varchar(50) not null
);

create table wallets (
	wallet_id int primary key,
    customer_id int not null unique,
    balance decimal(18,2) not null check (balance >= 0),
    created_at datetime default current_timestamp,
    
    constraint fk_wallet_customer
		foreign key (customer_id)
        references customers(customer_id)
);

create table transactions (
	transaction_id bigint primary key, 
    
    wallet_id int not null,
    
    transaction_type varchar(30) not null check (transaction_type in ('Deposit','Withdraw', 'Payment')),
    amount decimal(18,2) not null check (amount > 0),
    transaction_time datetime default current_timestamp,
    
    status varchar(30) not null default 'pending' check( status in ('Pending', 'Success', 'failed')),
    
    constraint fk_transaction_wallet
		foreign key (wallet_id)
        references wallets(wallet_id)
);