<!--- 

	This example uses a combination of different methods in Collections.cfc
	to find the most popular words being used in the description of the feeds
	that ColdfusionBloggers.org aggregates.
	
	Grab the Collections.cfc from my repo http://github.com/jalpino/collections
	and place it in the same folder as this example.

 --->
<html>

<head>
	<style>
		body, table, td {font:10pt normal arial;}
		.count{ width:35px; text-align:right; font-size:0.8em; color:maroon; padding-right:5px;}
		code{display:inline-block;width:60px;text-align:right;padding-right:1em;}
	</style>
</head>
<body>

<cfflush />


<!--- Create an instance of the Collections library, we will use it through out the example --->
<cfset collections = createObject("component","collections.Collections")>


<!--- -------------------------------------------------------------- --->
<!--- Obtain the dataset --->
<!--- -------------------------------------------------------------- --->

<cfset t = gettickcount()>

<!--- Get a list of the feeds that coldfusionbloggers.org aggregates --->
<cfhttp method="get" url="http://www.coldfusionbloggers.org/opml.cfm">  

<!--- Extract the blog 'items' containing the descriptions we are after --->
<cfset feedXML = xmlParse( cfhttp.filecontent )>
<cfset blogs = xmlSearch( feedXML, "/opml/body/outline")>

<cfoutput><code>#gettickcount()-t#ms</code>- Got the feed and parsed it (#arraylen(blogs)# feeds)<br></cfoutput>
<cfflush />


<!--- -------------------------------------------------------------- --->
<!--- Extract the descriptions --->
<!--- -------------------------------------------------------------- --->
<!--- Takes the description from our XML blog item and breaks it apart into an array of individual words --->
<cffunction name="getTheDescription" returnType="string">
	<cfargument name="feed" type="any">
	<cfreturn feed.XmlAttributes["description"]>
</cffunction>

<cfset t = gettickcount()>

<cfset descriptions = collections.map( blogs, getTheDescription )>

<cfoutput><code>#gettickcount()-t#ms</code>- Mapped the collection <br></cfoutput>
<cfflush />


<!--- -------------------------------------------------------------- --->
<!--- Break down the descriptions --->
<!--- -------------------------------------------------------------- --->
<!--- Breaks a description into an array of individual words --->
<cffunction name="breakApartTheWords" returnType="void">
	<cfargument name="description" type="any">
	<cfargument name="index" type="any">
	<cfargument name="collection" type="any">
	<cfset arguments.collection[ arguments.index ] = listToArray( arguments.description, " ,") >
</cffunction>

<cfset t = gettickcount()>

<cfset collections.forEach( descriptions, breakApartTheWords ) >

<cfoutput><code>#gettickcount()-t#ms</code>- ForEach'ed the collection <br></cfoutput>
<cfflush />


<!--- -------------------------------------------------------------- --->
<!--- Flatten the Heirarchy --->
<!--- -------------------------------------------------------------- --->
<cfset t = gettickcount()>

<cfset individualWords = collections.flatten( descriptions )>

<cfoutput><code>#gettickcount()-t#ms</code>- Flattened the collection (#arraylen(individualWords)# individual words)<br></cfoutput>
<cfflush />


<!--- -------------------------------------------------------------------------- --->
<!--- With the one dimensional array of individual words, lets reduce that set into --->
<!--- a new collection containing each of the counts of how many times each individual --->
<!--- words appears across all descriptions --->
<!--- -------------------------------------------------------------- --->

<!--- -------------------------------------------------------------- --->
<!--- Count each word --->
<!--- -------------------------------------------------------------- --->

<!--- Keeps track of how many times a word appears our collection --->
<cffunction name="toWordCount" returnType="struct">
	<cfargument name="wordcounts" type="any">
	<cfargument name="word" type="any">
	
	<!--- Keep track of our individual words --->
	<cfif NOT structKeyExists( arguments.wordcounts, arguments.word )>
		<cfset arguments.wordcounts[ arguments.word ] = {word=arguments.word, count=0}>
	</cfif>
			
	<!--- Bump the count for this word --->
	<cfset arguments.wordcounts[ arguments.word ].count++ >
	
	<!--- Return our word counts --->	
    <cfreturn arguments.wordcounts />
</cffunction>

<cfset t = gettickcount()>

<cfset wordCounts = collections.reduce( individualWords, toWordCount, {})>

