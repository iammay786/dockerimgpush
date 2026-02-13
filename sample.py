from flask import flask

app = Flask(__name__)

def normal_function():
    return "This will be deployed on the Agent Server"

@app.route("/")
def home():
  return normal_function()

if __name__ == "__main__"
    app.run(host="0.0.0.0", port=5000)
