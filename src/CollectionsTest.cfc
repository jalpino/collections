component extends="mxunit.framework.TestCase" {


	// The Collection Component to test
	c = createObject("component","Collections");
	
	// ----------------------------------------------------
	// Map
	// ----------------------------------------------------
	public void function testMap(){
		
		// Array collection
		var data = [1,2,3,4,5,6];
		var target = [21,42,63,84,105,126];
		
		var results  = c.map( data, multiplyBy21, 2 );
		
		debug( results );
		assertEquals( target, results );
		
		// Structure collection
		data = {'John'={age=20},'Kelley'={age=30}, 'Nicole'={age=40}};
		target = {'John'=400,'Kelley'=600, 'Nicole'=800};
		
		results  = c.map( data, multiplyAgeBy20 );
		
		debug( results );
		assertEquals( target, results );
	}
	
	public void function testMapEmptyCollections(){
		
		// Array collection
		var data = [];
		var target = [];
		
		var results  = c.map( data, multiplyAgeBy20 );
		
		debug( results );
		assertEquals( target, results );
		
		// Structure collection
		data = {};
		target = {};
		
		results  = c.map( data, multiplyAgeBy20 );
		
		debug( results );
		assertEquals( target, results );
	}
	

		
	// ----------------------------------------------------
	// Reduce
	// ----------------------------------------------------
	public void function testReduce(){
		
		// array collection
		var data = [1,2,3,4,5,6];
		var target = 21;
		
		var results = c.reduce( data, addValues );
		
		debug( results );
		assertEquals( target, results );
	
		// structure collection
		data = {'apple'='a','banana'='b','cucumber'='c'};
		target = "abc";
		
		results = c.reduce( data, concatValues );
		
		debug( results );
		assertEquals( target, results );
	}
	
	public void function testReduceEmptyCollection(){
		
		// array collection
		var data = [];
		var target = [];
		
		var results = c.reduce( data, addValues );
		
		debug( results );
		assertEquals( target, results );
		
		// structure collection
		data = {};
		target = {};
		
		results = c.reduce( data, concatValues );
		
		debug( results );
		assertEquals( target, results );
	}

		
	// ----------------------------------------------------
	// Reduce with starting value
	// ----------------------------------------------------
	public void function testReduceWithStartVal(){
		
		//array collection
		var data = [1,2,3,4,5,6];
		var target = 31;
		
		var results = c.reduce( data, addValues, 10 );
		
		debug( results );
		assertEquals( target, results );
	
		// structure collection
		var data = {'apple'='a','banana'='b','cucumber'='c'};
		var target = "aabc";
		
		var results = c.reduce( data, concatValues, "a" );
		
		debug( results );
		assertEquals( target, results );
	}	
	public void function testReduceWithStartValWithStructEmptyCollections(){
		
		// structure collection
		var data = {};
		var target = "a";
		
		var results = c.reduce( data, concatValues, "a" );
		
		debug( results );
		assertEquals( target, results );
		
		// array collection
		data = [];
		target = 10;
		
		results = c.reduce( data, addValues, 10 );
		
		debug( results );
		assertEquals( target, results );
	}	

	
	// ----------------------------------------------------
	// Reduce Right
	// ----------------------------------------------------
	public void function testReduceRight(){
		// array
		var data = [1,2,3,4,5,6];
		var target = 21;
		
		var results = c.reduceRight( data, addValues );
		
		debug( results );
		assertEquals( target, results );
	
		// structure
		var data = {'apple'='a','banana'='b','cucumber'='c'};
		var target = "cba";
		
		var results = c.reduceRight( data, concatValues );
		
		debug( results );
		assertEquals( target, results );
	}
	public void function testReduceRightEmptyCollections(){
		
		// array
		var data = [];
		var target = [];
		
		var results = c.reduceRight( data, addValues );
		
		debug( results );
		assertEquals( target, results );
		
		// structure
		data = {};
		target = {};
		
		results = c.reduceRight( data, concatValues );
		
		debug( results );
		assertEquals( target, results );
	}

	
	// ----------------------------------------------------
	// Reduce Right with starting value
	// ----------------------------------------------------
	public void function testReduceRightWithStartVal(){
		
		// array
		var data = [1,2,3,4,5,6];
		var target = 31;
		
		var results = c.reduceRight( data, addValues, 10 );
		
		debug( results );
		assertEquals( target, results );
	
		// struct
		var data = {'apple'='a','banana'='b','cucumber'='c'};
		var target = "acba";
		
		var results = c.reduceRight( data, concatValues, "a" );
		
		debug( results );
		assertEquals( target, results );
	}
	public void function testReduceRightWithStartValEmptyCollections(){
		
		// array
		var data = [];
		var target = 10;
		
		var results = c.reduceRight( data, addValues, target );
		
		assertEquals( target, results );
		
		// structure
		data = {};
		target = "a";
		
		results = c.reduceRight( data, addValues, target );
		
		debug( results );
		assertEquals( target, results );
	}	
	

	
	// ----------------------------------------------------
	// Filter
	// ----------------------------------------------------
	public void function testFilter(){
		
		// array
		var data = [8,55,16,100,358,2,-6,25];
		var target = [55,100,358];
		
		var results = c.filter( data, greaterThan25 );
		
		debug( results );
		assertEquals( target, results );
	
	
		// structure
		data = {'a'='apple','b'='banana','c'='cucumber'};
		
		results = c.filter( data, justFruit );
		
		debug( results );
		assertTrue(  ! arrayLen(structFindValue( results,"cucumber")) );
	}
	
	public void function testFilterEmptyCollections(){
		
		// array
		var data = [];
		var target = [];
		
		var results = c.filter( data, greaterThan25 );
		
		debug( results );
		assertEquals( target, results );
	
	
		// structure
		data = {};
		target = {};
		results = c.filter( data, justFruit );
		
		debug( results );
		assertEquals( target, results );
	}


	// ----------------------------------------------------
	// Some
	// ----------------------------------------------------
	public void function testSome(){
		// arrays collection
		var data = [1,1,1,1,1,0,1];
		
		var results = c.some( data, hasZero );
		
		debug(results);
		assertTrue( results );
		
		
		// struct collection
		data = {'a'=1,'b'=1,'c'=0};
		
		results = c.some( data, hasZero );
		
		debug(results);
		assertTrue( results );
		
	}
	public void function testSomeEmptyCollections(){
		// arrays collection
		var data = [];
		
		var results = c.some( data, hasZero );
		
		debug(results);
		assertFalse( results );
		
		
		// struct collection
		var data = {};
		
		var results = c.some( data, hasZero );
		
		debug(results);
		assertFalse( results );
		
	}
	
	// ----------------------------------------------------
	// Every
	// ----------------------------------------------------
	public void function testEvery(){
		
		// array collection
		var data = [1,1,1,1,1,0,1];
		
		var results = c.every( data, isAllOnes );
		
		debug(results);
		assertFalse( results );
		
		
		// Structure collection
		data = {'a'=1,'b'=1,'c'=0};
		
		results = c.every( data, isAllOnes );
		
		debug(results);
		assertFalse( results );
	}
	public void function testEveryEmptyCollections(){
		
		// array collection
		var data = [];
		
		var results = c.every( data, isAllOnes );
		
		debug(results);
		assertFalse( results );
		
		
		// Structure collection
		data = {};
		
		results = c.every( data, isAllOnes );
		
		debug(results);
		assertFalse( results );
	}


	// ----------------------------------------------------
	// ForEach
	// ----------------------------------------------------
	public void function testForEach(){
		var data = [1,2,3,4,5,6];
		var target = 21;

		request.total = 0; // the callback updates this
		
		c.foreach( data, addValuesToAppScopeVar );
		
		assertEquals(target, request.total);
		
	}
	public void function testForEachStructs(){
		
		// Adobe and Railo both support pass by value for structs
		data = {'z'=1,'y'=2,'x'=3,'w'=4,'v'=5};
		target = {'z'='a','y'='a','x'='a','w'='b','v'='b'};
		
		c.foreach( data, justAandB);
		
		assertEquals(target, data);
		
	}
	public void function testForEachEmptyCollections(){
		var data = [];
		var target = [];
		
		c.foreach( data, justAandB);
		
		assertEquals(target, data);
		
		
		// structure collections
		data = {};
		target = {};
		
		c.foreach( data, justAandB);
		
		assertEquals(target, data);
		
	}
	
	
	// ----------------------------------------------------
	// Every
	// ----------------------------------------------------
	public void function testSort(){
		
		// array collection
		var data = [8,6,7,4,2,3,5,1,6,9];
		var target = [1,2,3,4,5,6,6,7,8,9];
		
		var results = c.sort( data, ascendingOrder );
		
		debug(results);
		assertEquals( target, results );
	
	}
	public void function testSortEmptyCollection(){
		
		// array collection
		var data = [];
		var target = [];
		
		var results = c.sort( data, ascendingOrder );
		
		debug(results);
		assertEquals( target, results );
	
	}
	
	/*public void function testSortBiggerCollection(){
		
		// array collection
		var n = 1000;
		var data = [];
		arrayResize(data, n);
		
		for(var i=1; i <= n; i++){
			data[i] = randRange(1,n);
		}	
		var results = c.sort( data, ascendingOrder );
		debug(results);
		assertTrue(true);
	
	}*/
	public void function testSortEmptyCollection(){
		
		// array collection
		var data = [];
		var target = [];
		
		var results = c.sort( data, ascendingOrder );
		
		debug(results);
		assertEquals( target, results );
	
	}
	
	
	
// ================================================================
// Callbacks used for the tests
// ================================================================
	private numeric function ascendingOrder( valA, valB ){
		return valA - valB;
	}
	
	private numeric function multiplyBy21( value, index, data){
		var val =  value * 21;
		return javacast("int",val); 
	}
	private numeric function multiplyAgeBy20( value, index, data){
		var val = value.age * 20;
		return javacast("int",val);
	}
	
	private string function justGender( value, index, data){
		return value.gender;
	}
	
	private numeric function extractValue( value, index, data){
		return value.v;
	}
	
	private string function concatValues( previous, current, index, data ){
		return previous & current;
	}
	
	private numeric function addValues( previous, current, index, data ){
		return previous + current;
	}
	
	private void function addValuesToAppScopeVar( value, index, data ){
		request.total += value;
	}
	
	private boolean function greaterThan25( value ){
		return value > 25;
	}
	
	private boolean function hasZero( value ){
		return value == 0;
	}
	
	private boolean function isAllOnes( value ){
		return value == 1;
	}

	private any function justFruit( value ){
		return value != "cucumber";
	}

	private void function justAandBComplex( value, index, data ){
		data[index] = value.z < 4 ? {'z'='a'} : {'z'='b'};
	}
	
	private void function justAandB( value, index, data ){
		data[index] = value < 4 ? "a" : "b";
	}
	
}