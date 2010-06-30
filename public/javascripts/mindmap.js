function init_concept_visualization(url) {
	new Ajax.Request(url, {
	  method:'get',
	  onSuccess: function(transport){
	    	insert_concept_visualization(transport);
	   }
	});
}

function insert_concept_visualization(transport) {  
  
 	var json = transport.responseText.evalJSON();

	// alert(json);
	// alert(hypertree_json_sample);
	
  //Create a new canvas instance.
  var canvas = new Canvas('concept', {
    //Where to inject the canvas. Any HTML container will do.
    'injectInto':'concept_visualization',
    //Width and height of canvas, default's to 200.
    'width': 400,
    'height':400
  });

  var ht= new Hypertree(canvas, {
    //Add colors for nodes and edges
    Node: {
      color: '#ddd'
    },
    Edge: {
      color: '#dd00bb'
    },

    //Add node names to node labels
    onCreateLabel: function(domElement, node) {
      domElement.innerHTML = node.name;
      //Call the "onclick" method from
      //the hypertree to move the hypertree
      //correspondingly.
      //This method takes the clicked node's id.
      domElement.onclick = function() {
        ht.onClick(node.id);
      };
    },

    //Take the left style property and
    //substract half of the label actual width to
    //center the label.
    onPlaceLabel: function(tag, node) {
      var width = tag.offsetWidth;
      var intX = parseInt(tag.style.left);
      intX -= width / 2;
      tag.style.left = intX + 'px';
    }
  });

  ht.loadJSON(json);
  // ht.loadJSON(hypertree_json_sample);
  ht.refresh();
}
