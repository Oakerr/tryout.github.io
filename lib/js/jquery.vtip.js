/**
Vertigo Tip by www.vertigo-project.com
Requires jQuery
*/

this.vtip = function() {    
    this.xOffset = 0; // x distance from mouse
    this.yOffset = 20; // y distance from mouse       
    
    $(".vtip").unbind().hover(    
        function(e) {
            this.t = this.title;
            this.title = ''; 
            this.top = (e.pageY + yOffset); this.left = (e.pageX + xOffset);
            
            $('body').append( '<div id="vtip"><span id="vtipArrow" /></span>' + this.t + '</div>' );
                        
            //$('div#vtip #vtipArrow').attr("src", 'images/vtip_arrow.png');
            $('div#vtip').css("top", this.top+"px").css("left", this.left+"px").fadeIn("fast");
            
        },
        function() {
            this.title = this.t;
            $("div#vtip").fadeOut("fast").remove();
        }
    ).mousemove(
        function(e) {
            this.top = (e.pageY + yOffset);
            this.left = (e.pageX + xOffset);
                         
            $("div#vtip").css("top", this.top+"px").css("left", this.left+"px");
        }
    );            
    
};

jQuery(document).ready(function($){vtip();}) 