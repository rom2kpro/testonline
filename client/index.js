const express = require('express');
const path = require('path');
var session = require('express-session')
const axios = require('axios');
const app = express();
const port = 3000;
const api = require('./api');
const auth = require('./auth')

var bodyParser = require('body-parser');
const { response } = require('express');
const { title } = require('process');

app.set('view engine', 'pug');
app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies
app.use(express.static('public'))
app.use(session({
    secret:'Keep it secret'
    ,resave: false
    ,name:'uniqueSessionID'
    ,saveUninitialized:false
}))

app.get('/', (req, res) => {
    if(req.session.loggedIn){
        res.redirect('/home');
    } else{
        res.redirect('/login');
    }
})

app.get('/login', (req, res) => {
    if(req.session.loggedIn){
        res.redirect('/home')
    }else{
        res.render('login');
    }
})

app.post('/login', (req, res, next) => {
    axios.post('http://127.0.0.1:5000/login',{
        username: req.body.username,
        password: req.body.password
    }).then((response) => {
        if(response.data.code > 0){
            res.locals.username = req.body.username;
            res.locals.id = response.data.iduser;
            next();
        } else{
            res.redirect('/login');
        }
    })
    
},(req, res) => {
    req.session.loggedIn = true;
    req.session.username = res.locals.username;
    req.session.iduser = res.locals.id;
    res.redirect('/');
})

app.get('/admin', function (req, res) {
    Promise.all([api.getUsers(), api.getSubjects(), api.getTests()])
    .then(function (results) {
        res.render('index', { data : results });
    });
})

app.post('/createUser', function(req, res){
    axios.post('http://127.0.0.1:5000/createuser', {
        username : req.body.username,
        password : req.body.password
    }).then(function(response) {
        res.redirect('/admin');
    }).catch( function(error) {
        console.log(error);
    })
})

app.post('/createSubject', function(req, res){
    axios.post('http://127.0.0.1:5000/createsubject', {
        subject : req.body.subject
    })
    .then(function (response) {
        res.redirect('/');
    })
    .catch(function (error) {
        console.log(error);
    })
})

app.post('/createTest', function(req, res) {
    time = req.body.hour + ":" + req.body.minute + ":" + req.body.seconds;
    console.log(req.body.sub)
    console.log(time);
    axios.post('http://127.0.0.1:5000/createtest', {
        test : req.body.test,
        idsub : req.body.sub,
        time : time
    }).then(function(response) {
        res.redirect('/test?id=' + response.data.id);
    }).catch(function(error){
        console.error();
    })
})

app.get('/test', function(req, res) {
    axios.get('http://127.0.0.1:5000/gettest?id=' + req.query.id)
        .then(function(response) {
            const title = response.data.data
            ques = []
            axios.get('http://127.0.0.1:5000/question?id=' + req.query.id)
                .then(function (response) {
                    ques = response.data.data;
                    return ques;
                }).then(function(ques) {
                    async function ok(){
                        answer = []
                        for ( let q of ques) {
                            await axios.get('http://127.0.0.1:5000/answer?id=' + q[0])
                                .then(async function(response){
                                    await answer.push(response.data.data)
                                })
                        }
                        return answer
                    }
                    ok().then((answer) => {
                        api.getAccept(req.query.id).then((response) => {
                            useraccept = response.data.data
                            api.getUsers().then((response)=>{
                                users = response.data.data;
                                async function ok(){
                                    n = 1
                                    for (i of useraccept){
                                        await users.splice(i[0] - n,1);
                                        await n++;
                                    }
                                    return users
                                }
                                ok().then((users) => {
                                    res.render('test', {data:title, question: ques, answer : answer, useraccept: useraccept, users: users })
                                })
                            })
                        })
                    })
                    // return ques;
                // .then(function(ques){
                //     console.log(ques)
                })
            // res.render('test', { data : response.data.data });
        })
})

app.post('/test', function(req, res){
    axios.post('http://127.0.0.1:5000/createquestion',{
        idtest : req.query.id,
        question : req.body.question
    }).then(function(response){
        axios.post('http://127.0.0.1:5000/createanswer',{
            idques : response.data.id,
            answer : req.body.answer,
            answertrue : req.body.flexRadioDefault
        }).then(function(response) {
            res.redirect('/test?id=' + req.query.id);
        }).catch(function(error){
            console.log(error);
        })
    }).catch(function(err){
        console.log(err);
    })  
})

app.get('/home', auth, function(req, res){
    api.getSubjects().then(function(response) {
        res.render('home', {data: response.data.data, username: req.session.username});
    })
})

app.get('/tests', auth,function(req, res){
    api.getTestsSub(req.query.id, req.session.iduser)
        .then(function(response){
            res.render('tests', {data: response.data.data, username: req.session.username})
        })
})

app.get('/exam', auth, function(req, res){
    axios.get('http://127.0.0.1:5000/question?id=' + req.query.id)
        .then(function (response) {
            ques = response.data.data;
            return ques;
        }).then(function(ques) {
            async function ok(){
                answer = []
                for ( let q of ques) {
                    await axios.get('http://127.0.0.1:5000/answer?id=' + q[0])
                        .then(async function(response){
                            await answer.push(response.data.data)
                        })
                }
                return answer
            }
            ok().then((answer) => {
                axios.get('http://127.0.0.1:5000/gettest?id=' + req.query.id)
                    .then((response) => {
                        res.render('exam', { question: ques, answer : answer, username: req.session.username, time: response.data.data[0][3]})
                    })
            })
            // return ques;
        // .then(function(ques){
        //     console.log(ques)
        })
})

app.post('/exam', function(req, res){
    axios.post('http://127.0.0.1:5000/setanswer', {
        iduser: req.session.iduser,
        idan: req.body.ans,
    }).then((response) => {
        ques = req.body.ques.length;
        answerTrue = response.data.answertrue;
        answerWrong = ques - answerTrue;
        score = (answerTrue/ques)*10;
        axios.post('http://127.0.0.1:5000/setscore', {
            iduser: req.session.iduser,
            idtest: req.query.id,
            score: score
        })
        res.render('result', {ques:ques, answerTrue: answerTrue, answerWrong: answerWrong, score: score, username: req.session.username});
    })
})

app.get('/logout',(req,res) => {
    req.session.destroy();
    res.redirect('/');
})

app.post('/adduser', (req, res) => {
    api.addUser(req.body.user, req.query.id)
        .then((response) => {
            res.redirect('/test?id='+req.query.id);
        }).catch((err) => console.log(err));
})

app.listen(port, () => {
    console.log('Example app listening at http://localhost:3000');
})