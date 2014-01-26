function koshin(){
  var hiduke=document.lastModified;
  document.write(hiduke);
}

console.clear();

var url,
    req,
    /*sid = getCookie('sid'),*/
    result;

function setParameters(req) {
  /*
  req.setRequestHeader('Authorization', 'OAuth ' + sid);
  req.setRequestHeader('X-PrettyPrint', 'true');
  req.setRequestHeader('Accept', 'application/json');
  */
  req.setRequestHeader('Content-Type', 'application/json');
  return req;
}
function sendGetRequest(url) {
  req = new XMLHttpRequest();
  req.open("GET", url, false);
  setParameters(req);
  req.send(null);
  return req.responseText;
}
function sendPostRequest(url, body) {
  req = new XMLHttpRequest();
  req.open("POST", url, false);
  setParameters(req);
  req.send(body);
  return req;
}
function sendPatchRequest(url, body) {
  req = new XMLHttpRequest();
  req.open("PATCH", url, false);
  setParameters(req);
  req.send(body);
  return req;
}
function sendDeleteRequest(url) {
  req = new XMLHttpRequest();
  req.open("DELETE", url, false);
  setParameters(req);
  req.send(null);
  return req;
}


url = 'http://linkdata.org/api/1/rdf1s1175i/kamakura_aed_rdf.json';
result = JSON.parse(sendGetRequest(url));
console.log(result);
