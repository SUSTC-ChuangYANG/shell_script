#!/bin/bash
# This script will output a csv file which contains (student_id, score, auto_generated_comments)

# parameters
myFile="./banker.cpp"                            # the filename of code you want to check
test_cases="/home/ubuntu/test/lab7/test_cases/"  # the route of your test cases
                                                 # the name format of test case should be case_i, ans_i
case_count=5                                     # the count of your test cases
output="../score_list"                           # the output file route
timeout_setting=5                                # timeout for single code check

echo "studentid,score,comments" > score_list

for d in ./*/
do(
  cd "$d"
  sid=${PWD##*/} # student id
  total_score=0

  if [ ! -f "$myFile" ]
  then
       echo "$sid,0,NOT_FOUND_$myFile">> $output   # check if target file exist, notice：wrong file name included, then comment “file not found” 
  else   
     if [ -f "./a.out" ]
     then
       rm ./a.out
     fi

     g++ -std=c++11 $myFile > /dev/null 2>&1      # write your complie command here
     if [ ! -f "./a.out" ]
     then
       echo "$sid,0,COMPILE_ERROR" >> $output     # check and comment “compile error” 
     else
       fb=""
       for i in $(seq 1 $case_count)
       do
         case=$test_cases"case_$i"
         ans=$test_cases"ans_$i"
         res="res_$i"
         timeout $timeout_setting ./a.out < $case > tmp_res
         line_cnt=$(wc -l < $ans)
         head -n $line_cnt tmp_res > $res
         cond=$(diff -w $res $ans | wc -l)

         if [ $cond == 0 ]
         then
            if [ $i == 1 ]                        # write your own test case score rule here. On default, the first case(basic case) will get 60 points, other cases will get 10 points per case.
            then
               total_score=$((total_score + 60))
            else
               total_score=$((total_score + 10))
            fi
         else
            fb="$fb"Failed"$i "
         fi

       done
       echo "$sid,$total_score,$fb" >> $output
     fi
  fi
  echo "$sid finished!"
)done
