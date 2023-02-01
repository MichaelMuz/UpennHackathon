from app import app
from flask import render_template, request

@app.route("/")
def index():
    return "welcome to Joe's crab shack"

@app.route("/my_orders")
def crab_page():
    return "I don't know who is logged in yet"

@app.route("/new_question/<user_id>", methods = ["GET"])
def ask_question(user_id):
    print(f"{user_id=}")
    return render_template("new_question.html", user_id=user_id)

@app.route("/new_question/<user_id>", methods = ["POST"])
def enter_data(user_id):
    question = request.form['question']
    answer = request.form['answer']
    print(f"{user_id=}, {question}, {answer}")
    return render_template("question_recorded.html", user_id=user_id, question=question, answer=answer)

@app.route("/react")
def show_react():
    return render_template(app.static_folder, "App.tsx")


if __name__ == "__main__":
    app.run()