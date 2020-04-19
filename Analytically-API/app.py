import os
from flask import Flask
from flask_restful import Api
from resources.item import Item, GetCalculation

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URL', 'sqlite:///data.db')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.secret_key = 'veer'
api = Api(app)

api.add_resource(Item, '/heartdata/<string:name>')
api.add_resource(GetCalculation, '/riskheartdisease/<string:name>')

if __name__ == '__main__':
    from db import db
    db.init_app(app)
    app.run(port=5000, debug=True)
