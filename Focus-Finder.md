# Focus Finder

Allows users to find a next or previous focusable element in a given direction relative to an element or an area.

## Depend on it
```smalltalk
spec 
   baseline: 'BlocPacFocusFinder' with: [
      spec repository: 'github://feenkcom/bloc-pac:main/src' ].

...

spec 
   package: #'MyPackage' with: [
      spec requires: #(#'MyOtherPackage' #BlocPacFocusFinder ) ].
```


### Installation

```smalltalk
Metacello new
   baseline: 'BlocPacFocusFinder';
   repository: 'github://feenkcom/bloc-pac:main/src';
   load
```

### Examples:
```smalltalk
Metacello new
   baseline: 'BlocPacFocusFinder';
   repository: 'github://feenkcom/bloc-pac:main/src';
   load
```
