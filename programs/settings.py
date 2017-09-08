#!/usr/bin/env python
#05/08/2015

#Author
#Sebastian ECHEVERRI RESTREPO
#sebastianecheverrir@gmail.com

#inputs from command line
#sys.argv[1]->XboxMin
#sys.argv[2]->XboxMax
#sys.argv[3]->YboxMin
#sys.argv[4]->YboxMax
#sys.argv[5]->ZboxMin
#sys.argv[6]->ZboxMax

import sys

XboxMin=float(sys.argv[1])
XboxMax=float(sys.argv[2])

YboxMin=float(sys.argv[3])
YboxMax=float(sys.argv[4])

ZboxMin=float(sys.argv[5])
ZboxMax=float(sys.argv[6])



print('write_once("Data Boundary") {')
print(str(XboxMin)+' '+str(XboxMax)+' xlo xhi')
print(str(YboxMin)+' '+str(YboxMax)+' ylo yhi')
print(str(ZboxMin)+' '+str(ZboxMax)+' zlo zhi')
print('  1.22465e-15 1.22465e-15 1.22465e-15 xy xz yz')
print('}')







#########################################################
#Temperature=0.3#float(sys.argv[7])

#gamma=4.5

#App=200.0
#Apf=100.0
#Aff=199.0

#kff=121.0
#kpp=122.0



#timeStep=0.01
#totalTimeSteps=200000



#print('write_once("In Init") {')
#print('  # Indicate which atom style and force-field styles we will need:')
#print('  units          lj')
#print('  atom_style     angle')
#print('  boundary       p p p')
#print('  dimension      3   ')
#print('}')

#print('write_once("In Settings") {')
#print('  pair_style     hybrid/overlay dpd '+str(Temperature)+' 1.0 12345 dpd/tstat '
      #+str(Temperature)+'  '+str(Temperature)+'  1.0 12345')
      
#print('  pair_coeff     @atom:Bead/Bead @atom:Bead/Bead   dpd '+str(App)+'  0.000000')
#print('  pair_coeff     @atom:Bead/Bead @atom:Bead/Bead   dpd/tstat '+str(gamma)+'	')

#print('  pair_coeff     @atom:Bead/Bead @atom:FillerBead/FillerBead   dpd '+str(App)+'  0.000000')
#print('  pair_coeff     @atom:Bead/Bead @atom:FillerBead/FillerBead   dpd/tstat '+str(gamma)+'	')

#print('  pair_coeff     @atom:FillerBead/FillerBead @atom:FillerBead/FillerBead   dpd '+str(Aff)+'  0.000000')
#print('  pair_coeff     @atom:FillerBead/FillerBead @atom:FillerBead/FillerBead   dpd/tstat '+str(gamma)+'	')


#print('  bond_style     harmonic')
#print('  special_bonds  lj 1.0 1.0 1.0')
#print('  bond_coeff     @bond:Chain/ACN_ACN   '+str(kpp)+' 0.000000')
#print('  bond_coeff     @bond:Filler/Filler_Filler   '+str(kff)+' 0.000000')

#print('  group          mobile union all')
#print('  velocity       mobile create 1.0 14092168 mom yes rot yes dist gaussian')
#print('  comm_modify    mode single vel yes')
#print('  neighbor       2.0 bin')
#print('  neigh_modify   delay 2')
#print('  timestep       '+str(timeStep)+'')
#print('}')

#print('write_once("In Run") {')
#print('  fix 		 1 all nve ')
#print('#  fix            1 mobile nve		#')
#print('#  fix            sm all deform 1 xy wiggle 1.2 480 remap v units box')
#print('  dump           1 all atom 100 system.dump #mass type xsu ysu zsu #Rubber4.dump')
#print('  #dump_modify    1 scale no image yes')
#print('  thermo_style   custom etotal ke pe ebond enthalpy temp press pxx pxy pxz pyy pyz pzz lx ly lz xy xz yz')
#print('  thermo_modify  line multi')
#print('  thermo         1')
#print('  thermo_modify  flush yes')
#print('#  write_restart  initial.rst')
#print('  run            '+str(totalTimeSteps)+'')
#print('#  unfix          sm')
#print('#  write_restart  final.rst')
#print('}')














