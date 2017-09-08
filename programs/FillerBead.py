#!/usr/bin/env python
#05/08/2015

#Author
#Sebastian ECHEVERRI RESTREPO
#sebastianecheverrir@gmail.com

import sys



print('FillerBead {')
print('  write("Data Atoms") {')
print('    $atom:FillerBead $mol:... @atom:FillerBead     0.000  0.0000   0.0000000')
print('}')

print('  write_once("Data Masses") {')
print('    # atomType  mass')
print('    @atom:FillerBead    1.0')
print('  }')
print('}')




