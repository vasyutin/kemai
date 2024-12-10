function request(verb, host, token, endpoint, obj, callback) {
    let request = new XMLHttpRequest();

    request.onreadystatechange = function () {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (callback) {

                let response = {
                    status: request.status,
                    data: request.status === 200 ? JSON.parse(request.response) : ''
                }

                callback(response);
            }
        }
    }

    request.open(verb, host + '/api/' + endpoint);
    request.setRequestHeader('Content-Type', 'application/json')
    request.setRequestHeader('Accept', 'application/json')
    request.setRequestHeader('Authorization', 'Bearer ' + token)

    let data = obj ? JSON.stringify(obj) : ''
    request.send(data);
}

function getVersion(host, token, callback) {
    request('GET', host, token, 'version', null, callback);
}
