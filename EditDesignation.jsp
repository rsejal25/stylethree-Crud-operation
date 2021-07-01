<jsp:include page='MasterPageTopSection.jsp' />
<script>
function cancelEdition(){
document.getElementById("cancelEdit").submit();
}
function pageLoader(){
alert('jjfjf');
let xhr=new XMLHttpRequest();
xhr.onreadystatechange=function(){
if(this.readyState==4 && this.status==200)
{
alert('djdfj');
let responseData=JSON.parse(this.responseText);
if(responseData.result=="error")
{
document.getElementById("errorSection").innerHTML="invalid data";
}
else
{
alert('hellp');
document.getElementById("heading").innerHTML="Designation Edit Module";
document.getElementById("description").innerHTML="Edit Designation?";
document.getElementById("code").value=responseData.code;
document.getElementById("title").value=responseData.title;
}
}
};
const urlParams=new URLSearchParams(window.location.search);
let code=urlParams.get('code');
xhr.open('GET','editDesignation?code='+code,true);
xhr.send();
}
function editDesignation(){
let code=document.getElementById("code").value;
let title=document.getElementById("title").value;
let xhr=new XMLHttpRequest();
let dataToSend="code="+encodeURI(code);
dataToSend=dataToSend+"&title="+encodeURI(title);
xhr.onreadystatechange=function(){
if(this.readyState==4 && this.status==200)
{
responseData=this.responseText;
if(responseData.includes("error"))
{
responseData=responseData.split(",");
document.getElementById("errorSection").innerHTML=responseData[1];
document.getElementById("title").focus();
}
else
{
document.getElementById("description").innerHTML="Designation Updated";
document.getElementById("secondButton").remove();
firstButton=document.getElementById("firstButton");
firstButton.innerHTML="Ok";
firstButton.setAttribute("onclick","cancelEdition();");
document.getElementById("title").remove();
}
}
};
xhr.open('POST','updateDesignation',true);
xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
xhr.send(dataToSend);
}
window.addEventListener('load',pageLoader);
</script>
<div id='heading'></div>
<div id='description'></div>
<input type='hidden' id='code'>
<input type='text' id='title'>
<span id='errorSection'></span>
<button type='button' onclick='editDesignation()' id='firstButton'>Edit</button>
<button type='button' onclick='cancelEdition()' id='secondButton'>Cancel</button>
<form action='/stylethree/Designations.jsp' id='cancelEdit'></form>
<jsp:include page='MasterPageBottomSection.jsp' />