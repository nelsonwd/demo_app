function isFormValid(formToValidate) {
        var formIsValid = true;
     if (formToValidate.in_querysequence.value == "" && formToValidate.query_file.value == "")
      {
         formIsValid = false;
         alert("Please enter a query sequence or upload a file.");
      }

        var v_form=document.getElementById("starttblastnoptions");
        upper_limit=v_form.length-1
        var counter_of_checked=0;
        for (e=0; e<v_form.length; e++){
                var status_of_checkbox=v_form[e].checked;
                if (status_of_checkbox==true)   {
                        counter_of_checked++;
                }
                if (e==upper_limit&&counter_of_checked==0) {
                        formIsValid = false;
                        alert ("Please check at least one genome");
                }
        }
      return formIsValid;
}

function checkAll()
{
var myform=document.getElementById("starttblastnoptions");
for (i = 0; i < myform.length; i++){
        myform[i].checked = true ;
    }
}

function unCheckAll()
{
var myform=document.getElementById("starttblastnoptions");
for (i = 0; i < myform.length; i++)
        myform[i].checked = false ;
}

function ChAll(group, isChecked) {
var group;
var myform=document.getElementById("starttblastnoptions");

        if (group=="green_algae") {
                for (var m = 0; m < 17; m++){
                myform[m].checked = isChecked;
                }
        }
        
        if (group=="cryptophyta") {
                for (var m =17 ; m < 20; m++){
                myform[m].checked = isChecked;
                }
        }
        
        if (group=="haptophyceae") {
                for (var m = 20; m < 23; m++){
                myform[m].checked = isChecked;
                }
        }
      
        if (group=="bacillariophyceae") {
                for (var m = 23; m < 25; m++){
                myform[m].checked = isChecked;
                }
        }
 
        if (group=="stramenopiles") {
                for (var m = 25; m < 28; m++){
                myform[m].checked = isChecked;
                }
        }

        if (group=="alveolata") {
                for (var m = 28; m < 43; m++){
                myform[m].checked = isChecked;
                }
        }

        if (group=="dinophyceae") {
                for (var m = 28; m < 41; m++){
                myform[m].checked = isChecked;
                }
        }

        if (group=="symbiodinium") {
                for (var m = 34; m < 41; m++){
                myform[m].checked = isChecked;
                }
        }
        
        if (group=="apicomplexa") {
                for (var m = 41; m < 43; m++){
                myform[m].checked = isChecked;
                }
        }
        
        if (group=="cnidaria") {
                for (var m = 43; m < 46; m++){
                myform[m].checked = isChecked;
                }
        }
        
        if (group=="other") {
                for (var m = 46; m < 47; m++){
                myform[m].checked = isChecked;
                }
        }
}

/*
function unChAll(group) {
var group;
var myform=document.getElementById("starttblastnoptions");

        if (group=="green_algae") {
                for (var m = 0; m < 15; m++){
                myform[m].checked = false;
                }
        }
        
        if (group=="cryptophyta") {
                for (var m = 15; m < 18; m++){
                myform[m].checked = false;
                }
        }
        
        if (group=="haptophyceae") {
                for (var m = 18; m < 21; m++){
                myform[m].checked = false;
                }
        }
        
        if (group=="bacillariophyceae") {
                for (var m = 21; m < 23; m++){
                myform[m].checked = false;
                }
        }

        if (group=="symbiodinium") {
                for (var m = 15; m < 19; m++){
                myform[m].checked = false;
                }
        }
        
        if (group=="cnidaria") {
                for (var m = 21; m < 25; m++){
                myform[m].checked = false;
                }
        }
        
        if (group=="anthozoa") {
                for (var m = 21; m < 24; m++){
                myform[m].checked = false;
                }
        }
        
}*/


function newWindow(url) {
 explanation=window.open(url,'dbblastwin',
'left=150,top=20,width=700,height=500,toolbar=yes,resizable=yes,location=yes,status=yes,menubar=yes,scrollbars=yes');
 explanation.focus()
}

function fieldfocus(){
document.starttblastnoptions.in_querysequence.focus();
}


