(load "Redland")

(global RedlandRDFXMLParserName "rdfxml")
(global RedlandRDQLLanguageName "rdql")
(global RDFXMLTestDataLocation "http://www.w3.org/1999/02/22-rdf-syntax-ns")
(global RDFXMLTestData ((NSString alloc) initWithContentsOfFile:"test/rdf-syntax.rdf"))

(class QueryTests is NuTestCase
     (ivars) (ivar-accessors)
     (- setup is
        (set @parser (RedlandParser parserWithName:RedlandRDFXMLParserName))
        (set @model (RedlandModel model))        
        (set @uri (RedlandURI URIWithString:RDFXMLTestDataLocation))
        (@parser parseString:RDFXMLTestData intoModel:@model withBaseURI:@uri)
        (assert_true (> (@model size) 0)))
     
     (- (void)_fixme_testBadQuery is
        (set queryString "This is not a valid query.")
        (set query (RedlandQuery queryWithLanguageName:RedlandRDQLLanguageName
                        queryString:queryString baseURI:nil))
        (assert_throws RedlandException (query executeOnModel:@model))
        (try (query executeOnModel:@model)
             (catch (exception) (puts "caught")(puts exception))))
     
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