<cfoutput><code>#gettickcount()-t#ms</code>- Reduced the collection (#arraylen(structKeyArray(wordCounts))# unique words)<br></cfoutput>
<cfflush />



<!--- -------------------------------------------------------------- --->
<!--- Ignore common words --->
<!--- -------------------------------------------------------------- --->
<!---  lets filter out some common words, articles and symbols
from the collection so that we end up with more meaningful results. We can remove
items from a collection using either the filter() or reject() methods. Filter keeps
items that 'pass the test', where as reject() keeps those ' --->

<cffunction name="nonCommonWords" returnType="boolean">
	<cfargument name="wordcount" type="any">
	<cfargument name="word" type="any">

	<cfreturn ! listFindNoCase("will,at,are,be,my,all,as,it,on,for,in,an,and,the,a,of,is,I,or,too,to,this,with,from,by,that,+,-,--,=,/,*,&", arguments.word) />
</cffunction>

<cfset t = gettickcount()>

<cfset wordCounts = collections.filter( wordCounts, nonCommonWords )>

<cfoutput><code>#gettickcount()-t#ms</code>- Filtered the collection (#arraylen(structKeyArray(wordCounts))# unique words)<br></cfoutput>
<cfflush />


<!--- -------------------------------------------------------------- --->
<!--- Now that we have counted how many times each individual word --->
<!--- appears in the descriptions, we can easily find the most popular --->
<!--- one by using the max() method --->
<!--- -------------------------------------------------------------- --->

<!--- -------------------------------------------------------------- --->
<!--- Most Popular Word --->
<!--- -------------------------------------------------------------- --->

<!--- Returns the word count so it can be used for rank --->
<cffunction name="compareByCount" returnType="numeric">
	<cfargument name="wordAndCount" type="any">
	<cfargument name="word" type="any">
	<cfreturn wordAndCount.count  />
</cffunction>

<cfset t = gettickcount()>

<cfset mostPopular = collections.max( wordCounts, compareByCount )>

<cfoutput><code>#gettickcount()-t#ms</code>- The most popular word was <b>"#mostPopular.index#"</b> and was used <b>#mostPopular.value.count#</b> times<br></cfoutput>
<cfflush />



<!--- -------------------------------------------------------------- --->
<!--- Top 10 Popular Words --->
<!--- -------------------------------------------------------------- --->
<!--- In order for to get the most popular words 

--->
<cffunction name="intoAnArray" returnType="array">
	<cfargument name="wordCounts" type="any">
	<cfargument name="wordAndCount" type="any">
	
	<!--- add the word and it's count to the new collection --->
	<cfset arrayAppend( arguments.wordCounts, arguments.wordAndCount )>
	
	<cfreturn arguments.wordCounts />
</cffunction>

<cfset t = gettickcount()>

<cfset wordCountArray = collections.reduce( wordCounts, intoAnArray, [])> 

<cfoutput><code>#gettickcount()-t#ms</code>- Reduced the collection<br></cfoutput>
<cfflush />

<!--- -------------------------------------------------------------- --->
<!--- Lets sort the collection --->
<!--- -------------------------------------------------------------- --->
<cffunction name="sortByCount" returnType="numeric">
	<cfargument name="word1" type="any">
	<cfargument name="word2" type="any">
	
	<cfreturn word2.count - word1.count />
</cffunction>

<cfset t = gettickcount()>

<cfset sortedWordCount = collections.sort( wordCountArray, sortByCount)>

<cfoutput><code>#gettickcount()-t#ms</code>- Sorted the collection<br></cfoutput>
<cfflush />


<!--- -------------------------------------------------------------- --->
<!--- Display The top ten most popular words --->
<!--- -------------------------------------------------------------- --->
<cfoutput>
	
	<h2>Top 40 Most Popular words</h2>
	<table cellspacing="4" cellpadding="0" border="0">
	<tr>
	<cfloop from="1" to="4" index="col">
		<td>
			<table cellspacing="4" cellpadding="0" border="0">
			<cfloop from="#(10 * col) - 9#" to="#(10 * col)#" index="i">
			<tr>
				<td class="count">#sortedWordCount[i].count#</td>
				<td>#rereplace(sortedWordCount[i].word, '^(\w)(.*)', '\u\1\2')#</td>
			</tr>
			</cfloop>
			</table>
		</td>
	</cfloop>	
	</tr>
	</table>

</body>
</html>
</cfoutput>





