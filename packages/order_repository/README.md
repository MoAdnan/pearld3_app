# Order Repository

Order Repository is a Flutter package that provides a repository class responsible for handling order-related operations. It enables you to fetch orders, get new orders for pickers and checkers, save orders, retrieve order items, change item status, and retrieve images associated with items.

## Features

- Retrieve a list of orders based on provided inputs.
- Fetch new orders for pickers and checkers.
- Save orders with specified details.
- Retrieve order items with item details.
- Change the status of an item.
- Retrieve images associated with an item.

## Installation

To use the Order Repository package in your Flutter project, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  order_repository: 
    path: 
```
## Usage
```dart
import 'package:order_repository/order_repository.dart';


final orderRepository = OrderRepository();



// Retrieve a list of orders
final orders =  orderRepository.getOrders(
dbInputs: dbInputs,
token: 'your_auth_token',
baseUrl: 'your_api_base_url',
);

// Fetch a new order for a picker
final newOrderForPicker =  orderRepository.getNewOrderForPicker(
dbInputs: dbInputs,
token: 'your_auth_token',
baseUrl: 'your_api_base_url',
);

// Fetch a new order for a checker
final newOrderForChecker =  orderRepository.getNewOrderForChecker(
dbInputs: dbInputs,
token: 'your_auth_token',
baseUrl: 'your_api_base_url',
);

// Save an order
final saveOrderResult =  orderRepository.saveOrder(
dbInputs: dbInputs,
token: 'your_auth_token',
baseUrl: 'your_api_base_url',
);

// Retrieve a list of order items
final items =  orderRepository.getItems(
dbInputs: dbInputs,
token: 'your_auth_token',
baseUrl: 'your_api_base_url',
);

// Change the status of an item
final statusChangeResult =  orderRepository.changeStatus(
dbInputs: dbInputs,
token: 'your_auth_token',
baseUrl: 'your_api_base_url',
);

// Retrieve images for an item
final itemImages =  orderRepository.getImages(
itemUid: 'item_unique_id',
token: 'your_auth_token',
baseUrl: 'your_api_base_url',
);

```