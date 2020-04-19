from db import db

class ItemModel(db.Model):
    __tablename__ = 'Items'

    num = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80))
    age = db.Column(db.Integer)
    sex = db.Column(db.Integer)
    cp = db.Column(db.Integer)
    trestbps = db.Column(db.Float)
    chol = db.Column(db.Float)
    fbs = db.Column(db.Integer)
    restecg = db.Column(db.Integer)
    thalach = db.Column(db.Float)
    exang = db.Column(db.Integer)
    oldpeak = db.Column(db.Float)
    slope = db.Column(db.Integer)
    ca = db.Column(db.Integer)
    thal = db.Column(db.Integer)

    def __init__(self, name, age, sex, cp, trestbps, chol, fbs, restecg, thalach, exang, oldpeak, slope, ca, thal):
        self.name = name
        self.age = age
        self.sex = sex
        self.cp = cp
        self.trestbps = trestbps
        self.chol = chol
        self.fbs = fbs
        self.restecg = restecg
        self.thalach = thalach
        self.exang = exang
        self.oldpeak = oldpeak
        self.slope = slope
        self.ca = ca
        self.thal = thal

    def json(self):
        return {'name': self.name, 'age': self.age, 'sex': self.sex, 'cp': self.cp, 'trestbps': self.trestbps, 'chol': self.chol, 'fbs': self.fbs, 'restecg': self.restecg, 'thalach': self.thalach, 'exang': self.exang, 'oldpeak': self.oldpeak, 'slope': self.slope, 'ca': self.ca, 'thal': self.thal}

    @classmethod
    def find_by_measure(cls, name):
       return cls.query.filter_by(name=name).first()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()
