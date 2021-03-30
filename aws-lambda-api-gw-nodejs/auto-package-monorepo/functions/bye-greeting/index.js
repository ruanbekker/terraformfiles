'use strict';
var random_name = require('node-random-name');

function getName(){
    var response = random_name({ first: true });
    return response
}

module.exports.handle = async event => {
  var name = getName();
  return {
    statusCode: 200,
    body: JSON.stringify(
      {
        message: `Bye ${name}` ,
        input: event,
      },
      null,
      2
    ),
  };
};
