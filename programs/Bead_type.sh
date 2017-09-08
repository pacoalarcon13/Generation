#!/bin/bash
#28/01/2016
#Authors
# Sebastian Echeverri Restrepo	sebastianecheverrir@gmail.com

#This set of 

#It needs: 	

#files needed


#files output (.data file for lammps)

#how to run


###################################################
#Variables given by the user
###################################################


#Topology
links=$1 		#Number of crosslinkers per 
			# polymer chain
linksFillers=$2  	#Number of crosslinkers per filler

chainL=$3		#Number of beads per chain


#######################################################
InputFile=homopolymer+Filler.data


#Reading the number of beads
nBeads=`grep atoms $InputFile | awk '{print $1}'`
#echo $nBeads

#Reading the number of bonds
nBonds=`grep bonds $InputFile | awk '{print $1}'`
#echo $nBeads

nBondsType1=`tail -$nBonds homopolymer+Filler.data | awk '{if ($2==1) {sum=sum+1}} END{print sum+1}'`

nBondsType2=`tail -$nBonds homopolymer+Filler.data | awk '{if ($2==2) {sum=sum+1}} END{print sum}'`
# echo $nBonds
# echo $nBondsType1
# echo $nBondsType2

#Reading the number of chains
nChains=`awk -v nBeads=$nBeads '{if (NR>23 && NR<=nBeads+23 && $3==1) \
	print $0}' $InputFile | \
	tail -1 | awk '{print $2}'`

#echo $nChains

#Reading the number of fillers
nMolecules=`awk -v nBeads=$nBeads '{if (NR>23 && NR<=nBeads+23 && $3==2) \
	      print $0}' $InputFile | \
	      tail -1 | awk '{print $2}'`
if [ -z "$nMolecules" ]
  then 
  nMolecules=0
fi

#echo  $nMolecules
nFillers=`expr $nMolecules - $nChains`


#Reading the number of filler beads
nFillerBeads=`awk -v nBeads=$nBeads '{if (NR>23 && NR<=nBeads+23 && $3==2) \
	      sum=sum+1} END{print sum}' $InputFile `

#Reading the number of Polymer beads
nPolymerBeads=`awk -v nBeads=$nBeads '{if (NR>23 && NR<=nBeads+23 && $3==1) \
	      sum=sum+1} END{print sum}' $InputFile `
# echo $nPolymerBeads
# echo $nFillerBeads
# echo $nBeads

	      

#reading the heading of the data file
awk  '{if (NR<=8) print $0}' $InputFile > homopolymer+Filler_Types.data
echo "     4  atom types">> homopolymer+Filler_Types.data
echo "     4  bond types">> homopolymer+Filler_Types.data
echo "     2 extra bond per atom" >> homopolymer+Filler_Types.data
awk  '{if (NR>10 && NR<=20) print $0}' $InputFile >> homopolymer+Filler_Types.data
echo "    3    1.0" >> homopolymer+Filler_Types.data
echo "    4    1.0" >> homopolymer+Filler_Types.data
awk  '{if (NR>=21 && NR<=23) print $0}' $InputFile >> homopolymer+Filler_Types.data


#reading the polymer particles. 
#The particles selected to make crosslinks with other polymer particles
#	will now have type 3
awk -v nBeads=$nBeads -v chainL=$chainL -v links=$links\
   'BEGIN{srand();}{\
      if (NR>23 && NR<=nBeads+23 && $3==1) \
	{\
	  if (rand()<=((links/2)/chainL)) \
	    {\
	      print $1, $2, 3, $4, $5, $6 \
	    }\
	  else \
	    {\
	      print $1, $2, $3, $4, $5, $6 \
	    }\
	}\
    }' $InputFile >> homopolymer+Filler_Types.data


##############################################33
#calculating the number of beads on the outer shell of the filler.
# this beads have less than 12 neighbors
nFillerBeadsShell=0
for (( i=`expr $nPolymerBeads + 1 `; i<=$nBeads; i++ ))
do
   Neighbors=`tail -$nBondsType2 homopolymer+Filler.data | grep  " $i" | wc -l`
   if [ $Neighbors -lt 11 ] 
    then
         ((nFillerBeadsShell++))
         FillerBeadsShell+=($i)
   fi
    
done

#echo ${FillerBeadsShell[*]} 

#reading the filler particles. 
#The particles selected to make crosslinks with polymer particles
#	will now have type 4
# echo $nFillerBeads
# echo $nFillerBeadsShell

#temporary file that will contain all the filler beads
awk -v nBeads=$nBeads  \
   '{\
      if (NR>23 && NR<=nBeads+23 && $3==2) \
	{\
	      print $1, $2, $3, $4, $5, $6 \
	}\
    }' $InputFile > tmpfillerbeads


#changing the particle type to some of the particles that were 
#	identified to be on the shell of the fillers

for i in "${FillerBeadsShell[@]}"
do
#   echo $i
  awk -v bead=$i -v nFillerBeadsShell=$nFillerBeadsShell -v nFillers=$nFillers -v linksFillers=$linksFillers\
    'BEGIN{srand();}\
    {\
 	  if (rand()<=nFillers*linksFillers/nFillerBeadsShell && $1==bead) \
 	    {\
 	      print $1, $2, 4, $4, $5, $6 \
 	    }\
 	  else \
 	    {\
 	      print $1, $2, $3, $4, $5, $6 \
 	    }\
    }' tmpfillerbeads > tmpfillerbeads2
    
  mv tmpfillerbeads2 tmpfillerbeads

done

cat tmpfillerbeads >> homopolymer+Filler_Types.data

############################################################# 
 
awk -v nBeads=$nBeads '{if (NR>nBeads+23) print $0}' $InputFile >> homopolymer+Filler_Types.data



rm homopolymer+Filler.data tmpfillerbeads




