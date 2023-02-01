from app import app

@app.route("/")
def index():
    return "welcome to Joe's crab shack"

@app.route("/my_orders")
def crab_page():
    return "I don't know who is logged in yet"

if __name__ == "__main__":
    app.run()