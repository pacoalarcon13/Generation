#!/bin/bash

#30/01/2016
#Authors
# Sebastian Echeverri Restrepo  (SKF) sebastianecheverrir@gmail.com
# Francisco Alarcon Oseguera	(UB)  pacoalarcon@ub.edu
# Ignacio Pagonabarraga Mora	(UB)  ipagonabarraga@ub.edu

###################################################2
#This set of programs can be used to generate one of the following systems to be
#	used for dissipative Particle dynamics simulations with LAMMPS

#	1 -> Homopolymer Melt
#	2 -> Homopolymer Melt + Fillers
#       2 -> Homopolymer Melt + Crosslinked Fillers
#	3 -> Crosslinked Homopolymer
#	4 -> Crosslinked Homopolymer + Fillers
#	5 -> Crosslinked Homopolymer + Crosslinked Fillers


###################################################2
#Explanation
#The generation of the sytem polymer is divided in the
#	following steps. Note that depending on the system
#	that is going to be generated, some of the steps
#	might be ommited
#	1 Generation of the homopolymer melt + Fillers
#	2 Relaxation of the homopolymer melt + Fillers
#	3 crosslinking

###################################################2
#Programs needed
#It needs: 	moltemplate
#		lammps
#		Python
#		bash

###################################################2
#files needed
#	bash	build_matrix-fillers.sh
#	python
#  		Bead.py
#  		Chain.py
#  		settings.py
#  		System.py
#		GenerateLammpsInput_HP+F.py
#	lammps
#  		CLhomopolymer+CLFiller.in

###################################################2
#files output (.data file for lammps)
#  CLhomopolymer+CLFiller.data (crosslinked)

###################################################2
#how to run
# 1) Be sure that all the "files needed" are in the directory " programs"
# 2) Set the "Variables given by the user" as needed. This is done 
#	ONLY in the current file
# 3) ./main.sh

###################################################2
#conventions

#variables
# A  ->  Repulsion parameter
# k  ->	Spring constant for bonds
# r0 ->	Particle diameter
# p  ->	"polymer bead". e.g. kpp= k between 2 polymer beads
# f  ->	"filler bead". e.g. Aff= A between 2 filler beads
# CL ->	Crosslinked

#particles types
# 1  ->	Polymer bead
# 2  ->	Filler bead
# 3  -> Polymer bead to be cosslinked with another polymer bead
# 4  -> Filler bead to be cosslinked with a polymer bead

#bond types
# 1  ->	pp chain bond
# 2  ->	ff bond
# 3  ->	pp crosslink
# 4  ->	pf crosslink


###################################################2
###################################################2
###################################################2
#Variables given by the user
###################################################2
###################################################2
###################################################2

#Variables related to the use of lammps
Lammpsexe=lmp_g++	#name of the lammps executable
nProc=1			#number of processors available


###################################################2
#Topology
nFillers=2  		#Nuber of fillers
links=4 		#Number of crosslinkers per
			# polymer chain
linksFillers=3  	#Number of crosslinkers per filler

###################################################2
# Chain and filler generation
Density=0.5             #of the polymer chains only
chainLenght=30		#lenght of the polymer chains
BoxSideLenght=10	#Length of the side of the simulation
			# box. The box is a cube
bondLenght=0.95		#initial bond lenght for the polymer
			# value (only for system preparation,
			# not for the potential)

FillerRadius=2.0	#Radius of the filler particles (not the beads)
FillerbondLenght=0.7071 #initial bond lenght for the filler
			# value (only for system preparation,
			# not for the potential)

###################################################2
#General interaction parameters
cutoff=1.0		#cutoff of the potential
gamma=4.5		#Dissipative factor

###################################################2
#polymer-polymer Interaction
App=50.0
kpp=4.0
r0p=0.0
CLkpp=4.2  	#kpp for crosslinks
CLr0=0.0 	#r0 for crosslinks

###################################################2
#filler-filler interaction
Aff=72.0
kff=30.0
r0f=0.7071

###################################################2
#polymer-filler interaction
Apf=72.0
CLkpf=4.1  	#kpp for crosslinks Filler-Polymer
CLr0pf=0.0  	#r0 for crosslinks Filler-Polymer

###################################################2
#Variables related to the crosslinking stage
Rneigh=2.0	#Cut-off distance between the cross-link bead
		# and the non-cross-link neighbouring bead
		# used to determine if a crosslink can be made
		# between two particles

###################################################2

#Relaxation of the system during crosslinking
timeStepCL=0.05
TemperatureCL=1.0
totalTimeStepsCL=10000

####################################################################3


####################################################################3
####################################################################3
####################################################################3
#DO NOT MODIFY FROM HERE ON!!!
####################################################################3
####################################################################3
####################################################################3




totalFillerlinks=`expr $linksFillers \* $nFillers`

