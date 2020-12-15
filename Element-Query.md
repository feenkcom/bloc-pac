# Element Query

Allows users to query a scene graph of elements in an XPath-like way.

Find deeply all `BrButton` children and return the second one:
```smalltalk
element query // BrButton  @ 2
```

Find elements with `#label` id within the first direct child of type `BrButton`:
```smalltalk
element query / BrButton @ 1 // #label
```

## Depend on it
```smalltalk
spec 
   baseline: 'BlocPacElementQuery' with: [
      spec repository: 'github://feenkcom/bloc-pac:main/src' ].

...

spec 
   package: #'MyPackage' with: [
      spec requires: #(#'MyOtherPackage' #BlocPacElementQuery ) ].
```


### Installation

```smalltalk
Metacello new
   baseline: 'BlocPacElementQuery';
   repository: 'github://feenkcom/bloc-pac:main/src';
   load
```