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
		
		var results  = c.map( data, multiplyBy21 );
		
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
		
		trace( results );
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
		var target = ["a","a","a","b","b","b"];
		
		c.foreach( data, justAandB);
		
		assertEquals(target, data);
		
		
		// structure collections
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
	
	
	
// ================================================================
// Callbacks used for the tests
// ================================================================
	
	private numeric function multiplyBy21( value, index, data){
		return value * 21;
	}
	private numeric function multiplyAgeBy20( value, index, data){
		return value.age * 20;
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

	private void function justAandB( value, index, data ){
		data[index] = value < 4 ? "a" : "b";
	}
	
}