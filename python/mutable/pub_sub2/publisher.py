"""
 * Copyright(c) 2021 ZettaScale Technology and others
 *
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License v. 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0, or the Eclipse Distribution License
 * v. 1.0 which is available at
 * http://www.eclipse.org/org/documents/edl-v10.php.
 *
 * SPDX-License-Identifier: EPL-2.0 OR BSD-3-Clause
"""

import time
import random

from cyclonedds.core import Qos, Policy
from cyclonedds.domain import DomainParticipant
from cyclonedds.pub import Publisher, DataWriter
from cyclonedds.topic import Topic
from cyclonedds.util import duration

from module_test import Msg

qos = Qos(
    Policy.Reliability.BestEffort,
    Policy.Deadline(duration(microseconds=10)),
    Policy.Durability.Transient,
    Policy.History.KeepLast(10)
)

domain_participant = DomainParticipant(0)
#modify for each test
topic = Topic(domain_participant, 'xtypes_test_python_mutable_1', Msg)
publisher = Publisher(domain_participant)
writer = DataWriter(publisher, topic)


#modify for each test
msg = Msg(userID=222,extra_value=333,message="Goodbye World")

while True:
    writer.write(msg)
    #modify for each test
    print(">> Wrote xtypes_test_python_mutable_1 msg")
    time.sleep(3.0)
