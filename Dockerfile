FROM        ubuntu:20.04

# update and install dependencies
RUN         apt-get update \
                && apt-get install -y \
                    software-properties-common \
                    wget \
                && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
                && apt-get update \
                && apt-get install -y \
                    make \
                    git \
                    curl \
                    vim \
                && apt-get install -y cmake \
                && apt-get install -y gcc-11 \
                && apt-get install -y g++-11 \
                && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100 \
                && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 100 \
                && apt-get install -y gdb \
                && apt-get -y install gcovr


WORKDIR /root/

RUN             apt install -y python3-pip

#cyclonedds C compilation and installation (version current master by 28-nov-22)
RUN git clone https://github.com/eclipse-cyclonedds/cyclonedds.git 
WORKDIR /root/cyclonedds/
RUN mkdir build
WORKDIR /root/cyclonedds/build
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr/local/lib/cyclonedds -DBUILD_EXAMPLES=ON ..
RUN cmake --build .
RUN cmake --build . --target install

#cyclonedds python compilation and installation (version current master by 28-nov-22)
WORKDIR /root/
RUN git clone https://github.com/eclipse-cyclonedds/cyclonedds-python.git
WORKDIR /root/cyclonedds-python/
RUN         export CYCLONEDDS_HOME="/usr/local/lib/cyclonedds" \
            && python3 setup.py build \
            && pip3 install .

#install tool killall needed for the tests (script generate_test.sh in folder cyclonedds-python-checkReservedKeyword/tests/)
RUN apt-get install psmisc

#googletest compilation and installation 
WORKDIR /root/
RUN git clone https://github.com/google/googletest.git -b release-1.12.1
WORKDIR /root/googletest/
RUN mkdir build
WORKDIR /root/googletest/build
RUN cmake ..
RUN make
RUN make install



#cyclonedds-cxx compilation and installation (version current master by 28-nov-22)
WORKDIR /root/
RUN git clone https://github.com/eclipse-cyclonedds/cyclonedds-cxx.git 
WORKDIR /root/cyclonedds-cxx/
RUN mkdir build
WORKDIR /root/cyclonedds-cxx/build
RUN cmake   -DCMAKE_INSTALL_PREFIX=/usr/local/lib/cyclonedds-cxx \
            -DCMAKE_PREFIX_PATH=/usr/local/lib/cyclonedds \
            -DBUILD_EXAMPLES=ON \
            -DCMAKE_BUILD_TYPE=Debug \
            -DENABLE_TOPIC_DISCOVERY=ON \
            -DENABLE_TYPE_DISCOVERY=ON \
            ..
RUN cmake --build .
RUN cmake --build . --target install

# RUN useradd -ms /bin/bash jasorian
#To continue working with the new created user 
#USER newuser
#WORKDIR /home/newuser


#copy and compilation example to reproduce issue 252
#https://github.com/eclipse-cyclonedds/cyclonedds-cxx/issues/252
# WORKDIR /root/
# ADD issue_252 /root/issue_252
# RUN rm -rf /root/issue_252/build
# RUN mkdir /root/issue_252/build
# WORKDIR /root/issue_252/build/
# RUN cmake ..
# RUN make

