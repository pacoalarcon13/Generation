#!/usr/bin/env python
#05/08/2015

#Author
#Sebastian ECHEVERRI RESTREPO
#sebastianecheverrir@gmail.com

import os
import sys


#This set of programs are used to generate homopolymer chains of a given lenght 
# and put them inside a simulation box. Each chain will be randomly positioned 
# and oriented.
#it also generates filler particles and places them randomly in the same box

#It needs moltemplate!

#files needed
#  settings.py
#  Bead.py
#  Chain.py
#  System.py
#  Filler.py
#  FillerBead.py

#files output (.data file for lammps)
#  homopolymer+Filler.data

#how to run
# 1) Be sure that all the "files needed" are in the same directory
# 2) Set the "Variables given by the user" as needed. This is done in this file
# 3) ./main.py


#The file homopolymer+Filler.in is also included. It allows to make a
#	relaxation using lammps

###################################################
#Variables given by the user
###################################################
#fixed
Density=

#to be fitted
chainLenght=
bondLenght=	#initial value (only for system preparation, not for the potential)
BoxSideLenght=

FillerRadius=
FillerbondLenght= #initial value (only for system preparation, not for the potential)
nFillers=


###################################################
#bondLenght=Aii/(Aii+kpp)
XboxMin=0
XboxMax=BoxSideLenght
YboxMin=0
YboxMax=BoxSideLenght
ZboxMin=0
ZboxMax=BoxSideLenght



#generates the file Bead.lt
os.system("./Bead.py > Bead.lt")

#generates the file Chain.lt
os.system('./Chain.py'+' '+str(chainLenght)+' '+str(bondLenght)+'  > Chain.lt')

os.system("./FillerBead.py > FillerBead.lt")
os.system('./Filler.py '+str(FillerRadius)+' '+str(FillerbondLenght)+'> Filler.lt')


#generates the file settings.lt
os.system('./settings.py'+' '+str(XboxMin)+' '+str(XboxMax)+' '
	  +str(YboxMin)+' '+str(YboxMax)+' '+str(ZboxMin)+' '+str(ZboxMax)+' '
	  +' > settings.lt')

#generates the file system.lt
os.system('./System.py'+' '+str(XboxMin)+' '+str(XboxMax)+' '+str(YboxMin)+' '
	  +str(YboxMax)+' '+str(ZboxMin)+' '+str(ZboxMax)+' '+str(chainLenght)+' '
	  +str(Density)+' '+str(nFillers)+' > system.lt')


#generates lammps files

print "#######################\nGenerating homopolymer melt + fillers"

os.system('moltemplate.sh  -nocheck -atomstyle angle  system.lt 2>/dev/null')
os.system('rm -r output_ttree system.lt settings.lt Chain.lt Bead.lt FillerBead.lt Filler.lt system.in')

os.system('mv system.data homopolymer+Filler.data')


  
#To run Lammps
#  mpirun -np 4 lmp_mpi < homopolymer+Filler.in
#  lmp_mpi < homopolymer+Filler.in
  
