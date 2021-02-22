from flask_api import FlaskAPI
from flask import request,jsonify
from flask_cors import CORS
from flask_mysqldb import MySQL

app = FlaskAPI(__name__)

app.url_map.strict_slashes = False
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'soa'

mysql = MySQL(app)

# CORS(app)

@app.route('/login', methods=['POST'])
def login():
    code = 0
    username = ""
    iduser = 0
    data = request.get_json(force=True)
    username = data['username']
    password = data['password']
    cur = mysql.connection.cursor()
    sql = "SELECT * FROM user WHERE username=%s and password=%s"
    val = (username, password)
    cur.execute(sql, val)
    data = cur.fetchall()
    cur.close()
    if len(data) > 0:
        code = 1
        username = data[0][1]
        iduser = data[0][0]
    return jsonify({
        'code':code,
        'iduser':iduser
    })

@app.route("/createuser/", methods=['POST'])
def createUser():
    data = request.get_json(force=True)
    username = data['username']
    password = data['password']
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO user(username, password) VALUES (%s, %s)", (username, password))
    mysql.connection.commit()
    cur.close()
    return jsonify({
        "code" : 1
    })

@app.route("/createsubject/", methods=['POST'])
def createSubject():
    data = request.get_json(force=True)
    subject = data['subject']
    print(subject)
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO subject(name) VALUES ('" + subject + "')")
    mysql.connection.commit()
    cur.close()
    return jsonify({
        'code' : 1
    })

@app.route("/createtest/", methods=['POST'])
def createTest():
    data = request.get_json(force=True)
    test = data['test']
    idsub = int(data['idsub'])
    time = data['time']
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO test(id_sub, name, time) VALUES (%s ,%s, %s)", (idsub, test, time))
    mysql.connection.commit()
    id = cur.lastrowid
    cur.close()
    return jsonify({
        'id' : id
    })

@app.route("/user/",methods=['GET'])
def getUsers():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM user")
    data = cur.fetchall()
    cur.close()
    return jsonify({
        'data' : data 
    })

@app.route("/test/",methods=['GET'])
def getTests():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM test")
    data = cur.fetchall()
    cur.close()
    return jsonify({
        'data' : data 
    })

@app.route("/subject/",methods=['GET'])
def getSubjects():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM subject")
    data = cur.fetchall()
    cur.close()
    return jsonify({
        'data' : data 
    })

@app.route("/gettest/",methods=['GET'])
def getTest():
    idTest = request.args['id']
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM test WHERE id = '" + idTest + "'")
    data = cur.fetchall()
    cur.close()
    return jsonify({
        'data' : data 
    })

@app.route("/createquestion", methods=['POST'])
def createQuestion():
    id = None
    data = request.get_json(force=True)
    idTest = data['idtest']
    question = data['question']
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO question(id_test, content) VALUES (%s ,%s)", (idTest, question))
    mysql.connection.commit()
    id = cur.lastrowid
    cur.close()
    print(id)
    return jsonify({
        "id" : id
    })

@app.route("/createanswer", methods=['POST'])
def createAnswer():
    data = request.get_json(force=True)
    idQues = data['idques']
    answer = data['answer']
    answerTrue = data['answertrue']
    sql = "INSERT INTO answer(id_ques, content, answer_true) VALUES (%s ,%s, %s)"
    val = []
    true = 0
    for i in range(len(answer)):
        if i == int(answerTrue):
            true = 1
        else:
            true = 0
        val.append((idQues, answer[i], true))
    print(val)
    cur = mysql.connection.cursor()
    cur.executemany(sql, val)
    mysql.connection.commit()
    print(cur.rowcount)
    cur.close()
    return "ok"

@app.route('/question', methods=['GET'])
def getQuestions():
    idTest = request.args['id']
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM question WHERE id_test = '" + idTest + "'")
    data = cur.fetchall()
    cur.close()
    return jsonify({
        'data' : data 
    })

@app.route('/answer', methods=['GET'])
def getAnswers():
    idQues = request.args['id']
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM answer WHERE id_ques = '" + idQues + "'")
    data = cur.fetchall()
    cur.close()
    return jsonify({
        'data' : data
    })

@app.route('/gettestsub', methods=['GET'])
def getTestsSub():
    idSub = request.args['id']
    idUser = request.args['iduser']
    cur = mysql.connection.cursor()
    sql = "SELECT id_test, id_sub, name, time FROM test, accept WHERE id_user=%s AND id_sub=%s AND id=id_test"
    val = (idUser, idSub)
    cur.execute(sql, val)
    data = cur.fetchall()
    cur.close()
    return jsonify({
        'data' : data
    })

@app.route('/getaccept', methods=['GET'])
def getAccept():
    idTest = request.args['id']
    cur = mysql.connection.cursor()
    sql = "SELECT id, username FROM user, accept WHERE id=id_user AND id_test=%s"
    val = (idTest)
    cur.execute(sql, val)
    data = cur.fetchall()
    cur.close()
    return jsonify({
        'data' : data
    })

@app.route('/setanswer', methods=['POST'])
def setAnswer():
    data = request.get_json(force=True)
    idUser = data['iduser']
    idAnswer = data['idan']
    answerTrue = 0
    sql = "INSERT INTO user_answer(id_user, id_answer) VALUES (%s, %s)"
    val = []
    for i in range(len(idAnswer)):
        val.append((idUser, idAnswer[i]))
    cur = mysql.connection.cursor()
    cur.executemany(sql, val)
    mysql.connection.commit()

    for an in idAnswer:
        cur.execute("SELECT * FROM answer WHERE id = '" + an + "'")
        answer = cur.fetchall()
        if answer[0][3] == 1:
            answerTrue = answerTrue + 1

    cur.close()
    return jsonify({
        'answertrue': answerTrue
    })

@app.route('/setscore', methods=['POST'])
def setScore():
    data = request.get_json(force=True)
    idUser = data['iduser']
    idTest = data['idtest']
    score = data['score']
    sql = "INSERT INTO result(id_user, id_test, score) VALUES (%s, %s, %s)"
    val = (idUser, idTest, score)
    cur = mysql.connection.cursor()
    cur.execute(sql, val)
    mysql.connection.commit()
    return jsonify({
        'code': 1
    })

@app.route('/adduser', methods=['POST'])
def addUser():
    data = request.get_json(force=True)
    idUser = data['iduser']
    idTest = data['idtest']
    sql = "INSERT INTO accept(id_user, id_test) VALUES (%s, %s)"
    if(len(idUser) > 1):
        val = []
        for i in range(len(idUser)):
            val.append((idUser[i], idTest))
        cur = mysql.connection.cursor()
        cur.executemany(sql, val)
        mysql.connection.commit()
    else:
        val = (idUser[0], idTest)
        cur = mysql.connection.cursor()
        cur.execute(sql, val)
        mysql.connection.commit()
    cur.close()
    return "ok"

if __name__ == "__main__":
    app.run(debug=True)