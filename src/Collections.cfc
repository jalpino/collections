/**
 * Iteration functions for mapping/reducing/filtering/etc Coldfusion 
 * collections (Arrays, Structures and Queries). These methods attempt
 * to follow their counterparts outlined in ECMA-262, 5th edition
 * 
 * http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-262.pdf
 * 
 * Justin Alpino (twitter: @jalpino)
 * April 27, 2011
 * 
 */
component {
	
	
	/**
	 * Create a new collection by executing the provided callback on each 
	 * element in the provided collection
	 * 
	 * @param data     a collection of data, can be a struct or an array
	 * 
	 * @param callback the function to be applied on each item of the provided
	 *                 collection
	 * 
	 * @return         a collection containing the results of  your callback 
	 * 				   for each item (array collections return arrays, struct
	 * 				   collections return structs)
	 **/
	 public any function map( required any data, required any callback ){
	 	
	 	if( ! isCustomFunction(callback) )
	 		throw( type="TypeError", message="callback is not a function" );
	 	 		
		var v = 0;	
	 	var k = 0;
		var dlen = _size(arguments.data);
		var isArr = isArray(arguments.data);
		var retData = isStruct(arguments.data) ? {} : [];
		
		var keys =  isArr ? arguments.data : structKeyArray(arguments.data);
		
		for( var i = 1; i <= dlen; i++ ){
			k = isArr ? i : keys[i];
			v = arguments.data[k];
			retData[k] = arguments.callback( v, k, arguments.data );
		}
		
		return retData;
	}
	
	
	/**
	 * Applies the provided callback on each item in the collection
	 * 
	 * @param data     a collection of data, can be a struct or an array 
	 * 
	 * @param callback the function to be applied on each item of the provided
	 *                 collection
	 **/
	 public void function forEach( required any data, required any callback ){
	 	
	 	if( ! isCustomFunction(callback) )
	 		throw( type="TypeError", message="callback is not a function" );
	 		
		var v = 0;	
	 	var k = 0;
		var dlen = _size(arguments.data);
		var isArr = isArray(arguments.data);
		
		var keys =  isArr ? arguments.data : structKeyArray(arguments.data);
		
		for( var i = 1; i <= dlen; i++ ){
			k = isArr ? i : keys[i];
			v = arguments.data[k];
			arguments.callback( v, k, arguments.data );
		}
	}
	
	
	/**
	 * Executes the provided callback for each element in the collection 
	 * (from left to right) passing in the value from the previous execution, 
	 * the value of the current index, the index itself and the original 
	 * provided collection. Use this method to reduce a collection to a single 
	 * value. Structure collections will be iterated by key name in ascending 
	 * order (i.e. mystruct['apple'], mystruct['banana'], mystruct['cucumber'], ...).
	 * 
	 * @param data     		a collection of data, can be a struct or an array  
	 * 
	 * @param callback 		the function builds the accumulated value by being 
	 *						applied on each item of the provided collection
	 * 
	 * @param initialvalue  an initial value to use instead of the first item 
	 * 						of the provided collection (optional)
	 * 
	 * @return        		a value accumulated by each successive iteration
	 * 
	 **/
	public any function reduce( required any data, required any callback ){
		
		if( ! isCustomFunction(callback) )
	 		throw( type="TypeError", message="callback is not a function" );
	 	
	 	var v = 0;	
	 	var k = 0;
	 	var i = 1;
		var dlen = _size(arguments.data);
		var isArr = isArray(arguments.data);
		var accumulator = arraylen(arguments) > 2 ? arguments[3] : (isArr ? [] : {});
		var skeys = [];
		
		if( ! dlen )
			return accumulator;
		
		if( ! isArr ){
			skeys =  structKeyArray(arguments.data);
			arraySort(skeys,"textnocase","asc");
		}
		
		if( arraylen(arguments) <= 2 )
			accumulator = arguments.data[( isArr ? i++ : skeys[i++] )];
		
		for( ; i <= dlen; i++ ){
			k = isArr ? i : skeys[i];
			v = arguments.data[k];
			accumulator = callback( accumulator, v, k, arguments.data);
		}
		
		return accumulator;
	}


	/**
	 * Executes the provided callback for each element in the collection 
	 * (from right to left) passing in the value from the previous execution, 
	 * the value of the current index, the index itself and the originaly 
	 * provided collection. Use this method to reduce a collection to a single 
	 * value. Structure collections will be iterated over by key name in 
	 * descending order(i.e. ..., mystruct['cucumber'], mystruct['banana'], mystruct['apple']).
	 * 
	 * @param data     		a collection of data, can be a struct or an array  
	 * 
	 * @param callback 		the function builds the accumulated value by being 
	 * 						applied on each item of the provided collection
	 * 
	 * @param initialvalue  an initial value to use instead of the first item 
	 * 						of the provided collection
	 * 
	 * @return        		a value accumulated by each successive iteration
	 * 
	 **/
	public any function reduceRight( required any data, required any callback ){
		
		if( ! isCustomFunction(callback) )
	 		throw( type="TypeError", message="callback is not a function" );
	 	
	 	var v = 0;	
	 	var k = 0;
		var dlen = _size(arguments.data);
		var isArr = isArray(arguments.data);
		var accumulator = arraylen(arguments) > 2 ? arguments[3] : (isArr ? [] : {});
		var i = dlen;
		var skeys = [];
				
		if( !dlen )
			return accumulator;
		
		if( ! isArr ){
			skeys = structKeyArray(arguments.data);
			arraySort(skeys,"textnocase","asc");
		}
		
		if( arraylen(arguments) <= 2 )
			accumulator = arguments.data[( isArr ? i-- : skeys[i--] )];
		
		for( ; i > 0; i-- ){
			k = isArr ? i : skeys[i];
			v = arguments.data[k];
			accumulator = callback( accumulator, v, k, arguments.data);
		}
		
		return accumulator;
	}	
	
	
	/**
	 * Returns a filtered collection of items that pass the "test" from the 
	 * provided callback.
	 * 
	 * @param data      a collection of data, can be a struct or an array
	 * 
	 * @param callback  the function used to "test" items in the provided 
	 * 					collection for inclusion in the returned collection
	 * 
	 * @return          a filtered collection( array collections return arrays, 
	 * 					struct collections return structs)
	 **/
	public any function filter( required any data, required any callback ){
		
		if( ! isCustomFunction(callback) )
	 		throw( type="TypeError", message="callback is not a function" );
	 	
		var v = 0;
		var k = 0;
		var dlen = _size(arguments.data);
		var isArr = isArray(arguments.data);
		var retData = isArr ? [] : {};
		
		if( ! dlen )
			return retData;
			
		var keys =  isArr ? arguments.data : structKeyArray(arguments.data);

		for( var i = 1; i <= dlen; i++ ){
			k = isArr ? i : keys[i];
			v = arguments.data[ k ];
			if( callback( v, k, arguments.data ) ){
				if( isArr )
					arrayAppend(retData, v);
				else
					retData[k] = v;
			}
		}
			
		return retData;
	}
	
	
	/**
	 * Returns true if at least one item in the collection passes the "test" 
	 * from the provided callback.
	 * 
	 * @param data     	a collection of data, can be a struct or an array 
	 * 
	 * @param callback 	the method used to "test" items in the provided 
	 * 					collection
	 * 
	 * @return          true if at least one item in the collection passes, 
	 * 					false otherwise
	 **/
	public boolean function some( required any data, required any callback ){
		if( ! isCustomFunction(callback) )
	 		throw( type="TypeError", message="callback is not a function" );
	 		
		var v = 0;
		var k = 0;
		var dlen = _size(arguments.data);
		var isArr = isArray(arguments.data);
		
		if( ! dlen )
			return false;
			
		var keys =  isArr ? arguments.data : structKeyArray(arguments.data);
		
		for( var i = 1; i <= dlen; i++ ){
			k = isArr ? i : keys[i];
			v = arguments.data[ k ];
			if( callback( v, k, arguments.data ) )
				return true;
		}
		
		return false;
	}
	
	
	/**
	 * Returns true if all of the items in the collection pass the "test" from 
	 * the provided callback.
	 * 
	 * @param data     	a collection of data, can be a struct or an array 
	 * 
	 * @param callback 	the method used to "test" items in the provided 
	 * 					collection
	 * 
	 * @return          true if all items in the collection pass, false 
	 * 					otherwise
	 **/
	public boolean function every( required any data, required any callback ){
		
		if( ! isCustomFunction(callback) )
	 		throw( type="TypeError", message="callback is not a function" );

		var v = 0;
		var k = "";
		var dlen = _size(arguments.data);
		var isArr = isArray(arguments.data);
		if( ! dlen )
			return false;
			
		var keys =  isArr ? arguments.data : structKeyArray(arguments.data);
		
		for( var i = 1; i <= dlen; i++ ){
			k = isArr ? i : keys[i];
			v = arguments.data[ k ];
			if( ! callback( v, k, arguments.data ) )
				return false;
		}	
			
		return true;
	}
	
	
	
	/**
	 * Returns the size of the supplied collection
	 **/
	private numeric function _size( required any data ){
		if( isArray(arguments.data) )
			return arrayLen(arguments.data);
			
		if( isStruct(arguments.data) )
			return structCount(arguments.data);
			
		throw( type="TypeError", message="Invalid collection type", detail="The collection that you have passed is not a valid Arrays and Structure.");
	}
				
}