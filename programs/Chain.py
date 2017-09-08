#!/usr/bin/env python
#05/08/2015

#Author
#Sebastian ECHEVERRI RESTREPO
#sebastianecheverrir@gmail.com

#Since Moltemplate does not really allow to make random polymer chains with different types of atoms
#The issue is that, although the sequence of beads can be made random, the bonds have to be created manually...
import sys
import random
import math




nBeadsPerChain=int(sys.argv[1])
bondLenght=float(sys.argv[2])

print('import "Bead.lt"')
print('Chain {')
print('create_var {$mol}')

#generating the beads
XdispCum=0
YdispCum=0
ZdispCum=0
Xdisp=0
Ydisp=0
Zdisp=0
angRand=0
for i in range(0,nBeadsPerChain):

  XdispCum=XdispCum+Xdisp
  YdispCum=YdispCum+Ydisp
  ZdispCum=ZdispCum+Zdisp

  print('    Chain_Element['+str(i)+'] = new Bead.move('+str(XdispCum)+','+str(YdispCum)+','+str(ZdispCum)+')')#.rot(45,0,1,0,'+str((i-1)*bondLenght)+',0,0)')
#  print('    Chain_Element['+str(i)+'] = new Bead.move('+str(XdispCum)+',0,0).rot('+str(angRand)+',0,0,1,'+str(XdispCum-Xdisp)+',0,0)')
  Ydisp=random.uniform(-bondLenght, bondLenght)
  Zdisp= random.uniform(-bondLenght, bondLenght)

  while (Ydisp**2+Zdisp**2>bondLenght**2):
    Ydisp=random.uniform(-bondLenght, bondLenght)
    Zdisp= random.uniform(-bondLenght, bondLenght)

  Xdisp=math.sqrt(bondLenght**2-Ydisp**2-Zdisp**2) #random.uniform(0, bondLenght)
  angRand=random.uniform(0,90)
  

print('write("Data Bonds") {')
print('   # bond-id   bond-type      atom-id1  atom-id2')

#generating the bonds
for i in range(0,nBeadsPerChain-1):
  print('    $bond:ACN_ACN'+str(i+1)+' @bond:ACN_ACN $atom:Chain_Element['
    +str(i)+']/Bead $atom:Chain_Element['+str(i+1)+']/Bead')

print('}')
print('create_var { $mol }')
print('}')
