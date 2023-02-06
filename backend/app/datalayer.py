from app import db, User, Topic, Question


class Datalayer:

    def get_user_sessions(user_id):
        user = db.session.query(User).filter_by(user_id=user_id).first()
        return [ses for ses in user.sessions]

    def get_session_details(user_id):
        session_id = db.session.query(StudySession).filter_by(user_id=user_id).first().id
        topics = db.session.query(Topic).filter_by(session_id=session_id)
        q_a = db.session.query(Topic).filter_by(session_id=session_id)
        to_ret = {
            "questions" : [(i.question, i.answer) for i in q_a],
            "topics" : [i.topic for i in topics]
        }
        return to_ret
    
    def get_random_question(session_name):
        session_id = db.session.query(StudySession).filter_by(user_id=user_id).first().id
        return db.session.query(Question).filter_by(session_id=session_id).options(load_only('id')).offset(
            func.floor(
                func.random() *
                db.session.query(func.count(model_name.id))
            )
        ).limit(1).all().question

    def get_random_topic(session_name):
        session_id = db.session.query(StudySession).filter_by(user_id=user_id).first().id
        return db.session.query(Topic).filter_by(session_id=session_id).options(load_only('id')).offset(
            func.floor(
                func.random() *
                db.session.query(func.count(model_name.id))
            )
        ).limit(1).all().topic

        
        

        
        

    
            