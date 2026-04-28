"
I contain examples of the spline overscroller

"
Class {
	#name : #BlOvershootingSplineBasedScrollerExamples,
	#superclass : #Object,
	#category : #'BlocPac-Scrollable-Examples'
}

{ #category : #'examples - overshot' }
BlOvershootingSplineBasedScrollerExamples >> _1_flingWithOvershot [
	<gtExample>
	<return: #BlOvershootingSplineBasedScroller>
	| aSplineOverScroller |
	aSplineOverScroller := self splineOverScroller.
	aSplineOverScroller time: (BlTime simulated date: self exampleDate).
	aSplineOverScroller
		fling: 1000
		start: 150
		min: 100
		max: 200
		over: 50.

	self assert: aSplineOverScroller currentVelocity equals: 1000.0.
	self assert: aSplineOverScroller currentPosition equals: 150.
	self
		assert: aSplineOverScroller currentStep
		equals: BlSplineOverScrollerStep spline.
	self assert: aSplineOverScroller deceleration equals: 0.0.
	self assert: aSplineOverScroller duration equals: 50 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 200.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 150.
	self assert: aSplineOverScroller startTime equals: self exampleDate.
	self assert: aSplineOverScroller startVelocity equals: 1000.

	^ aSplineOverScroller
]

{ #category : #'examples - overshot' }
BlOvershootingSplineBasedScrollerExamples >> _2_flingMovingToTheEdge [
	<gtExample>
	<toReview>
	<return: #BlOvershootingSplineBasedScroller>
	| aSplineOverScroller expectedPositions expectedVelocities theActualPositions theActualVelocities |
	aSplineOverScroller := self _1_flingWithOvershot.

	expectedPositions := {150.
			155.
			160.
			165.
			170.
			175.
			180.
			185.
			190.
			194.
			199}.
	expectedVelocities := {1000.0.
			999.54034.
			997.88873.
			997.88873.
			992.5039.
			984.4191.
			984.4191.
			973.8018.
			973.8018.
			962.2275.
			947.04535}.

	theActualPositions := OrderedCollection new.
	theActualVelocities := OrderedCollection new.

	aSplineOverScroller time
		every: 5 milliSeconds
		while: [ aSplineOverScroller update ]
		do: [ theActualPositions add: aSplineOverScroller currentPosition.
			theActualVelocities add: aSplineOverScroller currentVelocity ].
	self assert: theActualPositions asArray equals: expectedPositions.

	theActualVelocities
		with: expectedVelocities
		do: [ :anActual :anExpected | self assert: (anActual closeTo: anExpected precision: 0.0017) ].

	self
		assert: (aSplineOverScroller currentVelocity closeTo: 947.04535 precision: 0.0017).
	self assert: aSplineOverScroller currentPosition equals: 199.
	self
		assert: aSplineOverScroller currentStep
		equals: BlSplineOverScrollerStep spline.
	self assert: aSplineOverScroller deceleration equals: 0.0.
	self assert: aSplineOverScroller duration equals: 50 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 200.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 150.
	self assert: aSplineOverScroller startTime equals: self exampleDate.
	self assert: aSplineOverScroller startVelocity equals: 1000.

	^ aSplineOverScroller
]

{ #category : #'examples - overshot' }
BlOvershootingSplineBasedScrollerExamples >> _3_flingContinueWhenReachedTheEdge [
	<gtExample>
	<return: #BlOvershootingSplineBasedScroller>
	| aSplineOverScroller shouldContinue |
	aSplineOverScroller := self _2_flingMovingToTheEdge.

	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller update not.

	shouldContinue := aSplineOverScroller continue.	"we should spring back, because velocity is very high and we overshot"
	self assert: shouldContinue.

	self assert: (aSplineOverScroller currentVelocity closeTo: 902.15955).
	self assert: aSplineOverScroller currentPosition equals: 205.	"<- since we overshot position is greater than 200"
	self
		assert: aSplineOverScroller currentStep
		equals: BlSplineOverScrollerStep ballistic.
	self assert: (aSplineOverScroller deceleration closeTo: -8968.09).
	self assert: aSplineOverScroller duration equals: 105 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 250.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 200.	"<- we start springing back from our previous 'final' position"
	self
		assert: aSplineOverScroller startTime
		equals: self exampleDate + 50 milliSeconds.
	self assert: aSplineOverScroller startVelocity equals: 947.

	^ aSplineOverScroller
]

{ #category : #'examples - overshot' }
BlOvershootingSplineBasedScrollerExamples >> _4_flingMovingToTheOvershotMax [
	<gtExample>
	<return: #BlOvershootingSplineBasedScroller>
	| aSplineOverScroller expectedPositions expectedVelocities theActualPositions theActualVelocities |
	aSplineOverScroller := self _3_flingContinueWhenReachedTheEdge.

	expectedPositions := {205.
			209.
			213.
			217.
			221.
			224.
			228.
			231.
			234.
			236.
			239.
			241.
			243.
			244.
			246.
			247.
			248.
			249.
			249.
			250.
			250}.
	expectedVelocities := {902.15955.
			857.3191.
			812.47865.
			767.6382.
			722.79775.
			677.9573.
			633.11684999.
			588.2764.
			543.43595.
			498.5955.
			453.75505.
			408.9146.
			364.07414999.
			319.2337.
			274.39325.
			229.55279999.
			184.71234999.
			139.87189999.
			95.03144999.
		  50.19099999.
			5.35054999}.

	theActualPositions := OrderedCollection new.
	theActualVelocities := OrderedCollection new.

	aSplineOverScroller time
		every: 5 milliSeconds
		while: [ aSplineOverScroller update ]
		do: [ theActualPositions add: aSplineOverScroller currentPosition.
			theActualVelocities add: aSplineOverScroller currentVelocity ].
	self assert: theActualPositions asArray equals: expectedPositions.

	theActualVelocities
		with: expectedVelocities
		do: [ :anActual :anExpected | self assert: (anActual closeTo: anExpected) ].

	self assert: (aSplineOverScroller currentVelocity closeTo: 5.350549999).
	self assert: aSplineOverScroller currentPosition equals: 250.	"<- we reached the max overshot position = 200 (final requested) + 50 (overshot distance)"
	self
		assert: aSplineOverScroller currentStep
		equals: BlSplineOverScrollerStep ballistic.
	self assert: (aSplineOverScroller deceleration closeTo: -8968.09).
	self assert: aSplineOverScroller duration equals: 105 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 250.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 200.	"<- we start springing back from our previous 'final' position"
	self
		assert: aSplineOverScroller startTime
		equals: self exampleDate + 50 milliSeconds.
	self assert: aSplineOverScroller startVelocity equals: 947.

	^ aSplineOverScroller
]

{ #category : #'examples - overshot' }
BlOvershootingSplineBasedScrollerExamples >> _5_flingContinueWhenReachedTheOvershotMax [
	<gtExample>
	<return: #BlOvershootingSplineBasedScroller>
	| aSplineOverScroller shouldContinue |
	aSplineOverScroller := self _4_flingMovingToTheOvershotMax.

	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller update not.

	shouldContinue := aSplineOverScroller continue.
	self assert: shouldContinue.

	self assert: (aSplineOverScroller currentVelocity closeTo: 6.57563996).
	self assert: aSplineOverScroller currentPosition equals: 250.
	self
		assert: aSplineOverScroller currentStep
		equals: BlSplineOverScrollerStep cubic.
	self assert: (aSplineOverScroller deceleration closeTo: -2000.0).
	self assert: aSplineOverScroller duration equals: 223 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 200.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 250.
	self
		assert: aSplineOverScroller startTime
		equals: self exampleDate + 155 milliSeconds.
	self assert: aSplineOverScroller startVelocity equals: -50.

	^ aSplineOverScroller
]

{ #category : #'examples - overshot' }
BlOvershootingSplineBasedScrollerExamples >> _6_flingSpringBack [
	<gtExample>
	<return: #BlOvershootingSplineBasedScroller>
	| aSplineOverScroller expectedPositions expectedVelocities theActualPositions theActualVelocities |
	aSplineOverScroller := self _5_flingContinueWhenReachedTheOvershotMax.

	expectedPositions := {250.
			250.
			249.
			249.
			248.
			248.
			247.
			246.
			245.
			244.
			242.
			241.
			240.
			238.
			237.
			235.
			234.
			232.
			231.
			229.
			227.
			226.
			224.
			222.
			220.
			219.
			217.
			216.
			214.
			213.
			211.
			210.
			208.
			207.
			206.
			205.
			204.
			203.
			202.
			201.
			201.
			200.
			200.
			200}.
	expectedVelocities := {6.575639969.
			12.849645076.
			18.822015323.
			24.492750709.
			29.861851234.
			34.929316898.
			39.695147701.
			44.159343643.
			48.321904724.
			52.182830944.
			55.742122303.
			58.999778801.
			61.955800438.
			64.610187215.
			66.962939130.
			69.014056185.
			70.763538378.
			72.211385711.
			73.357598182.
			74.202175793.
			74.745118543.
			74.986426431.
			74.926099459.
			74.564137626.
			73.900540932.
			72.935309377.
			71.668442961.
			70.099941684.
			68.229805546.
			66.058034547.
			63.584628687.
			60.809587967.
			57.732912385.
			54.354601943.
			50.674656639.
			46.693076474.
			42.409861449.
			37.825011563.
			32.938526815.
			27.750407207.
			22.260652738.
			16.469263408.
			10.376239217.
			3.981580164.}.

	theActualPositions := OrderedCollection new.
	theActualVelocities := OrderedCollection new.

	aSplineOverScroller time
		every: 5 milliSeconds
		while: [ aSplineOverScroller update ]
		do: [ theActualPositions add: aSplineOverScroller currentPosition.
			theActualVelocities add: aSplineOverScroller currentVelocity ].
	self assert: theActualPositions asArray equals: expectedPositions.

	theActualVelocities
		with: expectedVelocities
		do: [ :anActual :anExpected | self assert: (anActual closeTo: anExpected) ].

	self assert: (aSplineOverScroller currentVelocity closeTo: 3.981580164).
	self assert: aSplineOverScroller currentPosition equals: 200.
	self
		assert: aSplineOverScroller currentStep
		equals: BlSplineOverScrollerStep cubic.
	self assert: (aSplineOverScroller deceleration closeTo: -2000.0).
	self assert: aSplineOverScroller duration equals: 223 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 200.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 250.
	self
		assert: aSplineOverScroller startTime
		equals: self exampleDate + 155 milliSeconds.
	self assert: aSplineOverScroller startVelocity equals: -50.

	^ aSplineOverScroller
]

{ #category : #'examples - overshot' }
BlOvershootingSplineBasedScrollerExamples >> _7_flingContinueAfterSpringBack [
	<gtExample>
	<return: #BlOvershootingSplineBasedScroller>
	| aSplineOverScroller shouldContinue |
	aSplineOverScroller := self _6_flingSpringBack.

	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller update not.

	shouldContinue := aSplineOverScroller continue.
	self assert: shouldContinue not.

	self assert: (aSplineOverScroller currentVelocity closeTo: 3.98158016).
	self assert: aSplineOverScroller currentPosition equals: 200.
	self
		assert: aSplineOverScroller currentStep
		equals: BlSplineOverScrollerStep cubic.
	self assert: (aSplineOverScroller deceleration closeTo: -2000.0).
	self assert: aSplineOverScroller duration equals: 223 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 200.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 250.
	self
		assert: aSplineOverScroller startTime
		equals: self exampleDate + 155 milliSeconds.
	self assert: aSplineOverScroller startVelocity equals: -50.

	^ aSplineOverScroller
]

{ #category : #'examples - overshot' }
BlOvershootingSplineBasedScrollerExamples >> _8_flingFinish [
	<gtExample>
	<return: #BlOvershootingSplineBasedScroller>
	| aSplineOverScroller |
	aSplineOverScroller := self _7_flingContinueAfterSpringBack.

	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller update not.
	self assert: aSplineOverScroller continue not.

	aSplineOverScroller finish.

	self assert: aSplineOverScroller currentVelocity equals: 0.
	self assert: aSplineOverScroller currentPosition equals: 200.
	self
		assert: aSplineOverScroller currentStep
		equals: BlSplineOverScrollerStep cubic.
	self assert: (aSplineOverScroller deceleration closeTo: -2000.0).
	self assert: aSplineOverScroller duration equals: 223 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 200.
	self assert: aSplineOverScroller isFinished.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 250.
	self
		assert: aSplineOverScroller startTime
		equals: self exampleDate + 155 milliSeconds.
	self assert: aSplineOverScroller startVelocity equals: -50.

	^ aSplineOverScroller
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> adjustDuration [
	<gtExample>
	<return: #Duration>
	| aSplineOverScroller aDjustedDuration |
	aSplineOverScroller := self splineOverScroller.

	aDjustedDuration := aSplineOverScroller
			adjustDuration: 808 milliSeconds
			start: 150
			final: 200
			previousFinal: 433.

	self assert: aDjustedDuration equals: 50 milliSeconds.

	^ aDjustedDuration
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> decelerationRate [
	<gtExample>
	<return: #SmallFloat64>
	| aSplineOverScroller |
	aSplineOverScroller := self splineOverScroller.

	self assert: (aSplineOverScroller decelerationRate closeTo: 2.35820181).

	^ aSplineOverScroller decelerationRate
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> endTension [
	<gtExample>
	<return: #SmallFloat64>
	| aSplineOverScroller |
	aSplineOverScroller := self splineOverScroller.

	self assert: (aSplineOverScroller endTension closeTo: 1).

	^ aSplineOverScroller endTension
]

{ #category : #accessing }
BlOvershootingSplineBasedScrollerExamples >> exampleDate [
	^ DateAndTime year: 2018 month: 3 day: 31
]

{ #category : #'examples - finish' }
BlOvershootingSplineBasedScrollerExamples >> finishWithoutStarting [
	<gtExample>
	<return: #BlOvershootingSplineBasedScroller>
	| aSplineOverScroller |
	aSplineOverScroller := self splineOverScroller.
	aSplineOverScroller finish.

	self assert: aSplineOverScroller currentPosition equals: 0.0.
	self assert: aSplineOverScroller currentVelocity equals: 0.0.
	self
		assert: aSplineOverScroller currentStep
		equals: BlSplineOverScrollerStep spline.

	self assert: aSplineOverScroller isFinished.

	self assert: aSplineOverScroller splineDistance equals: 0.0.
	self assert: aSplineOverScroller splineDuration isZero.

	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller deceleration equals: 0.0.

	self assert: aSplineOverScroller ppi equals: 96.0.

	^ aSplineOverScroller
]

{ #category : #'examples - fling' }
BlOvershootingSplineBasedScrollerExamples >> flingVelocity100_from0_min0_max100_over0 [
	<gtExample>
	<return: #BlOvershootingSplineBasedScroller>
	| aSplineOverScroller |
	aSplineOverScroller := self splineOverScroller.
	aSplineOverScroller time: (BlTime simulated date: self exampleDate).
	aSplineOverScroller
		fling: 100
		start: 0
		min: 0
		max: 100
		over: 0.

	self assert: aSplineOverScroller currentVelocity equals: 100.0.
	self assert: aSplineOverScroller currentPosition equals: 0.
	self
		assert: aSplineOverScroller currentStep
		equals: BlSplineOverScrollerStep spline.
	self assert: aSplineOverScroller deceleration equals: 0.0.
	self assert: aSplineOverScroller duration equals: 148 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 5.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 0.
	self assert: aSplineOverScroller splineDistance equals: 5.
	self assert: aSplineOverScroller splineDuration equals: 148 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 0.
	self assert: aSplineOverScroller startTime equals: self exampleDate.
	self assert: aSplineOverScroller startVelocity equals: 100.

	^ aSplineOverScroller
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> friction [
	<gtExample>
	<return: #SmallFloat64>
	| aSplineOverScroller |
	aSplineOverScroller := self splineOverScroller.

	self assert: (aSplineOverScroller friction closeTo: 0.015).

	^ aSplineOverScroller friction
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> inflexion [
	<gtExample>
	<return: #SmallFloat64>
	| aSplineOverScroller |
	aSplineOverScroller := self splineOverScroller.

	self assert: (aSplineOverScroller inflexion closeTo: 0.35).

	^ aSplineOverScroller inflexion
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> nbSamples [
	<gtExample>
	<return: #SmallInteger>
	| aSplineOverScroller |
	aSplineOverScroller := self splineOverScroller.

	self assert: aSplineOverScroller nbSamples equals: 100.

	^ aSplineOverScroller nbSamples
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> physicalCoefficient [
	<gtExample>
	<toReview>
	<return: #SmallFloat64>
	| aSplineOverScroller |
	aSplineOverScroller := self splineOverScroller.	"physical coefficient depends on ppi"
	self
		assert: (aSplineOverScroller physicalCoefficient closeTo: 31134.12 precision: 0.0011).

	^ aSplineOverScroller physicalCoefficient
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> splineDeceleration [
	<gtExample>
	<return: #OrderedDictionary>
	| aSplineOverScroller aVelocityMapping anActualMapping |
	aSplineOverScroller := self splineOverScroller.	"spline deceleration depends on physical coefficient which depends on ppi"	"velocity -> spline deceleration"
	aVelocityMapping := {0->Float infinity negated. 
		1 -> -7.196176682877059. 
		2 -> -6.503029502317114. 
		4 -> -5.8098823217571685. 
		8 -> -5.116735141197224. 
		16 -> -4.4235879606372785. 
		32 -> -3.7304407800773327. 
		64 -> -3.0372935995173878. 
		128 -> -2.3441464189574424. 
		256 -> -1.650999238397497}.

	anActualMapping := aVelocityMapping
			collect: [ :anAssoc | anAssoc key -> (aSplineOverScroller splineDecelerationFor: anAssoc key) ].

	anActualMapping
		with: aVelocityMapping
		do: [ :anActual :anExpected | self assert: (anActual value closeTo: anExpected value) ].

	^ anActualMapping asOrderedDictionary
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> splineFlingDistance [
	<gtExample>
	<return: #OrderedDictionary>
	| aSplineOverScroller aVelocityMapping anActualMapping |
	aSplineOverScroller := self splineOverScroller.	"velocity -> spline fling distance"
	aVelocityMapping := {0->0.0 . 
		1 -> 0.0017500097705743412 . 
		2 -> 0.0058305443549882055 . 
		4 -> 0.01942574724272983 . 
		8 -> 0.06472117060829533 . 
		16 -> 0.2156328851893084 . 
		32 -> 0.7184286183029239 . 
		64 -> 2.3936037360141915 . 
		128 -> 7.974819904300267 . 
		256 -> 26.56987518407128}.

	anActualMapping := aVelocityMapping
			collect: [ :anAssoc | anAssoc key -> (aSplineOverScroller splineFlingDistanceFor: anAssoc key) ].

	anActualMapping
		with: aVelocityMapping
		do: [ :anActual :anExpected | self assert: (anActual value closeTo: anExpected value) ].

	^ anActualMapping asOrderedDictionary
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> splineFlingDuration [
	<gtExample>
	<return: #OrderedDictionary>
	| aSplineOverScroller aVelocityMapping anActualMapping |
	aSplineOverScroller := self splineOverScroller.	"velocity -> spline fling distance"
	aVelocityMapping := {0 -> 0 milliSeconds.
			1 -> 5 milliSeconds.
			2 -> 8 milliSeconds.
			4 -> 13 milliSeconds.
			8 -> 23 milliSeconds.
			16 -> 38 milliSeconds.
			32 -> 64 milliSeconds.
			64 -> 106 milliSeconds.
			128 -> 178 milliSeconds.
			256 -> 296 milliSeconds}.

	anActualMapping := aVelocityMapping
			collect: [ :anAssoc | anAssoc key -> (aSplineOverScroller splineFlingDurationFor: anAssoc key) ].

	self assert: anActualMapping equals: aVelocityMapping.

	^ anActualMapping asOrderedDictionary
]

{ #category : #'examples - instance creation' }
BlOvershootingSplineBasedScrollerExamples >> splineOverScroller [
	<gtExample>
	<return: #BlOvershootingSplineBasedScroller>
	| aSplineOverScroller |
	aSplineOverScroller := BlOvershootingSplineBasedScroller new.

	self assert: aSplineOverScroller currentPosition equals: 0.0.
	self assert: aSplineOverScroller currentVelocity equals: 0.0.
	self
		assert: aSplineOverScroller currentStep
		equals: BlSplineOverScrollerStep spline.

	self assert: aSplineOverScroller splineDistance equals: 0.0.
	self assert: aSplineOverScroller splineDuration isZero.

	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller deceleration equals: 0.0.

	self assert: aSplineOverScroller ppi equals: 96.0.

	^ aSplineOverScroller
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> splineTime [
	<gtExample>
	<return: #Array>
	| aSplineOverScroller anExpectedSplineTime |
	aSplineOverScroller := self splineOverScroller.

	anExpectedSplineTime := {0.000002003.
			0.003500889.
			0.007003152.
			0.010507311.
			0.014013891.
			0.017523413.
			0.021044180.
			0.024568857.
			0.028097971.
			0.031639707.
			0.035194512.
			0.038755150.
			0.042337288.
			0.045926215.
			0.049529939.
			0.053156355.
			0.056798372.
			0.060456430.
			0.064138337.
			0.067844456.
			0.071567819.
			0.075316167.
			0.079097156.
			0.082903824.
			0.086736540.
			0.090595673.
			0.094488799.
			0.098416236.
			0.102385481.
			0.106382457.
			0.110421874.
			0.114496770.
			0.118614626.
			0.122782824.
			0.126987355.
			0.131242707.
			0.135549094.
			0.139899624.
			0.144308684.
			0.148776431.
			0.153295942.
			0.157881492.
			0.162519061.
			0.167229922.
			0.172007064.
			0.176850523.
			0.181767341.
			0.186757482.
			0.191834937.
			0.196992555.
			0.202230149.
			0.207554593.
			0.212972539.
			0.218490708.
			0.224108687.
			0.229832994.
			0.235656091.
			0.241598271.
			0.247658778.
			0.253836743.
			0.260147081.
			0.266598429.
			0.273177862.
			0.279911536.
			0.286811550.
			0.293848304.
			0.301074922.
			0.308475044.
			0.316060229.
			0.323839788.
			0.331824425.
			0.340037446.
			0.348487211.
			0.357182072.
			0.366129401.
			0.375349069.
			0.384886332.
			0.394731681.
			0.404900823.
			0.415446814.
			0.426380926.
			0.437737711.
			0.449556923.
			0.461860404.
			0.474728915.
			0.488177160.
			0.502310524.
			0.517149596.
			0.532821539.
			0.549455174.
			0.567129744.
			0.586069449.
			0.606443133.
			0.628535939.
			0.652774190.
			0.679739422.
			0.710244204.
			0.745800808.
			0.789245521.
			0.848081988.
			1.000000000.}.

	aSplineOverScroller splineTime
		with: anExpectedSplineTime
		do: [ :anActual :anExpected | self assert: (anActual closeTo: anExpected) ].

	^ aSplineOverScroller splineTime
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> startTension [
	<gtExample>
	<return: #SmallFloat64>
	| aSplineOverScroller |
	aSplineOverScroller := self splineOverScroller.

	self assert: (aSplineOverScroller startTension closeTo: 0.5).

	^ aSplineOverScroller startTension
]
