from inspect import getclosurevars
from flask import Flask, request, jsonify
import Recomm
app = Flask(__name__)

# FLASK_APP=app.py flask run  

@app.route('/api',methods=['GET'])
def home():
    # return "Hello, Flask!"
    d1 = {}
    d1['Query'] = str(request.args['Query'])
    print("QUERY GET: ",d1['Query'])
    # RS.forEachUser(d1['Query'])
    results = Recomm.getCorrelations(d1['Query'])
    toDict = results.to_dict('list')
    # print("results:")
    # print(results)
    print("toDict:")
    # toDict= results.set_index('ProductName')['correlation'].to_dict()
    print(toDict)
    return jsonify(toDict)


if __name__ == '__main__':
    app.run()