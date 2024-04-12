from flask import Flask, request, jsonify
import joblib
from sklearn.preprocessing import LabelEncoder

app = Flask(__name__)

# Load the trained model and label encoder
classifier = joblib.load('classifier.pkl')
label_encoder = LabelEncoder()

def predict_species(sepal_length, sepal_width, petal_length, petal_width):
    new_obs = [[sepal_length, sepal_width, petal_length, petal_width]]
    prediction = classifier.predict(new_obs)
    return label_encoder.inverse_transform(prediction)[0]

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    sepal_length = data['sepal length']
    sepal_width = data['sepal width']
    petal_length = data['petal length']
    petal_width = data['petal width']

    prediction = predict_species(sepal_length, sepal_width, petal_length, petal_width)

    return jsonify({'prediction': prediction})

if __name__ == '__main__':
    app.run(debug=True)
