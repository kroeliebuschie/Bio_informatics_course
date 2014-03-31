#!/usr/bin/env bash
##################################
#                                #
#     this script runs the       #
#    biotable assignment which   #
#     is a ruby gem assigment    #
#                                #
#    author: M. Nellen, 2014     #
#                                #
##################################

#open a csv filter out some numbers and save it in another csv
bio-table table1.csv --in-format csv --format tab > table1.tab
bio-table table1.tab --num-filter "values[0] < 5" > table1New.csv
