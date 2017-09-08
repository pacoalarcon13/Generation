#!/usr/bin/env python
#05/08/2015

#Author
#Sebastian ECHEVERRI RESTREPO
#sebastianecheverrir@gmail.com

#Since Moltemplate does not really allow to position the polymer chains randomly in a box,
#this pythoon script reads the chains and distributes them randomly in a box
#it does hte same for the fillers

#inputs from command line
#sys.argv[1]->XboxMin
#sys.argv[2]->XboxMax
#sys.argv[3]->YboxMin
#sys.argv[4]->YboxMax
#sys.argv[5]->ZboxMin
#sys.argv[6]->ZboxMax
#sys.argv[7]->nBeadsPerChain
#sys.argv[8]->Density
#sys.argv[9]->nFillers

import random
import sys

print('import "Bead.lt"')
print('import "Chain.lt"')
print('import "FillerBead.lt"')
print('import "Filler.lt"')

print('import "settings.lt"')


XboxMin=float(sys.argv[1])
XboxMax=float(sys.argv[2])

YboxMin=float(sys.argv[3])
YboxMax=float(sys.argv[4])

ZboxMin=float(sys.argv[5])
ZboxMax=float(sys.argv[6])

nBeadsPerChain=int(sys.argv[7])
Density = float(sys.argv[8])
nChains=int(Density*(XboxMax-XboxMin)*(YboxMax-YboxMin)*(ZboxMax-ZboxMin)/nBeadsPerChain)

#nChains=10
nFillers=int(sys.argv[9])

for i in range(0,nChains):
  randomAngle=random.uniform(0, 360)
  Xrot=random.uniform(-1, 1)
  Yrot=random.uniform(-1, 1)
  Zrot=random.uniform(-1, 1)
 

#  Xrot=random.randint(0, 1)
#  Yrot=random.randint(0, 1)
#  Zrot=random.randint(0, 1)
  Xmove=random.uniform(XboxMin,XboxMax)
  Ymove=random.uniform(YboxMin,YboxMax)
  Zmove=random.uniform(ZboxMin,ZboxMax)


  print('peptides'+str(i)+' = new Chain.rot('
	+str(randomAngle)+', '
	+str(Xrot)+','
	+str(Yrot)+','
	+str(Zrot)+').move('
	+str(Xmove)+', '
	+str(Ymove)+', '
	+str(Zmove)+')')


for i in range(0,nFillers):
  randomAngle=random.uniform(0, 360)
  Xrot=random.uniform(-1, 1)
  Yrot=random.uniform(-1, 1)
  Zrot=random.uniform(-1, 1)

  Xmove=random.uniform(XboxMin,XboxMax)
  Ymove=random.uniform(YboxMin,YboxMax)
  Zmove=random.uniform(ZboxMin,ZboxMax)


  print('FillerParticle'+str(i)+' = new Filler.rot('
	+str(randomAngle)+', '
	+str(Xrot)+','
	+str(Yrot)+','
	+str(Zrot)+').move('
	+str(Xmove)+', '
	+str(Ymove)+', '
	+str(Zmove)+')')



