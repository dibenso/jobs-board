$(document).ready(function() {
  var job_name = document.getElementById('job_name');
  var job_min_wage = document.getElementById('job_min_wage');
  var job_max_wage = document.getElementById('job_max_wage');
  var job_time = document.getElementById('job_time');
  var job_location = document.getElementById('job_location');
  var category = document.getElementById('category')
  var job_description = document.getElementById('job_description');

  var name = document.getElementById('name');
  var wage = document.getElementById('wage');
  var steady_wage = document.getElementById('steady_wage');
  var time = document.getElementById('time');
  var location = document.getElementById('location');
  var job_category = document.getElementById('job_category');
  var description = document.getElementById('description');

  job_name.onchange = function() {
    name.childNodes[1].innerHTML = this.value;
  }

  job_min_wage.onchange = function() {
    if(job_max_wage.value === this.value) {
      wage.childNodes[1].innerHTML = "";
      steady_wage.childNodes[1].innerHTML = '$' + this.value;
    }
    else
      wage.childNodes[1].innerHTML = '$' + this.value + ' - ' + '$' + job_max_wage.value
  }

  job_max_wage.onchange = function() {
    if(job_min_wage.value === this.value) {
      wage.childNodes[1].innerHTML = "";
      steady_wage.childhood[1].innerHTML = '$' + this.value;
    }
    else
      wage.childNodes[1].innerHTML = '$' + job_min_wage.value + ' - ' + '$' + this.value;
  }

  category.onchange = function() {
    job_category.childNodes[1].innerHTML = category.value;
  }

  job_location.onchange = function() {
    location.childNodes[1].innerHTML = 'Located in ' + job_location.value;
  }

  job_time.onchange = function() {
    if(job_time.value === 'Part' || job_time.value === 'Full')
      time.childNodes[1].innerHTML = job_time.value + ' time';
    else
      time.childNodes[1].innerHTML = job_time.value;
  }

  job_description.onchange = function() {
    description.childNodes[1].innerHTML = job_description.value;
  }
});
