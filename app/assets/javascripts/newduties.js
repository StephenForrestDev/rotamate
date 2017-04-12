function updateForm(){//calls this function when the selected value changes
  $.getJSON("/duties/"+ document.getElementById("dutynum_select").value+"/get_json", fillForm);  //does ajax call to the invoice route we set up above

}

function fillForm(data){
  document.getElementById("duty_dutynum").value = data.dutynum;
  document.getElementById("duty_starttime").value = data.starttime;
  document.getElementById("duty_endtime").value = data.endtime;
  document.getElementById("duty_paytime").value = data.paytime;    
}