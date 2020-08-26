//use path module
const path = require('path');
//use express module
const express = require('express');
//use hbs view engine
const hbs = require('hbs');
//use bodyParser middleware
const bodyParser = require('body-parser');
//use mysql database
const mysql = require('mysql');
const app = express();

//GET


//POST
function handleAddRowOrg() {
    axios
      .post('https://www.getpostman.com/collections/a9fcf3e3d558ddc82495', {
        "nama": "",
        "jenis": ""
      })
      .then(res => console.log(res))
      .catch(err => console.error(err));
  }


//PUT


//DELETE



// EVENT LISTENER BUTTONS
document.getElementById('postRow').addEventListener('click', handleAddRowOrg);
