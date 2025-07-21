from flask import Flask, render_template, jsonify
import json

app = Flask(__name__)

@app.route('/')
def home():
    with open('results.json') as f:
        data = json.load(f)
    return render_template('index.html', result=data)

@app.route('/api/results')
def api_results():
    with open('results.json') as f:
        return jsonify(json.load(f))

if __name__ == '__main__':
    app.run(debug=True)
