Extension { #name : #BlTransformationBuilder }

{ #category : #'*BlocPac-PannableAndZoomable' }
BlTransformationBuilder >> applyOnChildren [
	"Replace element's children transformation chain with our new one that we just have built"
	| anElementTransformation |

	anElementTransformation := BlElementLocalTransformation with: transformation.
	target childrenTransformation: anElementTransformation
]
