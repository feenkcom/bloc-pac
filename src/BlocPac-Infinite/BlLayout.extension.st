Extension { #name : #BlLayout }

{ #category : #'*BlocPac-Infinite' }
BlLayout >> mouseWheelEvent: anEvent [
	"${method:BlInfiniteMouseScrollOrientationLimitedListener>>#mouseWheelEvent:}$
	dispatches mouse wheel event processing to layouts. Layouts decides whether and how to scroll items.
	Layouts that can handle such events may override this method."
]
