from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db.sqlite3'
app.config['SQLALCHEMY_TRACK_NOTIFICATIONS'] = False



db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.String(255), unique=True, nullable=False)
    #topics = db.relationship('Topic', secondary='user_topics', backref=db.backref('users', lazy=True))
    #topics = db.relationship('Topic', backref='user', lazy=True)
    #questions = db.relationship('Question', backref='user', lazy=True)
    study_sessions = db.relationship('StudySession', backref='user', lazy=True)

class StudySession:
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    name = db.Column(db.String(255), unique=True, nullable=False)
    topics = db.relationship('Topic', backref='StudySession', lazy=True)
    questions = db.relationship('Question', backref='StudySession', lazy=True)

class Topic(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    topic = db.Column(db.String(255), nullable=False)
    session_id = db.Column(db.Integer, db.ForeignKey('studysession.id'), nullable=False)


class Question(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    question = db.Column(db.String(255), nullable=False)
    answer = db.Column(db.String(255), nullable=False)
    session_id = db.Column(db.Integer, db.ForeignKey('studysession.id'), nullable=False)



# class Topic(db.Model):
#     id = db.Column(db.Integer, primary_key=True)
#     topic = db.Column(db.String(255), nullable=False)

# class UserTopic(db.Model):
#     user_id = db.Column(db.Integer, db.ForeignKey('user.id'), primary_key=True)
#     topic_id = db.Column(db.Integer, db.ForeignKey('topic.id'), primary_key=True)

from app import routes

