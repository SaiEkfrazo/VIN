toastr.options = {
    "closeButton": true,
    "debug": false,
    "newestOnTop": false,
    "progressBar": true,
    "positionClass": "toast-top-right",
    "preventDuplicates": false,
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
}

baseUrl= "http://127.0.0.1:8000"

function signup() {
    var formData = {
        'first_name': document.getElementById('first_name').value,
        'last_name': document.getElementById('last_name').value,
        'email': document.getElementById('email').value,
        'phone_number': document.getElementById('phone_number').value,
        'password': document.getElementById('password').value
    };

    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/register/', true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.onload = function() {
        var data = JSON.parse(xhr.responseText);
        if (xhr.status === 201) {
            toastr.success(data.message);
            window.location.href = '/signin/';
        }
        else {
            var errors = data.message;
            for (var key in errors) {
                document.getElementById(key + "_error").innerText = errors[key][0];
            }
        }
    };
    xhr.send(JSON.stringify(formData));
}
function signin() {
    var formData = {
        'email_or_phone': document.getElementById('email_or_phone').value,
        'password': document.getElementById('password').value
    };

    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/login/', true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.onload = function() {
        var data = JSON.parse(xhr.responseText);
        if (xhr.status === 200) {
            toastr.success(data.message);
            window.location.href = '/dashboard/';  // Redirect to dashboard on successful login
        } else {
            var errors = data.message;
            for (var key in errors) {
                document.getElementById(key + "_error").innerText = errors[key][0];
            }
            console.log('errors',errors)

        }
    };
    xhr.send(JSON.stringify(formData));
}

// fetch(`${baseUrl}/reports/`)
//         .then(response => response.json())
//         .then(data => {
//             const reportsTableBody = document.getElementById('reports-table-body');

//             // Iterate over each report object and create a table row
//             data.forEach(report => {
//                 const row = document.createElement('tr');
//                 row.innerHTML = `
//                     <td>${report.id}</td>
//                     <td>${report.alert}</td>
//                     <td>${report.defect}</td>
//                     <td>${report.machine}</td>
//                     <td>${report.department}</td>
//                     <td>${report.recorded_date_time}</td>
//                     <td><img src="${report.image}" alt="Image"></td>
//                     <td>${report.image_b64}</td>
//                 `;
//                 reportsTableBody.appendChild(row);
//             });
//         })
//         .catch(error => console.error('Error fetching data:', error));


    // console.log("DOMContentLoaded event triggered");
    

    