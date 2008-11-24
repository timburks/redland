
(load "Redland")

(global M_PI 3.1415927)

(class NodeTests is NuTestCase
     
     (- testLiteral is
        (set string "Hello world")
        (set language "en")
        (set typeURI (RedlandURI URIWithString:"http://foo/"))
        (set node (RedlandNode nodeWithLiteral:string language:language type:typeURI))
        (assert_true node)
        (assert_true (node isLiteral))
        (assert_equal string (node literalValue))
        (assert_equal language (node literalLanguage))
        (assert_equal typeURI (node literalDataType))
        (assert_false (node isXML)))
     
     (- testLiteralXML is
        (set string "<hello>world</hello>")
        (set language "en")
        (set node (RedlandNode nodeWithLiteral:string language:language isXML:YES))
        (assert_true node)
        (assert_true (node isLiteral))
        (assert_equal string (node literalValue))
        (assert_equal language (node literalLanguage))
        (assert_true (node isXML))
        )
     
     (- testBlank is
        (set string "myBlankId")
        (set node (RedlandNode nodeWithBlankID:string))
        (assert_true node)
        (assert_true (node isBlank) nil)
        (assert_equal string (node blankID)))
     
     
     (- testBlankRandom is
        (set node1 (RedlandNode nodeWithBlankID:nil))
        (assert_true node1)
        (set node2 (RedlandNode nodeWithBlankID:nil))
        (assert_true node2)
        (assert_false (node1 isEqual:node2))
        )
     
     (- (void)testResource is
        (set uri (RedlandURI URIWithString:"http://foo.com/"))
        (set node (RedlandNode nodeWithURI:uri))
        (assert_true node)
        (assert_true (node isResource))
        (assert_equal uri (node URIValue))
        )
     
     (- (void)testNodeEquality is
        (set url1 "http://foo.com/")
        (set url2 "http://foo.com/#bar")
        (set url3 "http://foo.com/")
        (set node1 (RedlandNode nodeWithURIString:url1))
        (set node2 (RedlandNode nodeWithURIString:url2))
        (set node3 (RedlandNode nodeWithURIString:url3))
        (assert_false (node1 isEqual:node2))
        (assert_equal node1 node3)
        )
     
     (- (void)testLiteralInt is
        (set node (RedlandNode nodeWithLiteralInt:12345))
        (assert_equal 12345 (node intValue))
        (set node (RedlandNode nodeWithLiteral:"12345" language:nil isXML:NO))
        ;;STAssertThrowsSpecific((node intValue) RedlandException)
        )
     
     (- (void)testLiteralString is
        (set string "Hello world")
        (set node (RedlandNode nodeWithLiteralString:string language:"en"))
        (assert_equal string (node stringValue))
        (set node (RedlandNode nodeWithLiteral:string language:"en" isXML:NO))
        ;;STAssertThrowsSpecific((node stringValue) RedlandException)
        )
     
     (- (void)testLiteralBool is
        (set node (RedlandNode nodeWithLiteralBool:YES))
        (assert_true (node boolValue))
        (set node (RedlandNode nodeWithLiteral:"true" language:"en" isXML:NO))
        ;;STAssertThrowsSpecific((node boolValue) RedlandException)
        )
     
     (- (void)testLiteralFloatDouble is
        (set floatNode (RedlandNode nodeWithLiteralFloat:M_PI))
        (set doubleNode (RedlandNode nodeWithLiteralDouble:M_PI))
        ;;STAssertEqualsWithAccuracy((float)M_PI (floatNode floatValue) 0.1)
        ;;STAssertEqualsWithAccuracy((double)M_PI (floatNode doubleValue) 0.1)
        ;;STAssertThrowsSpecific((float)(doubleNode floatValue) RedlandException)
        ;;STAssertEqualsWithAccuracy((double)M_PI (doubleNode doubleValue) 0.1)
        )
     
     (- (void)testLiteralDateTime is
        (set date (NSDate date))
        (set node (RedlandNode nodeWithLiteralDateTime:date))
        (assert_true node)
        ;;STAssertEqualsWithAccuracy((float)0.0f (float)(date timeIntervalSinceDate:(node dateTimeValue)) 1.0f)
        (set node (RedlandNode nodeWithLiteralString:"2004-09-16T20:36:18Z" language:nil))
        ;;STAssertThrowsSpecific((node dateTimeValue) RedlandException)
        )
     
     (- (void)testArchiving is
        (set sourceNode (RedlandNode nodeWithLiteralString:"Hello world" language:"en"))
        (set data (NSArchiver archivedDataWithRootObject:sourceNode))
        (assert_true data)
        (set decodedNode (NSUnarchiver unarchiveObjectWithData:data))
        (assert_true decodedNode)
        (assert_equal sourceNode decodedNode)
        )
     
     (- (void)testNodeValueConversion is
        ;; The following test won't work because there seems to be no way to
        ;; distinguish a boolean NSNumber from an int NSNumber...
        ;;    UKObjectsEqual((RedlandNode nodeWithLiteralBool:YES)
        ;;                   (RedlandNode nodeWithObject:(NSNumber numberWithBool:YES)))
        (assert_equal (RedlandNode nodeWithLiteralInt:12345) (RedlandNode nodeWithObject:(NSNumber numberWithInt:12345)))
        (assert_equal (RedlandNode nodeWithLiteralString:"foo" language:nil) (RedlandNode nodeWithObject:"foo"))
        (assert_equal (RedlandNode nodeWithURL:(NSURL URLWithString:"http://foo")) (RedlandNode nodeWithObject:(NSURL URLWithString:"http://foo")))
        (assert_equal (RedlandNode nodeWithLiteralDateTime:(NSDate dateWithTimeIntervalSinceReferenceDate:0)) (RedlandNode nodeWithObject:(NSDate dateWithTimeIntervalSinceReferenceDate:0)))
        ))
