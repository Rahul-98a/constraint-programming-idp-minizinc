# Constraint Programming with IDP and MiniZinc
### Description
Solving the *Pizza* problem as described in the *LP/CP Programming Contest 2015* using the IDP and MiniZinc declaritve solving tools. In part 1, the problem
will be solved using IDP and MiniZinc. In part 2 the solving performance of MiniZinc will be improved.

Link to problem: http://picat-lang.org/lp_cp_pc/


### Steps to install MiniZinc and IDP
MiniZinc
- sudo apt-get update
- sudo apt-get install
- sudo apt install minizinc

IDP (This installation process is for Linux machines)
- 1. Install the IDP binaries from the IDP website
	- https://dtai.cs.kuleuven.be/drupal/software/idp/try
- 2. Once the tar folder is download, move it to your home directory
- 3. Unzip the tar file
	- tar -xf idp-linux-latest.tar.gz
- 4. Move the folders “bin, include, lib, share, and var” out of the IDP folder (named something like “idp3-3.7.1-Linux”) and put 
     them directly in your home directory
- 5. Once those folders are in your home directory run the following command
	- export PATH=”$HOME/bin:$PATH”

### Steps to run MiniZinc and IDP

MiniZinc
- minizinc <minizinc_file>.mzn <input_file>.dzn

IDP
- IDP <idp_file>.idp <input_file>.idp

### Files provided
Four folders are provided, each containing different files.

Part 1 – Minizinc
- pizza.mzn: The specification file for the Pizza problem in MiniZinc for part 1 or the report.
- instance.dzn: 20 MiniZinc test instances for part 1 of the report. Note, MiniZinc and IDP are using same tests 
                instances, just the syntax of the files for MiniZinc and IDP are different.

Part 1 – IDP
- pizza.idp: The specification file for the Pizza problem in IDP for part 1 or the report.
- instance.idp: 20 IDP test instances for part 1 of the report. Note, MiniZinc and IDP are using same tests instances, 
                just the syntax of the files for MiniZinc and IDP are different.

Part 2 – MiniZinc
- pizza.mzn: The specification file for the Pizza problem (as an optimization problem) using the original set of constraints, for
             part 2 of the report.
- pizza2.mzn: The specification file for the Pizza problem (as an optimization problem) including the redundant constraints, for
              part 2 of the report.
- instance.dzn: 15 MiniZinc test instances for part 2 of the report.

Data
- Data–Part1: Collected data for part 1 of the report.
- Data-Part2: Collected data for part 2 of the report.
