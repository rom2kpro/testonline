const axios = require('axios');

module.exports.getUsers = function(){
    return axios.get('http://127.0.0.1:5000/user');
};

module.exports.getSubjects = function(){
    return axios.get('http://127.0.0.1:5000/subject')
};

module.exports.getTests = function(){
    return axios.get('http://127.0.0.1:5000/test')
};

module.exports.getTestsSub = function(id, iduser){
    return axios.get('http://127.0.0.1:5000/gettestsub?id=' + id + '&iduser=' + iduser);
};

module.exports.getAccept = function(id){
    return axios.get('http://127.0.0.1:5000/getaccept?id=' + id);
};

module.exports.addUser = function(idUser, idTest){
    return axios.post('http://127.0.0.1:5000/adduser', {
        iduser: idUser,
        idtest: idTest
    });
};