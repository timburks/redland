(load "Redland")

(global RedlandRDFXMLParserName "rdfxml")
(global RedlandRDQLLanguageName "rdql")
(global RDFXMLTestDataLocation "http://www.w3.org/1999/02/22-rdf-syntax-ns")
(global RDFXMLTestData ((NSString alloc) initWithContentsOfFile:"test/rdf-syntax.rdf"))

(class PostgreSQLTests is NuTestCase
     (ivars) (ivar-accessors)
     
     (- setup is
        (set @parser (RedlandParser parserWithName:RedlandRDFXMLParserName))
        (set @storage ((RedlandStorage alloc)
                       initWithFactoryName:"postgresql" identifier:"dbl"
                       options:"new='yes',host='localhost',database='red',user='postgres',password=''"))
        (set @model ((RedlandModel alloc) initWithStorage:@storage))
        (set @uri (RedlandURI URIWithString:RDFXMLTestDataLocation))
        (@parser parseString:RDFXMLTestData intoModel:@model withBaseURI:@uri)
        (assert_true (> (@model size) 0)))
     
     (- (void)testQueryAll is
        (set queryString "SELECT ?s ?p ?o WHERE (?s ?p ?o)")
        (set query (RedlandQuery queryWithLanguageName:RedlandRDQLLanguageName queryString:queryString baseURI:nil))
        (assert_true query)
        (set results (query executeOnModel:@model))
        (assert_true results)
        (if results
            (assert_equal 3 (results countOfBindings))
            (set allResults ((results resultEnumerator) allObjects))
            (assert_equal (@model size) (allResults count))))
     
     (- testSimpleQuery is
        (set queryString "SELECT ?s ?o WHERE (?s <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ?o)")
        (set query (RedlandQuery queryWithLanguageName:RedlandRDQLLanguageName queryString:queryString baseURI:nil))
        (assert_true query)
        (set results (query executeOnModel:@model))
        (assert_true results)
        (if results
            (assert_equal 2 (results countOfBindings))
            (set allResults ((results resultEnumerator) allObjects))
            ;(allResults each:(do (result) (puts (result description))))
            (assert_true (> (allResults count) 0)))))