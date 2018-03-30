
/*
    Author: Antonio Mabiala
    antmabiala@gmail.com
*/
// open the hidden left slide navigation bar

  function openNavLeft() {
    document.getElementById("left_sidenav").style.width = "250px";
    document.getElementById("main").style.marginLeft = "250px";
    document.body.style.backgroundColor = "#FFFFFF";
  }

// close the hidden left navigation bar 
  function closeNavLeft() {
    document.getElementById("left_sidenav").style.width = "0";
    document.getElementById("main").style.marginLeft = "0";
    document.body.style.backgroundColor = "white";
  }

 


// deprecated --> not in use, left for future use
/*
  // When the user clicks anywhere outside of the modal, close it
  window.onclick = function(event) {
    var x = document.getElementById("main");
    if(x == "main")closeNavLeft();
  }

  function semanticsCase() {

    var x = document.getElementById('semantics');
    if (x.textContent == "Show") {

      x.textContent = "Hide";
      var y = window.parent.frames["viewpan"].document.body.getElementsByClassName("semanticlabel");
      var i;

      for (i = 0; i < y.length; i++) {
        y[i].style.display = "block";

      }
    } else if (x.textContent == "Hide") {

      x.textContent = "Show";
      var y = window.parent.frames["viewpan"].document.body.getElementsByClassName("semanticlabel");
      var i;

      for (i = 0; i < y.length; i++) {
        y[i].style.display = "none";

      }
    }


  }
*/

 

