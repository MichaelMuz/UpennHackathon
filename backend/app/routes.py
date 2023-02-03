from app import app
from flask import render_template, request
from app.datalayer import Datalayer
from app.gpt_talker import gpt_req
import random

@app.route("/")
def index():
    return "welcome to Joe's crab shack"

@app.route("/new_question/<user_id>", methods = ["GET"])
def new_question_input_boxes(user_id):
    print(f"{user_id=}")
    return render_template("new_question.html", user_id=user_id)

@app.route("/new_question/<user_id>", methods = ["POST"])
def enter_new_questions(user_id):
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

@app.route("/ask_question/<user_id>", methods = ["GET"])
def ask_question(user_id):
    topic_not_question = True
    if(random.randint(0, 1) == 0):
        topic_not_question = False

    question_to_ask = None
    question_id = -1

    if(topic_not_question):
        topics = Datalayer.get_user_topics(user_id)
        chosen_topic = random.choice(topics)
        question_to_ask = gpt_req(f"ask me a question about {chosen_topic}")
       
    else:
        questions = Datalayer.get_user_questions_and_answers(user_id, give_qid=True)
        question_triple = random.choice(questions)
        question_to_ask = question_triple[0]
        question_id = question_triple[2]
        
    
    return render_template("ask_question.html", question=question_to_ask, question_id=question_id)

@app.route("/ask_question/<user_id>", methods = ["POST"])
def check_answer(user_id):
    question_id = int(request.form["questionId"])
    question = request.form["question"]
    answer = request.form["answer"]
    print(f"in check answer {question_id=}, {question=}, {answer=}")
    is_correct = False
    true_answer = ''
    #if question_id is -1 then the question was generated from a topic
    if(question_id == -1):
        gpt_eval = gpt_req(f'On a quiz I ask someone the question "{question}" and they answer "{answer}". Are they correct? Answer in a single word yes or no only.').lower()
        true_answer = gpt_req(f'how would you answer the question: "{question}"?')
        if("yes" in gpt_eval):
            is_correct = True
        elif("no" in gpt_eval):
            is_correct = False
        else:
            raise Exception(f"GPT responded with {gpt_eval} instead of yes or no")
    else:
        true_answer = Datalayer.get_question_by_id(question_id)[1]
        gpt_eval = gpt_req(f'On a quiz I ask someone the question "{question}" and the True answer is {true_answer}. They answer with: "{answer}". Are they correct? Answer in a single word yes or no only.').lower()
        if("yes" in gpt_eval):
            is_correct = True
        elif("no" in gpt_eval):
            is_correct = False
        else:
            raise Exception(f"GPT responded with {gpt_eval} instead of yes or no")
        

    return render_template("right_or_wrong.html", correct_answer=true_answer, user_answer=answer, question=question, is_correct=is_correct)




if __name__ == "__main__":
    app.run()