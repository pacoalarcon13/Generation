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



###################################################

radiusFiller=float(sys.argv[1])
bondLenght=float(sys.argv[2])

###################################################

#lattice parameter for an FCC structure
latticeParameter=2*bondLenght/math.sqrt(2)

Filler=[]

print('import "FillerBead.lt"')
print('Filler {')

Xcoord1=-radiusFiller
Ycoord1=-radiusFiller
Zcoord1=-radiusFiller

Xcoord2=-radiusFiller+bondLenght/math.sqrt(2)
Ycoord2=-radiusFiller+bondLenght/math.sqrt(2)
Zcoord2=-radiusFiller

Xcoord3=-radiusFiller+bondLenght/math.sqrt(2)
Ycoord3=-radiusFiller
Zcoord3=-radiusFiller+bondLenght/math.sqrt(2)

Xcoord4=-radiusFiller
Ycoord4=-radiusFiller+bondLenght/math.sqrt(2)
Zcoord4=-radiusFiller+bondLenght/math.sqrt(2)

nBeads=0


while (Xcoord1 < radiusFiller):
  while (Ycoord1 < radiusFiller):
    while (Zcoord1 < radiusFiller):
      if (Xcoord1**2+Ycoord1**2+Zcoord1**2)<=(radiusFiller+0.1*bondLenght)**2:
	print('    Filler_Element['+str(nBeads)+'] = new FillerBead.move('+str(Xcoord1)+','+str(Ycoord1)+','+str(Zcoord1)+')')
	nBeads=nBeads+1
	Filler.append({'x':Xcoord1, 'y':Ycoord1, 'z':Zcoord1, 'bond':0})
      Zcoord1=Zcoord1+latticeParameter
    Ycoord1=Ycoord1+latticeParameter
    Zcoord1=-radiusFiller
  Xcoord1=Xcoord1+latticeParameter
  Ycoord1=-radiusFiller


while (Xcoord2 < radiusFiller):
  while (Ycoord2 < radiusFiller):
    while (Zcoord2 < radiusFiller):
      if (Xcoord2**2+Ycoord2**2+Zcoord2**2)<=(radiusFiller+0.1*bondLenght)**2:
	print('    Filler_Element['+str(nBeads)+'] = new FillerBead.move('+str(Xcoord2)+','+str(Ycoord2)+','+str(Zcoord2)+')')
	nBeads=nBeads+1
	Filler.append({'x':Xcoord2, 'y':Ycoord2, 'z':Zcoord2, 'bond':0})
      Zcoord2=Zcoord2+latticeParameter
    Ycoord2=Ycoord2+latticeParameter
    Zcoord2=-radiusFiller
  Xcoord2=Xcoord2+latticeParameter
  Ycoord2=-radiusFiller+bondLenght/math.sqrt(2)
  
while (Xcoord3 < radiusFiller):
  while (Ycoord3 < radiusFiller):
    while (Zcoord3 < radiusFiller):
      if (Xcoord3**2+Ycoord3**2+Zcoord3**2)<=(radiusFiller+0.1*bondLenght)**2:
	print('    Filler_Element['+str(nBeads)+'] = new FillerBead.move('+str(Xcoord3)+','+str(Ycoord3)+','+str(Zcoord3)+')')
	nBeads=nBeads+1
	Filler.append({'x':Xcoord3, 'y':Ycoord3, 'z':Zcoord3, 'bond':0})
      Zcoord3=Zcoord3+latticeParameter
    Ycoord3=Ycoord3+latticeParameter
    Zcoord3=-radiusFiller+bondLenght/math.sqrt(2)
  Xcoord3=Xcoord3+latticeParameter
  Ycoord3=-radiusFiller
  
while (Xcoord4 < radiusFiller):
  while (Ycoord4 < radiusFiller):
    while (Zcoord4 < radiusFiller):
      if (Xcoord4**2+Ycoord4**2+Zcoord4**2)<=(radiusFiller+0.1*bondLenght)**2:
	print('    Filler_Element['+str(nBeads)+'] = new FillerBead.move('+str(Xcoord4)+','+str(Ycoord4)+','+str(Zcoord4)+')')
	nBeads=nBeads+1
	Filler.append({'x':Xcoord4, 'y':Ycoord4, 'z':Zcoord4, 'bond':0})
      Zcoord4=Zcoord4+latticeParameter
    Ycoord4=Ycoord4+latticeParameter
    Zcoord4=-radiusFiller+bondLenght/math.sqrt(2)
  Xcoord4=Xcoord4+latticeParameter
  Ycoord4=-radiusFiller+bondLenght/math.sqrt(2)
  
#
#print Filler
#print FillerBeads.coord
#print FillerBeads.nBeads



#generating the bonds

print('write("Data Bonds") {')
print('   # bond-id   bond-type      atom-id1  atom-id2')

Nbond=0

for i in range(0, len(Filler)):
  for j  in range(i+1, len(Filler)):
    distance = math.sqrt((Filler[i]['x']-Filler[j]['x'])**2+(Filler[i]['y']-Filler[j]['y'])**2+(Filler[i]['z']-Filler[j]['z'])**2)
    if distance < (bondLenght+bondLenght*0.1):
      Filler[i]['bond']=j
      print('    $bond:Filler_Filler'+str(Nbond+1)+' @bond:Filler_Filler $atom:Filler_Element['+str(i)+']/FillerBead $atom:Filler_Element['+str(j)+']/FillerBead')
      Nbond=Nbond+1
      #print i, Filler[i]
  

print('}')




#for i in range(0,nBeads-1):
  #print('    $bond:Filler_Filler'+str(i+1)+' @bond:Filler_Filler $atom:Filler_Element['+str(i)+']/FillerBead $atom:Filler_Element['+str(i+1)+']/FillerBead')

#print('}')
  

  
  
  
print('create_var { $mol }')
print('}')
