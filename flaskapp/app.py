from flask import Flask, render_template
import json
import os

app = Flask(__name__)

@app.route('/')
def home():
    result_path = 'results/results.json'

    if not os.path.exists(result_path):
        return render_template('index.html', status="No data yet", passed="-", failed="-", timestamp="-")

    with open(result_path) as f:
        data = json.load(f)

    return render_template('index.html',
                           status=data.get("status", "Unknown"),
                           passed=data.get("passed", 0),
                           failed=data.get("failed", 0),
                           timestamp=data.get("timestamp", "N/A"))

@app.route('/results')
def results():
    try:
        with open('/app/results/results.json') as f:
            data = json.load(f)
        return jsonify(data)
    except Exception as e:
        print("❌ Error reading results.json:", e)
        return jsonify({"error": "Unable to read results.json"}), 500


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

