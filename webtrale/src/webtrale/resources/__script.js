

  function openNavLeft() {
    document.getElementById("left_sidenav").style.width = "250px";
    document.getElementById("main").style.marginLeft = "250px";
    document.body.style.backgroundColor = "#FFFFFF";
  }

  function closeNavLeft() {
    document.getElementById("left_sidenav").style.width = "0";
    document.getElementById("main").style.marginLeft = "0";
    document.body.style.backgroundColor = "white";
  }
  // When the user clicks anywhere outside of the modal, close it
  window.onclick = function(event) {
    var x = document.getElementById("main");
    //alert(x.srcElement.id)
    //if(x == "main")closeNavLeft();
  }


  //opens the Test itens modal 

            $("#test_items_modal").animatedModal({
                modalTarget:'modal-02',
                animatedIn:'lightSpeedIn',
                animatedOut:'bounceOutDown',
                color:'#3498db',
                // Callbacks
                 beforeOpen: function() {
                 console.log("The animation was called");
            },           
            afterOpen: function() {
            console.log("The animation is completed");
            }, 
            beforeClose: function() {
            console.log("The animation was called");
            }, 
            afterClose: function() {
            console.log("The animation is completed");
            }
            });
            
            // opens Hierarchy modal
            $("#hierarchy_modal").animatedModal({
                 modalTarget:'modal-03',
                 animatedIn:'fadeInUp',
                 animatedOut:'rotateOut',
                 color:'#3498db',
                // Callbacks
                beforeOpen: function() {
                console.log("The animation was called");
            },           
            afterOpen: function() {
            console.log("The animation is completed");
            }, 
            beforeClose: function() {
            console.log("The animation was called");
            }, 
            afterClose: function() {
            console.log("The animation is completed");
            }
            });
            
            // opens the lexicon modal 
            $("#lexicon_modal").animatedModal();





// deprecated --> not in use, left for future use
/*
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

 

