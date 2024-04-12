from firebase_functions import firestore_fn, https_fn
from firebase_admin import initialize_app, firestore
from google.cloud.firestore import Client, storage
import joblib
from flask import jsonify

app = initialize_app()

# Load your machine learning model
model_bucket_name = 'gs://iris-1f5b4.appspot.com'
model_blob_name = 'gs://iris-1f5b4.appspot.com/classifier.pkl'

storage_client = storage.Client()
bucket = storage_client.bucket(model_bucket_name)
blob = bucket.blob(model_blob_name)

# Download the pkl file to the local file system
local_file_path = '/tmp/classifier.pkl'
blob.download_to_filename(local_file_path)

# Load the machine learning model
model = joblib.load(local_file_path)


@https_fn.on_request()
def make_prediction(req: https_fn.Request) -> https_fn.Response:
    """Take input parameters and perform a prediction using the machine learning model.
    Store the result in a new document in the predictions collection in Firestore."""
    # Get input parameters from the request.
    sepal_length = float(req.args.get("sepal_length"))
    sepal_width = float(req.args.get("sepal_width"))
    petal_length = float(req.args.get("petal_length"))
    petal_width = float(req.args.get("petal_width"))

    # Perform prediction
    prediction = model.predict([[sepal_length, sepal_width, petal_length, petal_width]])

    # Store the result in Firestore
    firestore_client: Client = firestore.client()
    _, doc_ref = firestore_client.collection("predictions").add({
        "sepal_length": sepal_length,
        "sepal_width": sepal_width,
        "petal_length": petal_length,
        "petal_width": petal_width,
        "prediction": prediction.tolist()
    })

    # Send back a message that the prediction has been added
    return https_fn.Response(f"Prediction with ID {doc_ref.id} added.")
