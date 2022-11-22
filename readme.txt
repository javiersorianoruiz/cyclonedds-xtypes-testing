Using container in docker hub:
capgeminigit/nearshorespain_repo:cyclonedds-python_issue_105_v2

cyclonedds version:
git clone https://github.com/eclipse-cyclonedds/cyclonedds.git --branch 0.10.2


---------------------------------------------------
Python XTypes Testing:

cyclonedds-python version:
git clone https://github.com/eclipse-cyclonedds/cyclonedds-python.git -b 0.10.2

IDLC Generation for python:
/usr/local/lib/cyclonedds/bin/idlc -l py -Wno-implicit-extensibility -o ${WORK_PATH} ${WORK_PATH}/$IDL_FILE
    Example:
            cd <path_folder_test>
            /usr/local/lib/cyclonedds/bin/idlc -l py -Wno-implicit-extensibility -o `pwd` `pwd`/test.idl

------------------------------------------

CPP XTypes Testing:

cyclonedds-cxx version (fork reicheratwork branch fix_issue_329, downloaded 22-nov-22)
git clone git@github.com:reicheratwork/cyclonedds-cxx.git -b fix_issue_329

Issue 329 raised by me (6-oct-22):
Title: xtypes is not working in our environment
https://github.com/eclipse-cyclonedds/cyclonedds-cxx/issues/329

cyclonedds-cxx compilation:

cmake   -DCMAKE_INSTALL_PREFIX=/usr/local/lib/cyclonedds-cxx \
            -DCMAKE_PREFIX_PATH=/usr/local/lib/cyclonedds \
            -DBUILD_EXAMPLES=ON \
            -DCMAKE_BUILD_TYPE=Debug \
            -DENABLE_TOPIC_DISCOVERY=ON \
            -DENABLE_TYPE_DISCOVERY=ON \
            ..

//compilation
cmake --build .
//Instalation
cmake --build . --target install

#Examples XTypes CXX compilation 

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/cyclonedds-cxx/lib/