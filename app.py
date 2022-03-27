from flask import Flask, request
import os
import json


app = Flask(__name__)


def say_hello(name):
    return {"message": f"Hello {name}!"}


@app.route('/greet', methods=['POST'])
def hello():
    content_type = request.headers.get('Content-Type')
    if content_type != 'application/json':
        raise RuntimeError(f"Not supported Content-Type={content_type}")
    name = request.json.get("name", "anon")
    return json.dumps(say_hello(name))


def handler(event, context):
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
        },
        "body": json.dumps(say_hello()),
    }


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=os.getenv("PORT", 5050), debug=True)
