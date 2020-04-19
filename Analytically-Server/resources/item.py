from flask_restful import Resource, reqparse
from models.item import ItemModel
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier

class Item(Resource):
    parser = reqparse.RequestParser()
    parser.add_argument('age',
        type=int,
        required=True,
        help='This field cannot be left blank!'
    )
    parser.add_argument('sex',
        type=int,
        required=True,
        help='This field cannot be left blank!'
    )
    parser.add_argument('cp',
        type=int,
        required=True,
        help='This field cannot be left blank!'
    )
    parser.add_argument('trestbps',
        type=float,
        required=True,
        help='This field cannot be left blank!'
    )
    parser.add_argument('chol',
        type=float,
        required=True,
        help='This field cannot be left blank!'
    )
    parser.add_argument('fbs',
        type=int,
        required=True,
        help='This field cannot be left blank!'
    )
    parser.add_argument('restecg',
        type=int,
        required=True,
        help='This field cannot be left blank!'
    )
    parser.add_argument('thalach',
        type=float,
        required=True,
        help='This field cannot be left blank!'
    )
    parser.add_argument('exang',
        type=int,
        required=True,
        help='This field cannot be left blank!'
    )
    parser.add_argument('oldpeak',
        type=float,
        required=True,
        help='This field cannot be left blank!'
    )
    parser.add_argument('slope',
        type=int,
        required=True,
        help='This field cannot be left blank!'
    )
    parser.add_argument('ca',
        type=int,
        required=True,
        help='This field cannot be left blank!'
    )
    parser.add_argument('thal',
        type=int,
        required=True,
        help='This field cannot be left blank!'
    )

    def get(self, name):
        return {'item': [item.json() for item in ItemModel.query.filter_by(name=name).all()]}

    def delete(self, name):

        item = ItemModel.find_by_measure(name)
        if item:
            item.delete_from_db()
            return {'message': 'Deleted'}
        else:
            return {'message': 'Item not found'}

    def put(self, name):
        data = Item.parser.parse_args()
        item = ItemModel.find_by_measure(name)
        if item is None:
            item = ItemModel(name, data['age'], data['sex'], data['cp'], data['trestbps'], data['chol'], data['fbs'], data['restecg'], data['thalach'], data['exang'], data['oldpeak'], data['slope'], data['ca'], data['thal'])
        else:
            item.age = data['age'],
            item.sex = data['sex'],
            item.cp = data['cp'],
            item.trestbps = data['trestbps'],
            item.chol = data['chol'],
            item.fbs = data['fbs'],
            item.restecg = data['restecg'],
            item.thalach = data['thalach'],
            item.exang = data['exang'],
            item.oldpeak = data['oldpeak'],
            item.slope = data['slope'],
            item.ca = data['ca'],
            item.thal = data['thal']
        item.save_to_db()
        return item.json()


class GetCalculation(Resource):
    df = pd.read_csv("heart.csv")
    x_cols = ['age', 'sex', 'cp', 'trestbps', 'chol', 'fbs', 'restecg', 'thalach', 'exang', 'oldpeak', 'slope', 'ca', 'thal']
    X = df[x_cols]
    y = df['target']
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)
    model = RandomForestClassifier()
    model.fit(X_train, y_train)

    def get(self, name):
        testitem = ItemModel.find_by_measure(name)
        if testitem is None:
            return {'data': False}
        else:
            data = {'item': [item.json() for item in ItemModel.query.filter_by(name=name).all()]}
            age = data['item'][0]['age']
            sex = data['item'][0]['sex']
            cp = data['item'][0]['cp']
            trestbps = data['item'][0]['trestbps']
            chol = data['item'][0]['chol']
            fbs = data['item'][0]['fbs']
            restecg = data['item'][0]['restecg']
            thalach = data['item'][0]['thalach']
            exang = data['item'][0]['exang']
            oldpeak = data['item'][0]['oldpeak']
            slope = data['item'][0]['slope']
            ca = data['item'][0]['ca']
            thal = data['item'][0]['thal']
            X_data = [[age, sex, cp, trestbps, chol, fbs, restecg, thalach, exang, oldpeak, slope, ca, thal]]
            testing = GetCalculation.model.predict(X_data)

            return {'data': int(testing[0])}
