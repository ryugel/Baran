# Baran

Baran is a mobile application that allows you to browse and discover movies and TV shows using the TMDb (The Movie Database) API and watch trailers on YouTube. This application is designed as a clone of Netflix, offering a similar browsing experience while utilizing modern technologies for design and data storage.

## ScreenRecord
https://github.com/ryugel/Baran/assets/69274926/f13aec44-85fb-4672-9a6f-835092508abc

## Screenshots
| Screenshot 1 | Screenshot 2 | Screenshot 3 | Screenshot 4 | Screenshot 5 | Screenshot 6 |
|--------------|--------------|--------------|--------------|--------------|--------------|
| ![Screenshot 1](https://github.com/ryugel/Baran/assets/69274926/82049d20-83ee-4b14-b06b-e861db807a79) | ![Screenshot 2](https://github.com/ryugel/Baran/assets/69274926/95532316-c8ed-4175-9d29-953b697ecf0e) | ![Screenshot 3](https://github.com/ryugel/Baran/assets/69274926/be57bb24-5a3a-4c61-b741-351affb69fda) | ![Screenshot 4](https://github.com/ryugel/Baran/assets/69274926/c1778105-b15c-4e2b-980b-30ca2cd8f4f5) | ![Screenshot 5](https://github.com/ryugel/Baran/assets/69274926/1c9681d1-0ec8-4092-8084-0ffca17520e0) | ![Screenshot 6](https://github.com/ryugel/Baran/assets/69274926/e291faad-ca61-4af0-aec6-b07263bdcfe8) |

## Features

- Browse popular movies and TV shows, current trends, and new releases.
- Search for specific movies and TV shows.
- Watch trailers on YouTube directly from the app.
- User authentication via Firebase.
- User favorites storage on Firebase.

## Prerequisites

- iOS 17.0 or later.
- An internet connection to access data and watch trailers.
- Environment variables:
  - **MOVIEDB_API_KEY**: Set this environment variable with your TMDb API key.
  - **YOUTUBE_API_KEY**: Set this environment variable with your YouTube API key.

## Technologies Used

- SwiftUI: For designing the user interface.
- NukeUI: For loading and caching images from the TMDb API.
- Firebase: For user authentication and data storage.
- TMDb API: For getting information about movies and TV shows.
- YouTube API: For watching trailers directly from the app.

## Installation

1. Clone this repository to your local machine.
2. Open the project in Xcode.
3. Make sure you have set up Firebase in your project and added the necessary configuration files.
4. Set the `MOVIEDB_API_KEY` and `YOUTUBE_API_KEY` environment variables in your project settings.
5. Build and run the application on your iOS simulator or device.

## Firebase Configuration

Make sure you have set up Firebase in your Xcode project. You will need to add the configuration files provided by Firebase to your project.


## Contributions

Contributions are welcome! If you'd like to contribute to this project, please open an issue to discuss the changes you'd like to make.

## Authors

This project was developed by ryugel.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.


