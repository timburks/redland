(load "Redland")

(class ModelTests is NuTestCase
     (- testSimple is
        (set subject (RedlandNode nodeWithBlankID:"foo"))
        (set predicate (RedlandNode nodeWithURIString:"foo:bar"))
        (set object (RedlandNode nodeWithLiteral:"test"))
        (set model (RedlandModel model))
        (assert_true model)
        (set testStatement (RedlandStatement statementWithSubject:subject
                                predicate:predicate
                                object:object))
        (model addStatement:testStatement)
        (assert_equal 1 (model size))
        (assert_true (model containsStatement:testStatement))
        (assert_equal subject (model sourceWithArc:predicate target:object))
        (assert_equal predicate (model arcWithSource:subject target:object))
        (assert_equal object (model targetWithSource:subject arc:predicate))
        (assert_true (model node:object hasIncomingArc:predicate))
        (assert_true (model node:subject hasOutgoingArc:predicate))
        (model removeStatement:testStatement)
        (assert_false (model containsStatement:testStatement)))
     
     (- testContextAddStatementBug is
        (set subject (RedlandNode nodeWithBlankID:"foo"))
        (set predicate (RedlandNode nodeWithURIString:"foo:bar"))
        (set object (RedlandNode nodeWithLiteral:"test"))
        (set model (RedlandModel model))
        (assert_true model)
        (set testStatement (RedlandStatement statementWithSubject:subject
                                predicate:predicate
                                object:object))
        (model addStatement:testStatement withContext:nil)))