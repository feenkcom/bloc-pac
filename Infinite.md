# Infinite Element

Allows users to create practically infinite scrollable elements such as for example a vertical scrollable list.

## Depend on it
```smalltalk
spec 
   baseline: 'BlocPacInfinite' with: [
      spec repository: 'github://feenkcom/bloc-pac:main/src' ].

...

spec 
   package: #'MyPackage' with: [
      spec requires: #(#'MyOtherPackage' #BlocPacInfinite ) ].
```


### Installation

```smalltalk
Metacello new
   baseline: 'BlocPacInfinite';
   repository: 'github://feenkcom/bloc-pac:main/src';
   load
```

### Examples:
```smalltalk
Metacello new
   baseline: 'BlocPacInfiniteExamples';
   repository: 'github://feenkcom/bloc-pac:main/src';
   load
```
