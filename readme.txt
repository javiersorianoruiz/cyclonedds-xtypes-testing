Using container in docker hub:
capgeminigit/nearshorespain_repo:cyclonedds-python_issue_105_v2

cyclonedds version:
git clone https://github.com/eclipse-cyclonedds/cyclonedds.git --branch 0.10.2


---------------------------------------------------
---------------  Python XTypes Testing: --------------- 

cyclonedds-python version:
git clone https://github.com/eclipse-cyclonedds/cyclonedds-python.git -b 0.10.2

IDLC Generation for python:
/usr/local/lib/cyclonedds/bin/idlc -l py -Wno-implicit-extensibility -o ${WORK_PATH} ${WORK_PATH}/$IDL_FILE
    Example:
            cd <path_folder_test>
            /usr/local/lib/cyclonedds/bin/idlc -l py -Wno-implicit-extensibility -o `pwd` `pwd`/test.idl

------------------------------------------

--------------- CPP XTypes Testing: -------------------------

23-nov-22 After the error reported the day before and recommendations cyclonedds-cxx github's team:
    reicheratwork : Fixed this new issue, and also rebased the commits onto the current master, as this is required to have CycloneDDS-CXX compile with the current master of CycloneDDS-C

    cyclonedds (C version) downloaded and installed version current master (23-nov-22)
    git clone git@github.com:eclipse-cyclonedds/cyclonedds.git
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local/lib/cyclonedds -DBUILD_EXAMPLES=ON -DCMAKE_BUILD_TYPE=Debug -DENABLE_TOPIC_DISCOVERY=ON -DENABLE_TYPE_DISCOVERY=ON ..

    cyclonedds-cxx (CPP version) downloaded and installed version current master (23-nov-22)
    git clone https://github.com/eclipse-cyclonedds/cyclonedds-cxx.git
    Same compilation and Instalation that 22-nov-22 version (see below)

22-nov-22 (Found problem reported to cyclonedds-cxx github's team)
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

GitHub project in my repository created to house all the developed tests related with XTypes in cyclonedds for the three implementations
considered (C, CXX and Python)

https://github.com/javiersorianoruiz/cyclonedds-xtypes-testing
git clone git@github.com:javiersorianoruiz/cyclonedds-xtypes-testing.git
cd /app/cyclonedds-xtypes-testing/cpp/build
rm -rf *
rm -rf ../appendable/build/*
rm -rf ../appendable/pub_sub1/build/*
rm -rf ../appendable/pub_sub2/build/*
cmake ..
make

#needed for isolated compilation in a inner folder:
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/cyclonedds-cxx/lib/

export CYCLONEDDS_URI=/app/cyclonedds-xtypes-testing/debug_dds.xml