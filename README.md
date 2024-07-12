# Tezda Shop

Tezda Shop is a mobile e-commerce application developed as part of an immersive commerce project on Web 3.0. This app allows users to browse and view product listings from a decentralized marketplace, with features such as user authentication, product details, and user-specific functionalities like marking products as favorites.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Dependencies](#dependencies)
- [Installation](#installation)
- [Usage](#usage)
- [API](#api)
- [Screenshots](#screenshots)

## Features

- **Product Listing**: Displays a list of products fetched from the Fake API.
- **Product Details**: Shows additional information about the selected product.
- **User Authentication**: Allows users to register, login, and maintain session.
- **Favorites**: Users can mark products as favorites.
- **Profile Management**: Users can view and update their personal information.
- **Pagination**: Efficiently fetches and displays data with pagination support.

## Architecture

The application follows the MVC (Model-View-Controller) architecture pattern:

- **Models**: Represents the data and business logic of the application.
- **Views**: UI components that display the data to the user.
- **Controllers**: Intermediaries that handle user input, manipulate data models, and update views.

## Dependencies

The project utilizes the following dependencies:

- **auto_route**: ^8.2.0 (Routing)
- **cupertino_icons**: ^1.0.6
- **dio**: ^5.5.0+1 (HTTP client)
- **fancy_shimmer_image**: ^2.0.3 (Image loading)
- **flutter_dotenv**: ^5.1.0 (Environment variables)
- **flutter_riverpod**: ^2.5.1 (State management)
- **flutter_svg**: ^2.0.10+1 (SVG rendering)
- **freezed_annotation**: ^2.4.3 (Code generation)
- **get_it**: ^7.7.0 (Dependency injection)
- **image_picker**: ^1.1.2 (Image picking)
- **injectable**: ^2.4.2 (Dependency injection)
- **json_annotation**: ^4.9.0 (JSON serialization)
- **riverpod_annotation**: ^2.3.5 (State management)
- **shared_preferences**: ^2.2.3 (Local storage)
- **toastification**: ^2.0.0 (Toast notifications)

## Installation

To get started with the project, follow these steps:

2. Clone the code:
   ```bash
   $ git clone https://github.com/yourusername/tezda_shop.git
   $ cd tezda_shop
    ```

2. Run the following commands:
   ```bash
   $ make get
   $ make codegen
    ```
3. Run app:
   ```bash
   $ flutter run
    ```

## Usage

- **Product Listing Screen**: 
  - Browse the list of products fetched from the Fake API.
  - Tap on a product to navigate to its detailed view.

- **Product Details Screen**:
  - View additional product information including description and user reviews.

- **User Authentication**:
  - Register a new account or log in with existing credentials.
  - Maintain user session until explicitly logged out or session expiration.

- **Favorites**:
  - Mark products as favorites by tapping on the heart icon.

- **Profile Management**:
  - Update personal information such as name, email, and profile picture from the profile screen.

## API

The app fetches product data from the Fake API provided by Platzi:
- [Fake API](https://fakeapi.platzi.com/)

## Screenshots
Include screenshots of your application to showcase its features and UI.

  
************               |  **********               | **********         
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/JustineUgo/tezda_shop/blob/master/assets/images/1.jpg)|![](https://github.com/JustineUgo/tezda_shop/blob/master/assets/images/2.jpg)|![](https://github.com/JustineUgo/tezda_shop/blob/master/assets/images/3.jpg)|

  
************               |  **********               | **********         
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/JustineUgo/tezda_shop/blob/master/assets/images/4.jpg)|![](https://github.com/JustineUgo/tezda_shop/blob/master/assets/images/5.jpg)|![](https://github.com/JustineUgo/tezda_shop/blob/master/assets/images/6.jpg)|


  
************               |  **********               | **********         
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/JustineUgo/tezda_shop/blob/master/assets/images/7.jpg)|![](https://github.com/JustineUgo/tezda_shop/blob/master/assets/images/8.jpg)|![](https://github.com/JustineUgo/tezda_shop/blob/master/assets/images/9.jpg)|


  
************               |  **********               | **********         
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/JustineUgo/tezda_shop/blob/master/assets/images/10.jpg)|![](https://github.com/JustineUgo/tezda_shop/blob/master/assets/images/11.jpg)|![](https://github.com/JustineUgo/tezda_shop/blob/master/assets/images/12.jpg)|


  
************               |  **********               |  **********               |  **********                        
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/JustineUgo/tezda_shop/blob/master/assets/images/13.jpg)|![](https://github.com/JustineUgo/tezda_shop/blob/master/assets/images/14.jpg)|![](https://github.com/JustineUgo/tezda_shop/blob/master/assets/images/15.jpg)|![](https://github.com/JustineUgo/tezda_shop/blob/master/assets/images/16.jpg)|




