from flask import Flask, request, jsonify

app = Flask(__name__)
app.config['JSONIFY_PRETTYPRINT_REGULAR'] = True


@app.route('/')
def top():
    header_dict = dict(request.headers.items())
    return jsonify(header_dict)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
