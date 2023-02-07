from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db.sqlite3'
app.config['SQLALCHEMY_TRACK_NOTIFICATIONS'] = False



db = SQLAlchemy(app)

class User(db.Model):
    __tablename__ = 'User'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.String(255), unique=True, nullable=False)
    study_sessions = db.relationship('StudySession', backref='User', lazy=True)
    

class StudySession(db.Model):
    __tablename__ = 'StudySession'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('User.id'), nullable=False)
    topics = db.relationship('Topic', backref='StudySession', lazy=True)
    questions = db.relationship('Question', backref='StudySession', lazy=True)


class Topic(db.Model):
    __tablename__ = 'Topic'
    id = db.Column(db.Integer, primary_key=True)
    topic = db.Column(db.String(255), nullable=False)
    study_session_id = db.Column(db.Integer, db.ForeignKey('StudySession.id'), nullable=False)


class Question(db.Model):
    __tablename__ = 'Question'
    id = db.Column(db.Integer, primary_key=True)
    question = db.Column(db.String(255), nullable=False)
    answer = db.Column(db.String(255), nullable=False)
    study_session_id = db.Column(db.Integer, db.ForeignKey('StudySession.id'), nullable=False)

# app.app_context().push()
# db.drop_all()
# db.create_all()
# new_user = User(user_id=1)
# db.session.add(new_user)
# db.session.commit()
from app import routes

