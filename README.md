Collections.cfc
==================
Collections.cfc is a library of iteration methods for Coldfusion arrays and structures.

Tested on Railo3.2 and Adobe CF9

##public any function map( data, callback )
Create a new collection by executing the provided callback on each element 
in the provided collection

<i>Callback Signature</i><br>
<tt> public any function callback( value, index, collection ){} </tt>

<i>Usage</i>
<code>
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
</code>

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
<code>
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
</code>	
	
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
<code>
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
</code>	
	 
##public void function forEach( data, callback )
Applies the provided callback on each item in the collection

<i>Callback Signature</i><br>
<tt> public any function callback( value, index, collection ){} </tt>

<i>Usage</i>
<code>
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
</code>

##public any function filter( data, callback )
Returns a filtered collection of items that pass the "test" from the 
provided callback.

<i>Callback Signature</i><br>
<tt> public any function callback( value, index, collection ){} </tt>

<i>Usage</i>
<code>
// Define the callback
public void function greaterThan25( value, index, data ){
	data[index] = value < 4 ? "a" : "b";
}

// Create the Collections object
c = new Collections();

// Our collection to reduce
data = [8,55,16,100,358,2,-6,25];

// Filter the collection
c.filter( data, greaterThan25 );

// Returns
// [55,100,358]
</code>	
	

##public boolean function some( data, callback )
Returns true if at least one item in the collection passes the "test" 
from the provided callback.

<i>Callback Signature</i><br>
<tt> public any function callback( value, index, collection ){} </tt>

<i>Usage</i>
<code>
// Define the callback
public boolean function hasZero( value ){
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
</code>
	


##public boolean function every( data, callback )
Returns true if all of the items in the collection pass the "test" from 
the provided callback.

<i>Callback Signature</i><br>
<tt> public any function callback( value, index, collection ){} </tt>

<i>Usage</i>
<code>
// Define the callback
public boolean function hasZero( value ){
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
</code>

