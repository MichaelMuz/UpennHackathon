from app import app
from flask import render_template, request
from app.datalayer import Datalayer

@app.route("/")
def index():
    return "welcome to Joe's crab shack"

@app.route("/new_question/<user_id>", methods = ["GET"])
def ask_question(user_id):
    print(f"{user_id=}")
    return render_template("new_question.html", user_id=user_id)

@app.route("/new_question/<user_id>", methods = ["POST"])
def enter_data(user_id):
    questions = request.form.getlist('question[]')
    answers = request.form.getlist('answer[]')
    topics = request.form.getlist('topic[]')
    if(Datalayer.does_user_exist(user_id)):
        Datalayer.add_new_questions(user_id, list(zip(questions, answers)))
        Datalayer.add_new_topics(user_id, topics)
        all_qa = Datalayer.get_user_questions_and_answers(user_id)
        all_topics = Datalayer.get_user_topics(user_id)
        return render_template("view_info.html", questions_answers=all_qa, topics=all_topics)
    return "Bruh who is you"





if __name__ == "__main__":
    app.run()