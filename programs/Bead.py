#!/usr/bin/env python
#05/08/2015

#Author
#Sebastian ECHEVERRI RESTREPO
#sebastianecheverrir@gmail.com

import sys



print('Bead {')
print('  write("Data Atoms") {')
print('    $atom:Bead $mol:... @atom:Bead     0.000  0.0000   0.0000000')
print('}')

print('  write_once("Data Masses") {')
print('    # atomType  mass')
print('    @atom:Bead    1.0')
print('  }')
print('}')




