Collections.cfc
==================
Collections.cfc is a library of iteration methods for Coldfusion arrays and structures.

Tested on Railo 3.2 and Adobe Coldfusion 9.01

##public any function map( data, callback )
Create a new collection by executing the provided callback on each element 
in the provided collection

<i>Callback Signature</i><br>
<tt> public any function callback( value, index, collection ){} </tt>

<i>Usage</i>

	// Define the callback
	public numeric function multiplyAgeBy20( value, index, data){
		return value.age * 20;
	}
	
	// Create the Collections object
	c = new Collections();
	
	// Our collection to map
	data = { 'John'={age=20},'Kelley'={age=30}, 'Nicole'={age=40} };
	
	// Map the collection
	c.map( data, multiplyAgeBy20 );
	
	// Returns
	// {'John'=400,'Kelley'=600, 'Nicole'=800};	


##public any function reduce( data, callback [, initialvalue ] )
Executes the provided callback for each element in the collection 
(from left to right) passing in the value from the previous execution (the accumulatedValue), 
the value of the current index, the index itself and the original 
provided collection. Use this method to reduce a collection to a single 
value. Structure collections will be iterated by key name in ascending 
order (i.e. mystruct['apple'], mystruct['banana'], mystruct['cucumber'], ...).

<i>Callback Signature</i><br>
<tt> public any function callback( accumulatedvalue, value, index, collection ){} </tt>

<i>Usage</i>

	// Define the callback
	public string function concatValues( previous, current, index, data ){
		return previous & current;
	}
	
	// Create the Collections object
	c = new Collections();
	
	// Our collection to reduce
	data = {'apple'='a','banana'='b','cucumber'='c'};
	
	// Reduce the collection
	c.reduce( data, concatValues );
	
	// Returns
	// "abc"
	
	// Alternative call w/ initial value
	c.reduce( data, concatValues, "Z" );
	
	// Returns
	// "Zabc"

	
##public any function reduceRight( data, callback [, initialvalue ] )
Executes the provided callback for each element in the collection 
(from right to left) passing in the value from the previous execution (the accumulatedValue), 
the value of the current index, the index itself and the originaly 
provided collection. Use this method to reduce a collection to a single 
value. Structure collections will be iterated over by key name in 
descending order(i.e. ..., mystruct['cucumber'], mystruct['banana'], mystruct['apple']).

<i>Callback Signature</i><br>
<tt> public any function callback( accumulatedvalue, value, index, collection ){} </tt>

<i>Usage</i>

	// Define the callback
	public string function concatValues( previous, current, index, data ){
		return previous & current;
	}
	
	// Create the Collections object
	c = new Collections();
	
	// Our collection to reduce
	data = {'apple'='a','banana'='b','cucumber'='c'};
	
	// Reduce the collection from the right
	c.reduceRight( data, concatValues );
	
	// Returns
	// "cba"
	
	// Alternative call w/ initial value
	c.reduce( data, concatValues, "Z" );
	
	// Returns
	// "Zcba"

	 
##public void function forEach( data, callback )
Applies the provided callback on each item in the collection. 

It's important to note that while no data is returned from this function, your provided
collection could be mutated inside of the callback. Structures are pass-by-reference in both 
Railo and Adobe Coldfusion and thus are subject to modification. Arrays however are 
<b>pass-by-value in Adobe CF, but are pass-by-reference in Railo</b>.

A good rule of thumb would be to not directly update the provided collection in your callback.
 

<i>Callback Signature</i><br>
<tt> public void function callback( value, index, collection ){} </tt>

<i>Usage</i>

	// Define the callback
	public void function justAandB( value, index, data ){
		data[index] = value < 4 ? "a" : "b";
	}
	
	// Create the Collections object
	c = new Collections();
	
	// Our collection to reduce
	data = [1,2,3,4,5,6];
	
	// Iterate over the collection
	c.foreach( data, justAandB );
	
	// Mutated collection is now
	// ["a","a","a","b","b","b"]


##public any function filter( data, callback )
Returns a filtered collection of items that pass the "test" from the 
provided callback.

<i>Callback Signature</i><br>
<tt> public boolean function callback( value, index, collection ){} </tt>

<i>Usage</i>

	// Define the callback
	public boolean function greaterThan25( value, index, data ){
		return value > 25;
	}
	
	// Create the Collections object
	c = new Collections();
	
	// Our collection to filter
	data = [8,55,16,100,358,2,-6,25];
	
	// Filter the collection
	c.filter( data, greaterThan25 );
	
	// Returns
	// [55,100,358]

	

##public boolean function some( data, callback )
Returns true if at least one item in the collection passes the "test" 
from the provided callback.

<i>Callback Signature</i><br>
<tt> public boolean function callback( value, index, collection ){} </tt>

<i>Usage</i>

	// Define the callback
	public boolean function hasZero( value, index, data ){
		return value == 0;
	}
	
	// Create the Collections object
	c = new Collections();
	
	// Our collection to reduce
	data = [1,1,1,1,1,0,1];
	
	// Test for some zeros
	c.some( data, hasZero );
	
	// Returns
	// true

	


##public boolean function every( data, callback )
Returns true if all of the items in the collection pass the "test" from 
the provided callback.

<i>Callback Signature</i><br>
<tt> public boolean function callback( value, index, collection ){} </tt>

<i>Usage</i>

	// Define the callback
	public boolean function hasZero( value, index, data ){
		return value == 0;
	}
	
	// Create the Collections object
	c = new Collections();
	
	// Our collection to reduce
	data = [1,1,1,1,1,0,1];
	
	// Test for all zeros
	c.every( data, hasZero );
	
	// Returns
	// false
