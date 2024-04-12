
# Flutter Iris Prediction App

The Flutter Iris Prediction App is a mobile application built with Flutter for the frontend and Flask for the backend. This app predicts the species of an iris flower based on input measurements using a machine learning model hosted on a Flask server.


## Usage

Flutter App Setup

1. Clone the repository for the Flutter app:
```ruby
git clone https://github.com/deep200315/Iris-Prediction.git
```
2. Navigate to the project directory:
```ruby
cd flutter-iris-prediction-app
```
3. Install Flutter dependencies:

```ruby
flutter pub get
```
4. Run the Flutter app:
```ruby
flutter Run
```

Flask Backend Setup

1. Clone the repository for the Flask backend:
```ruby
git clone https://github.com/deep200315/flask-iris-prediction-backend.git

```
2. Navigate to the Flask project directory:
```ruby
cd flask-iris-prediction-backend

```
3. Create a virtual environment (optional but recommended):
```ruby
python -m venv venv
source venv/bin/activate   # For Unix/Linux
# or
venv\Scripts\activate       # For Windows

```
4. Install Flask and required Python packages:
```ruby
pip install -r requirements.txt

```

5. Run the Flask server:
```ruby
python iris_api.py
```

## Using

1.Ensure both the Flutter app and Flask backend are running.

2.Open the Flutter app on an emulator or physical device.

3.Enter the values for sepal length, sepal width, petal length, and petal width into the input fields.

4.Press the "Predict" button to send the input measurements to the Flask backend.

5.View the predicted iris species returned by the backend on the Flutter app interface.

## Screenshots

![Screenshot 2024-04-12 204046](https://github.com/deep200315/Iris-Prediction/assets/124486732/51faca7a-fced-44a2-a4c7-45d7c253e717)


![Screenshot 2024-04-12 204131](https://github.com/deep200315/Iris-Prediction/assets/124486732/94fd7062-de9a-4b64-a9d3-48551f131069)


![Screenshot 2024-04-12 204152](https://github.com/deep200315/Iris-Prediction/assets/124486732/731ad74d-2f6e-45fb-a124-4fce8284a6cf)

## Project Structure
`Iris-Prediction`: Contains the Flutter mobile app frontend.
`flask-iris-prediction-backend`: Contains the Flask backend server.


## Dependencies

### Flutter App

`Flutter`: Framework for building native applications using Dart.
`http`: Dart package for making HTTP requests to the backend.

### Flask Backend

`Flask`: Web framework used for building the backend server.
`scikit-learn`: Library for machine learning tasks in Python.


## Acknowledgments

This app was inspired by the classic Iris dataset and demonstrates a full-stack application using Flutter and Flask.
