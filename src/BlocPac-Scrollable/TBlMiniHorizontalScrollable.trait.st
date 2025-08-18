"
I define a minimum API from {{gtClass:TBlScrollable}}. 
"
Trait {
	#name : #TBlMiniHorizontalScrollable,
	#category : #'BlocPac-Scrollable-Core'
}

{ #category : #'api - scrolling testing' }
TBlMiniHorizontalScrollable >> canScrollHorizontally [
	"Return true if I can scroll the current contents horizontally, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'api - scrolling testing' }
TBlMiniHorizontalScrollable >> canScrollVertically [
	"Return true if I can scroll the current contents vertically, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - scrolling thumb' }
TBlMiniHorizontalScrollable >> computeHorizontalScrollExtent [
	"Compute the horizontal extent of the horizontal scrollbar's thumb within the horizontal range.
	This value is used to compute the length of the thumb within the scrollbar's track.
	The extent is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollRange and #computeHorizontalScrollOffset.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	<return: #Number>
	
	^ 0
]

{ #category : #'api - scrolling thumb' }
TBlMiniHorizontalScrollable >> computeHorizontalScrollOffset [
	"Compute the horizontal offset of the horizontal scrollbar's thumb within the horizontal range.
	The offset is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollExtent and #computeHorizontalScrollRange.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	<return: #Number>
	
	^ 0
]

{ #category : #'api - scrolling thumb' }
TBlMiniHorizontalScrollable >> computeHorizontalScrollRange [
	"Compute the horizontal range that the horizontal scrollbar represents.
	The range is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollExtent and #computeHorizontalScrollOffset.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	<return: #Number>
	
	^ 0
]

{ #category : #'api - scrolling notifying' }
TBlMiniHorizontalScrollable >> dispatchOnScrolled: aPoint [
	
	self onScrolled: aPoint.
	self notifyScrolled: aPoint
]

{ #category : #'api - scrolling notifying' }
TBlMiniHorizontalScrollable >> notifyScrolled: aPoint [
	"Notify all event handlers that InfiniteElemnet scrolled by a delta point"

	self eventDispatcher dispatchScrolled: aPoint
]

{ #category : #'api - scrolling notifying' }
TBlMiniHorizontalScrollable >> onScrolled: aPoint [
	"Sent when the scroll position of this InfiniteElement changes. Subclasses should use
	this method to respond to scrolling within the datasource's data set instead of an explicit event handler.
	I will always be invoked before event handlers. If a subclass needs to perform any additional upkeep
	or bookkeeping after scrolling but before events fired, this is a good place to do so"
]

{ #category : #'api - scrolling' }
TBlMiniHorizontalScrollable >> scrollBy: aPoint [
	^ self scrollHorizontallyBy: aPoint x
]

{ #category : #'api - scrolling' }
TBlMiniHorizontalScrollable >> scrollHorizontallyBy: aNumber [
	"Scroll horizontally by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."

	<return: #Number>
	^ 0
]
