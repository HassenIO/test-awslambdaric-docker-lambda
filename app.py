from flask import Flask
import os
import json


app = Flask(__name__)


def say_hello():
    return {"message": "Hello World!"}


@app.route('/hello', methods=['GET'])
def hello():
    return json.dumps(say_hello())


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=os.getenv("PORT", 5050), debug=True)
