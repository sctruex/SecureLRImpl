#!/bin/bash
BIN=./bin/linreg
MOD=9999999
SEED=200
DIM=100 #3618
A_ALICE=$BIN/a_alice
A_BOB=$BIN/a_bob
B_ALICE=$BIN/b_alice
B_BOB=$BIN/b_bob
C_ALICE=$BIN/c_alice
C_BOB=$BIN/c_bob
X_ALICE=$BIN/x_alice
X_BOB=$BIN/x_bob
Y_ALICE=$BIN/y_alice
Y_BOB=$BIN/y_bob
XY_ALICE=$BIN/xy_alice
XY_BOB=$BIN/xy_bob
OUTPUT=$BIN/output
OUT_ALICE=$BIN/out_alice
OUT_BOB=$BIN/out_bob
R_ALICE=$BIN/r_alice
RP_ALICE=$BIN/rp_alice
R_BOB=$BIN/r_bob
RP_BOB=$BIN/rp_bob

PORT=7878
ALICE_HOST=127.0.0.1

if [[ ! -f $BIN ]];
then
mkdir -p $BIN
fi

case $1 in

pre)
$0 inputgen
$0 ti
;;


alice)
$BIN/linreg_alice $MOD $PORT $X_ALICE $Y_ALICE $A_ALICE $B_ALICE $C_ALICE $DIM $OUT_ALICE $XY_ALICE $R_ALICE $RP_ALICE 
exit 0
;;

bob)
$BIN/linreg_bob $MOD $ALICE_HOST $PORT $X_BOB $Y_BOB $A_BOB $B_BOB $C_BOB $DIM $OUT_BOB $XY_BOB $R_BOB $RP_BOB
exit 0
;;

ti)
$BIN/linreg_ti $MOD $DIM $A_ALICE $A_BOB $B_ALICE $B_BOB $C_ALICE $C_BOB $SEED $R_ALICE $R_BOB $RP_ALICE $RP_BOB 
exit 0
;;

inputgen)
$BIN/linreg_inputgen $MOD $DIM $X_ALICE $X_BOB $Y_ALICE $Y_BOB $OUTPUT $XY_ALICE $XY_BOB $SEED
exit 0
;;

*)
  echo "Usage: $0 (alice|bob|ti|inputgen)"
  exit 2
  ;;

esac