from app import app
from flask import render_template, request
from app.datalayer import Datalayer
from app.gpt_talker import gpt_req
import random
from flask import jsonify


#get existing user study sessions
@app.route('/get_sessions', methods = ["GET"]) #assuming user_id is 1
def get_study_sessions_from_user(): #GET all the sessions
    user_id = 1
    sessions = Datalayer.get_user_sessions(user_id)
    session_dict = {
        "user_id": user_id,
        "sessions": [
        ]
    }
    for sess in sessions:
        session_dict["sessions"].append({"name" : sess.name})

    return jsonify(session_dict)



#return everything about session with session_name = session_name
@app.route('/session_info/<session_name>', methods = ["GET"])
def get_session_info(session_name):
    user_id = 1
    details = Datalayer.get_session_details(user_id, session_name)
    to_json = {
        "questions" : [
            #{
                # "question": "",
                # "answer": ""
            #}
        ],
        "topics": [topic for topic in details["topics"]]
    }
    for quest, ans in details["questions"]:
        inner = {
            "question" : quest,
            "answer" : ans
            }
        to_json["questions"].append(inner)

    return jsonify(to_json)

   
    

#edit a session if session name exists, if it does not then a new session will be created
@app.route('/edit_create_session', methods = ["POST"])
def edit_study_session(): #POST session changes
    user_id = 1
    changes = request.json
    
    session_name = changes["session_name"]
    session_id = Datalayer.get_session_id(user_id, session_name)
    if(session_id != None and len(changes["questions"]) == 0 and len(changes["topics"]) == 0):
        Datalayer.delete_session(user_id, session_name)
    elif(session_id == None):
        session_id = Datalayer.create_session(user_id=user_id, session_name=session_name)

    questions_json = changes["questions"]
    for q in questions_json:
        question = q["question"]
        answer = q["answer"]
        Datalayer.edit_question(session_id, question, answer)
    
    for topic in changes["topics"]:
        Datalayer.edit_topic(session_id, topic)
        
    return jsonify({"message" : "success"})
    


#will get a question
@app.route('/ask_question/<session_name>', methods = ["GET"])
def ask_question(session_name):
    question_to_ask = None
    topic_not_question = True
    if(random.randint(0, 1) == 0):
        topic_not_question = False

    if(topic_not_question):
        question_to_ask = Datalayer.get_random_topic(session_name)
    else:
        question_to_ask = Datalayer.get_random_question(session_name)
        
        
    to_ret = {
        "question" : question_to_ask
    }

    return jsonify(to_ret)

#post the user's answers and receive the answer
@app.route('/answer_question', methods = ["POST"])
def answer_question():
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
        
    print(f"checking correctness with: {true_answer=}, user's {answer=}, {question=}, {is_correct=}")
    to_ret = {
        "question": question,
        "user_answer": answer,
        "is_correct": is_correct,
        "true_answer": true_answer
        
    }
    return jsonify(to_ret)

#post the user's pics
@app.route('/view_pictures', methods = ["GET"]) #assuming userid = 1
def view_pictures():
    pass





    




if __name__ == "__main__":
    app.run()