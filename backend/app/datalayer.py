from app import db, User, StudySession, Topic, Question
from sqlalchemy import func

class Datalayer:

    def get_user_sessions(user_id):
        user = db.session.query(User).filter_by(user_id=user_id).first()
        print(f"{user=}")
        return [ses for ses in user.study_sessions]

    def get_session_details(user_id, session_name):
        session_id = db.session.query(StudySession).filter_by(user_id=user_id, name=session_name).first().id
        topics = db.session.query(Topic).filter_by(study_session_id=session_id)
        q_a = db.session.query(Question).filter_by(study_session_id=session_id)
        to_ret = {
            "questions" : [(i.question, i.answer) for i in q_a],
            "topics" : [i.topic for i in topics]
        }
        return to_ret

    def get_session_id(user_id, session_name):
        session = db.session.query(StudySession).filter_by(user_id=user_id, name=session_name).first()
        if(session == None):
            return None
        return session.id

    def delete_session(user_id, session_name):

        session_query = db.session.query(StudySession).filter_by(user_id=user_id, name=session_name).first()
        questions = db.session.query(Question).filter_by(study_session_id=session_query.id)
        for q in questions:
            db.session.delete(q)

        topics = db.session.query(Topic).filter_by(study_session_id=session_query.id)

        for t in topics:
            db.session.delete(t)


        db.session.delete(session_query)
        db.session.commit()
    
    def create_session(user_id, session_name):
        new_session = StudySession(name=session_name, user_id=user_id)
        db.session.add(new_session)
        db.session.commit()
        return new_session.id
    
    def edit_question(session_id, question, answer):
        question_query = db.session.query(Question).filter_by(study_session_id=session_id, question=question).first()
        if(question_query == None):
            new_question = Question(study_session_id=session_id, question=question, answer=answer)
            db.session.add(new_question)
        elif(answer == None):
            db.session.delete(question_query)
        elif(answer != question_query.answer):
            question_query.answer = answer

        db.session.commit()
    
    def edit_topic(session_id, topic_name):
        topic_query = db.session.query(Topic).filter_by(study_session_id=session_id, topic=topic_name).first()
        if(topic_query == None):
            new_topic = Topic(study_session_id=session_id, topic=topic_name)
            db.session.add(new_topic)
        else:
            db.session.delete(topic_query)
        db.session.commit()
        


        
        


    def get_random_question(user_id, session_name):
        session_id = Datalayer.get_session_id(user_id, session_name)
        return db.session.query(Question).filter_by(study_session_id=session_id).order_by(func.random()).first().question

    def get_random_topic(user_id, session_name):
        session_id = Datalayer.get_session_id(user_id, session_name)
        return db.session.query(Topic).filter_by(study_session_id=session_id).order_by(func.random()).first().topic

        
        

    
            