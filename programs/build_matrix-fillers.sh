#!/bin/bash
#22/09/2015
#Authors
# Francisco Alarcon Oseguera	pacoalarcon@ub.edu
# Ignacio Pagonabarraga Mora	ipagonabarraga@ub.edu
# Sebastian Echeverri Restrepo	sebastianecheverrir@gmail.com

#This set of programs are used to generate a croslinked homopolymer with chains
#  inside a simulation box. Each chain will be randomly positioned and oriented.
#  Additionally, spherical fillers composed of a different type of beads are
#  inserted into the system.
#  Finally, crosslinks between the fillers and polymers are also generated

#It needs: 	moltemplate!
#		lammps
#		bash

#files needed
#	python
#  		Bead.py
#  		Chain.py
#  		settings.py
#  		System.py
#		GenerateLammpsInput_HP+F.py
#	lammps
#  		CLhomopolymer+Filler.in


#files output (.data file for lammps)
#  homopolymer+Filler_Types.data  (non crosslinked)
#  CLhomopolymer+CLFiller_Types.data (crosslinked)

#how to run
# 1) Be sure that all the "files needed" are in the same directory
# 2) Set the "Variables given by the user" as needed. This is done 
#	in the files:
#		build_matrix-fillers.sh		(current file)
#		GenerateLammpsInput_HP+F.py	(data for the generation of the melt+fillers)
#		CLhomopolymer+CLFiller.in	(data for the termalization after each crosslinking step)
# 3) sh build_matrix-fillers.sh


###################################################
#Variables given by the user
###################################################

links=			#Number of crosslinkers per chain
linksFillers=      #TOTAL Number of crosslinkers on fillers

Lammpsexe=	#name of the lammps executable
nProc= 		#number of processors available

chainL=




####################################################while bash
CLDone=1
while [ ! -z "$CLDone" ]
do
  #generating the polymer melt. The output file is homopolymer+Filler_Types.data
  python ser_tmp_GenerateLammpsInput_HP+F.py


  #The crosslinking is done using the fix bond/create in lammps
  #To use this command, the beads that will be crosslinked need to 
  #be selected. This is done by changing the types
  # bead		type
  # p		1	Polymer bead 
  # f		2	Fillerbead
  # CLp-p		3	Polymer bead to be cosslinked with another polymer bead
  # CLf-p		4	Filler bead to be cosslinked with a polymer bead


  echo "#######################"
  echo Selecting beads that will crosslink 
  ./ser_tmp_Bead_type.sh $links $linksFillers $chainL # > homopolymer+Filler_Types.data

  echo "#######################"
  echo Thermalizing non crosslinked system
  echo Crosslinking the system
  mpirun -n $nProc $Lammpsexe < ser_tmp_CLhomopolymer+CLFiller.in > log.CL

  echo "#######################"
  echo Veryfing that all the crosslinks were generated
  #At the end of the crosslinking stage there should not be any atom type 3 or 4
  nBeads=`grep atoms CLhomopolymer+CLFiller_Types.data | awk '{print $1}'`
  CLDone=`awk -v nBeads=$nBeads '{if (($3==3 || $3==4) && NR>28 && NR<=nBeads+28) print $0} ' CLhomopolymer+CLFiller_Types.data`
  #echo $CLDone
  if  [ ! -z "$CLDone" ]
  then
    echo "#######################"
    echo Some crosslinks are missing, restarting the process
    echo "#######################"  
    echo ""
  fi
  
done  
  

  
  
  
echo "#######################"
echo Writting output to  CLhomopolymer+CLFiller.data
echo "#######################"
#Formating the data file 
sed -i "s/4 atom types/2 atom types/g" CLhomopolymer+CLFiller_Types.data
awk '{if (NR<=16 || NR>= 26) print $0}' CLhomopolymer+CLFiller_Types.data > CLhomopolymer+CLFiller.data



rm  CLhomopolymer+CLFiller_Types.data homopolymer+Filler_Types.data
rm log.lammps log.CL

