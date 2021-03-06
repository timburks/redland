//
//  RedlandStreamEnumerator.h
//  Redland Objective-C Bindings
//  $Id: RedlandStreamEnumerator.h 307 2004-11-02 11:24:18Z kianga $
//
//  Copyright 2004 Rene Puls <http://purl.org/net/kianga/>
//
//  This file is available under the following three licenses:
//   1. GNU Lesser General Public License (LGPL), version 2.1
//   2. GNU General Public License (GPL), version 2
//   3. Apache License, version 2.0
//
//  You may not use this file except in compliance with at least one of
//  the above three licenses. See LICENSE.txt at the top of this package
//  for the complete terms and further details.
//
//  The most recent version of this software can be found here:
//  <http://purl.org/net/kianga/latest/redland-objc>
//
//  For information about the Redland RDF Application Framework, including
//  the most recent version, see <http://librdf.org/>.
//

#import <Foundation/Foundation.h>

@class RedlandStream, RedlandNode;

/*!
	@header RedlandStreamEnumerator.h
	Defines the RedlandStreamEnumerator class.
*/

typedef enum _RedlandStreamEnumeratorModifier {
    RedlandReturnStatements = 0,
    RedlandReturnSubjects = 1,
    RedlandReturnPredicates = 2,
    RedlandReturnObjects = 3
} RedlandStreamEnumeratorModifier;


/*!
	@class RedlandStreamEnumerator
	@abstract Provides an NSEnumerator-based interface for RedlandStreams.
*/
@interface RedlandStreamEnumerator : NSEnumerator {
    RedlandStream *stream;
    BOOL firstIteration;
    RedlandStreamEnumeratorModifier modifier;
}
- (id)initWithRedlandStream:(RedlandStream *)aStream;
- (id)initWithRedlandStream:(RedlandStream *)aStream modifier:(RedlandStreamEnumeratorModifier)aModifier;
/*!
	@method currentContext
	@abstract Returns the context of the current statement.
*/
- (RedlandNode *)currentContext;
@end
