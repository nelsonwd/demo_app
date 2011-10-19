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

function ChAll(group) {
var group;
var myform=document.getElementById("starttblastnoptions");

        if (group=="green_algae") {
                for (var m = 0; m < 11; m++){
                myform[m].checked = true;
                }
        }
        
        if (group=="alveolata") {
                for (var m =11 ; m < 16; m++){
                myform[m].checked = true;
                }
        }
        
        if (group=="dinophyceae") {
                for (var m = 11; m < 15; m++){
                myform[m].checked = true;
                }
        }
        
        if (group=="symbiodinium") {
                for (var m = 11; m < 14; m++){
                myform[m].checked = true;
                }
        }
        
        if (group=="cnidaria") {
                for (var m = 16; m < 20; m++){
                myform[m].checked = true;
                }
        }
        
        if (group=="anthozoa") {
                for (var m = 16; m < 19; m++){
                myform[m].checked = true;
                }
        }
}


function unChAll(group) {
var group;
var myform=document.getElementById("starttblastnoptions");

        if (group=="green_algae") {
                for (var m = 0; m < 11; m++){
                myform[m].checked = false;
                }
        }
        
        if (group=="alveolata") {
                for (var m = 11; m < 16; m++){
                myform[m].checked = false;
                }
        }
        
        if (group=="dinophyceae") {
                for (var m = 11; m < 15; m++){
                myform[m].checked = false;
                }
        }
        
        if (group=="symbiodinium") {
                for (var m = 11; m < 14; m++){
                myform[m].checked = false;
                }
        }
        
        if (group=="cnidaria") {
                for (var m = 16; m < 20; m++){
                myform[m].checked = false;
                }
        }
        
        if (group=="anthozoa") {
                for (var m = 16; m < 19; m++){
                myform[m].checked = false;
                }
        }
        
}


function newWindow(url) {
 explanation=window.open(url,'dbblastwin',
'left=150,top=20,width=700,height=500,toolbar=yes,resizable=yes,location=yes,status=yes,menubar=yes,scrollbars=yes');
 explanation.focus()
}

function fieldfocus(){
document.starttblastnoptions.in_querysequence.focus();
}


