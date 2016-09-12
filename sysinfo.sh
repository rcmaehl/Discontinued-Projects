#!/bin/bash
echo Gathering System Info. Please Wait...
#GET SYSTEM INFO
SYSMANF=`sudo dmidecode -q -t system | grep -i 'Manufacturer'`
SYSNAME=`sudo dmidecode -q -t system | grep -i 'Product Name'`
SYSTYPE=`sudo dmidecode -q -t chassis | grep -i Type`
#GET BIOS INFO
MBOVEND=`sudo dmidecode -q -t bios | grep -i Vendor`
MBORELS=`sudo dmidecode -q -t bios | grep -i 'Release Date'`
MBOREVS=`sudo dmidecode -q -t bios | grep -i 'Bios Revision'`
#GET SIMPLE CPU INFO
CPUMANF=`sudo dmidecode -q -t processor | grep -i 'Manufacturer'`
CPUCURS=`sudo dmidecode -q -t processor | grep -i 'Current Speed'`
CPUMAXS=`sudo dmidecode -q -t processor | grep -i 'Max Speed'`
#GET MEMORY INFO
RAMSIZE=`sudo dmidecode -q -t memory | grep -i Size`
RAMFREQ=`sudo dmidecode -q -t memory | grep -i Speed -m 1`
RAMTYPE=`sudo dmidecode -q -t memory | grep -i Type -m 2`
RAMFOFA=`sudo dmidecode -q -t memory | grep -i 'Form Factor' -m 1`
RAMMCAP=`sudo dmidecode -q -t memory | grep -i 'Maximum Capacity'`
#GET EXTENDED CPU INFO
CPUNUMB=`sudo lscpu | grep -i 'CPU(s)'`
CPUARCH=`sudo lscpu | grep -i Architecture`
CPUMODE=`sudo lscpu | grep -i 'CPU op-mode(s)'`
CPUL1DC=`sudo lscpu | grep -i 'L1d cache'`
CPUL1IC=`sudo lscpu | grep -i 'L1i cache'`
CPUL2CA=`sudo lscpu | grep -i 'L2 cache'`
sudo clear
echo Sysinfo - Ubuntu Version - 1.0.0.3 - By Robert Maehl and www.FCoFix.org
echo ----------------------------------------------------------------------------
echo [SYSTEM]
echo $SYSTYPE
echo $SYSNAME
echo $SYSMANF
echo
echo [BIOS]
echo $MBOREVS
echo $MBORELS
echo $MBOVEND
echo
echo [CPU]
echo $CPUNUMB
echo $CPUL1DC
echo $CPUL1IC
echo $CPUL2CA
echo $CPUARCH
echo $CPUMANF
echo $CPUMAXS
echo $CPUCURS
echo $CPUMODE
echo
echo [RAM]
echo $RAMFOFA
echo $RAMMCAP
echo $RAMFREQ
echo $RAMSIZE
echo $RAMTYPE
exit 
