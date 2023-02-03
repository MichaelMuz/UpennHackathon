from app import db, User, Topic, Question
class Datalayer:
    def does_user_exist(user_id):
        if(db.session.query(User).filter_by(user_id=user_id).first()):
            return True
        return False

    def make_new_user(user_id):
        user = db.session.query(User).filter_by(user_id=user_id).first()
        if(user):
            return False
        new_user = User(user_id=user_id)
        db.session.add(new_user)
        db.session.commit()

    # Retrieve all of a user's topics given the user's user_id
    def get_user_topics(user_id):
        user = db.session.query(User).filter_by(user_id=user_id).first()
        if(user):
            return [topic.topic for topic in user.topics]
        else:
            return []

    # Retrieve all of the questions that a user has asked
    def get_user_questions_and_answers(user_id, give_qid=False):
        user = db.session.query(User).filter_by(user_id=user_id).first()
        if(not user):
            return []
        q_and_a = []
        if(give_qid):
            for q in user.questions:
                q_and_a.append((q.question, q.answer, q.id))
            return q_and_a

        for q in user.questions:
            q_and_a.append((q.question, q.answer))
        
        return q_and_a

    def get_question_by_id(question_id):
        question = db.session.query(Question).filter_by(id=question_id).first()
        return (question.question, question.answer)
        
        

    def add_new_questions(user_id, questions_answers):
        
        user = db.session.query(User).filter_by(user_id=user_id).first()
        if not user:
            return False

        for quest, ans in questions_answers:
            question = db.session.query(Question).filter_by(question=quest, answer=ans, user_id=user_id).first()
            if(not question):
                question = Question(question=quest, answer=ans, user_id=user_id)
                db.session.add(question)
                db.session.commit()

        return True
            

    def add_new_topics(user_id, topics):
        user = db.session.query(User).filter_by(user_id=user_id).first()
        if not user:
            return False

        for top in topics:
            topic = db.session.query(Topic).filter_by(topic=top, user_id=user_id).first()
            if(not topic):
                topic = Topic(topic=top, user_id=user_id)
                db.session.add(topic)
                db.session.commit()

            # user_topic = db.UserTopic.query.filter_by(user_id=user_id, topic.id)
            # if(not user_topic):
            #     user_topic = db.UserTopic(user_id=user_id, topic_id=topic_id)
            #     db.session.add(user_topic)
            #     db.session.commit()
        

        return True
            