cp programs/* .

cp build_matrix-fillers.sh ser_tmp_build_matrix-fillers.sh
sed -i "s/links=/links=${links} #/g"			ser_tmp_build_matrix-fillers.sh
sed -i "s/linksFillers=/linksFillers=${linksFillers} #/g"			ser_tmp_build_matrix-fillers.sh
sed -i "s/Lammpsexe=/Lammpsexe=\'${Lammpsexe}\' #/g"	ser_tmp_build_matrix-fillers.sh
sed -i "s/nProc=/nProc=${nProc} #/g"			ser_tmp_build_matrix-fillers.sh
sed -i "s/chainL=/chainL=${chainLenght} #/g"		ser_tmp_build_matrix-fillers.sh

cp CLhomopolymer+CLFiller.in ser_tmp_CLhomopolymer+CLFiller.in
sed -i "s/variable 	timeStep	equal	/variable 	timeStep	equal		${timeStepCL} #/g" 		ser_tmp_CLhomopolymer+CLFiller.in
sed -i "s/variable 	Temperature	equal	/variable 	Temperature	equal		${TemperatureCL} #/g" 		ser_tmp_CLhomopolymer+CLFiller.in
sed -i "s/variable	cutoff		equal	/variable	cutoff		equal		${cutoff} #/g" 		ser_tmp_CLhomopolymer+CLFiller.in
sed -i "s/variable	totalTimeSteps	equal	/variable	totalTimeSteps	equal		${totalTimeStepsCL} #/g" 	ser_tmp_CLhomopolymer+CLFiller.in
sed -i "s/variable	gamma		equal	/variable	gamma		equal		${gamma} #/g" 			ser_tmp_CLhomopolymer+CLFiller.in
sed -i "s/variable	App		equal	/variable	App		equal		${App} #/g" 			ser_tmp_CLhomopolymer+CLFiller.in
sed -i "s/variable	kpp		equal	/variable	kpp		equal		${kpp} #/g" 			ser_tmp_CLhomopolymer+CLFiller.in
sed -i "s/variable	r0p		equal	/variable	r0p		equal		${r0p} #/g" 			ser_tmp_CLhomopolymer+CLFiller.in
sed -i "s/variable	CLkpp		equal	/variable	CLkpp		equal		${CLkpp} #/g" 			ser_tmp_CLhomopolymer+CLFiller.in
sed -i "s/variable	CLr0		equal	/variable	CLr0		equal		${CLr0} #/g" 			ser_tmp_CLhomopolymer+CLFiller.in

sed -i "s/variable	Aff		equal	/variable	Aff		equal		${Aff} #/g" 			ser_tmp_CLhomopolymer+CLFiller.in
sed -i "s/variable	kff		equal	/variable	kff		equal		${kff} #/g" 			ser_tmp_CLhomopolymer+CLFiller.in
sed -i "s/variable	r0f		equal	/variable	r0f		equal		${r0f} #/g" 			ser_tmp_CLhomopolymer+CLFiller.in
sed -i "s/variable	Apf		equal	/variable	Apf		equal		${Apf} #/g" 			ser_tmp_CLhomopolymer+CLFiller.in


sed -i "s/variable	CLkpf		equal	/variable	CLkpf		equal		${CLkpf} #/g" 			ser_tmp_CLhomopolymer+CLFiller.in
sed -i "s/variable	CLr0pf		equal	/variable	CLr0pf		equal		${CLr0pf} #/g" 			ser_tmp_CLhomopolymer+CLFiller.in


cp GenerateLammpsInput_HP+F.py ser_tmp_GenerateLammpsInput_HP+F.py
sed -i "s/Density=/Density=${Density} #/g"				ser_tmp_GenerateLammpsInput_HP+F.py
sed -i "s/chainLenght=/chainLenght=${chainLenght} #/g"			ser_tmp_GenerateLammpsInput_HP+F.py
sed -i "s/bondLenght=/bondLenght=${bondLenght} #/g"			ser_tmp_GenerateLammpsInput_HP+F.py
sed -i "s/BoxSideLenght=/BoxSideLenght=${BoxSideLenght} #/g"		ser_tmp_GenerateLammpsInput_HP+F.py
sed -i "s/FillerRadius=/FillerRadius=${FillerRadius} #/g"		ser_tmp_GenerateLammpsInput_HP+F.py
sed -i "s/FillerbondLenght=/FillerbondLenght=${FillerbondLenght} #/g"	ser_tmp_GenerateLammpsInput_HP+F.py
sed -i "s/nFillers=/nFillers=${nFillers} #/g"				ser_tmp_GenerateLammpsInput_HP+F.py
#

#

cp Bead_type.sh ser_tmp_Bead_type.sh
##################################################



##################################################

sh ser_tmp_build_matrix-fillers.sh

##################################################

rm ser_tmp_build_matrix-fillers.sh
rm ser_tmp_CLhomopolymer+CLFiller.in
rm ser_tmp_GenerateLammpsInput_HP+F.py
rm Bead.py CLhomopolymer+CLFiller.in Filler.py settings.py build_matrix-fillers.sh 
rm  GenerateLammpsInput_HP+F.py System.py Chain.py FillerBead.py
rm Bead_type.sh ser_tmp_Bead_type.sh

