from redisearch import Client, AutoCompleter, TextField, IndexDefinition, Query
from flask import Flask, escape, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)
client = Client('idx:addr', 'redis')
ac = AutoCompleter('ac', 'redis')

@app.route('/recherche')
def recherches_adresses():
    query = request.args.get("q")
    q = Query(query).language('french').paging(0, 10) 
    res = client.search(q)
    adresses = {}
    for i, doc in enumerate(res.docs):
        adresses[i] = {
            "value": doc.id.replace("addr:", ""),
            "label": doc.adresse
        }
    return jsonify(adresses=adresses)

@app.route('/suggestions')
def suggestions_adresses():
    query = request.args.get("q")
    suggs = ac.get_suggestions(query, fuzzy = True, with_payloads = True)
    adresses = {}
    for i, sugg in enumerate(suggs):
        adresses[i] = {
            "value": sugg.payload,
            "label": sugg.string
        }
    return jsonify(adresses=adresses)