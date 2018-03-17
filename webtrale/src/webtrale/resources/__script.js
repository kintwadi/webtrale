  


/* AUTHOR: ANTONO MABIALA And NIKO
   EMAIL:  antmabiala@gmail.com
          

            /*$("#left_container").ready(function(){
            $("#flip").click(function(){
            $("#left_content").slideToggle("slow");
            });
            });
            */

 function init() {
            if (!window.parent._wt_flag_islocal) {
            document.getElementById("local-control").style.display = "none";
            }
            document.getElementById('q').focus();
            }
            function _onsubmit() {
            document.getElementById('q').select();
            if (!document.getElementById('cb-new-window').checked) {
            window.parent.frames["viewpan"].document.body.innerHTML = "<h2>Parsing...</h2>"; 
            }
            return true;
            }
            function enlargeTypeHierarchy() {

            var y = document.getElementById('showtypehierarchy');

            if(y.value == "Show"){

            y.value = "Hide";
            parent.document.getElementsByTagName('frameset')[2].rows = '90%,*,3%';
            }else if(y.value == "Hide"){
            y.value = "Show";
            minimizeTypeHierarchy();
            }

            }

            function minimizeTypeHierarchy() {
            parent.document.getElementsByTagName('frameset')[2].rows = '0%,*,3%';
            }

            function enlargeTestItems() {

            var y = document.getElementById('showtestitems');

            if(y.value == "Show"){

            y.value = "Hide";
            parent.document.getElementsByTagName('frameset')[2].rows = '0%,50%,50%';

            }else if(y.value == "Hide"){
            y.value = "Show";
            minimizeTestItems();

            }



            }

            function minimizeTestItems() {
            parent.document.getElementsByTagName('frameset')[2].rows = '0%,*,0%';
            }

            function showSemanticLabels() {

            var y = document.getElementById('showsemanticlabels');

            if(y.value == "Show"){

            y.value = "Hide";
            hideSemanticLabels();
            }else if(y.value == "Hide"){
            y.value = "Show";
            }

            var x = window.parent.frames["viewpan"].document.body.getElementsByClassName("semanticlabel");
            var i;
            if(y.value == "Show"){// me
            for (i = 0; i < x.length; i++) {
            x[i].style.display = "block";
            }
            }



            }

            function hideSemanticLabels() {
            var x = window.parent.frames["viewpan"].document.body.getElementsByClassName("semanticlabel");
            var i;
            for (i = 0; i < x.length; i++) {
            x[i].style.display = "none";
            } 


            }

            function openNavLeft() {
            document.getElementById("left_sidenav").style.width = "250px";
            document.getElementById("main").style.marginLeft = "250px";
            document.body.style.backgroundColor = "#FFFFFF";
            }

            function closeNavLeft() {
            document.getElementById("left_sidenav").style.width = "0";
            document.getElementById("main").style.marginLeft= "0";
            document.body.style.backgroundColor = "white";
            }
            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function(event) {
            var x = document.getElementById("main");
            //alert(x.srcElement.id)
            //if(x == "main")closeNavLeft();
            }


            function semanticsCase(){

            var x = document.getElementById('semantics');
            if(x.textContent == "Show"){
           
                x.textContent = "Hide";
                var y = window.parent.frames["viewpan"].document.body.getElementsByClassName("semanticlabel");
                var i;
                
                for (i = 0; i < y.length; i++) {
                   y[i].style.display = "block";
                
               }
            }else if(x.textContent == "Hide"){
                
                x.textContent = "Show";
                var y = window.parent.frames["viewpan"].document.body.getElementsByClassName("semanticlabel");
                var i;
                
                for (i = 0; i < y.length; i++) {
                   y[i].style.display = "none";
                
               }
            }


            }

            function itemsCase(){

            var x = document.getElementById('items');
            
            if(x.textContent == "Show"){
                x.textContent = "Hide";
            }else if(x.textContent == "Hide"){
                x.textContent = "Show";
                
            }


            }
            function hierarchyCase(){

            var x = document.getElementById('hierarchy');
            if(x.textContent == "Show"){
            x.textContent = "Hide";
            }else if(x.textContent == "Hide"){
            x.textContent = "Show";
            }


            }

            // get the modal for items
            var modal = document.getElementById("items_myModal");
            var btn = document.getElementById("items");

            //var span = document.getElementByClassName("semantics_close")[0];

            function modalEvent(){
               itemsCase();
               modal.style.display ="block";
            }
            // When the user clicks on <span> (x), close the modal
            function closeModal(){
               modal.style.display = "none";
               itemsCase();
            }


            window.onclick = function(event){
            if(event.target == modal){
              modal.style.display = "none";
              itemsCase();
            }


            }

$('.selector').tooltip({
        tooltipClass: "your_class-Name",
});
