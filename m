From: Iwona Winiarska <iwona.winiarska@intel.com>
Date: Tue,  3 Aug 2021 13:31:34 +0200
Subject: [PATCH v2 15/15] docs: Add PECI documentation
In-Reply-To: <20210803113134.2262882-1-iwona.winiarska@intel.com>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
Message-ID: <20210803113134.2262882-16-iwona.winiarska@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a brief overview of PECI and PECI wire interface.
The documentation also contains kernel-doc for PECI subsystem internals
and PECI CPU Driver API.

Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 Documentation/index.rst      |  1 +
 Documentation/peci/index.rst | 16 ++++++++++++
 Documentation/peci/peci.rst  | 48 ++++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |  1 +
 4 files changed, 66 insertions(+)
 create mode 100644 Documentation/peci/index.rst
 create mode 100644 Documentation/peci/peci.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 54ce34fd6fbd..7671f2cd474f 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -137,6 +137,7 @@ needed).
    misc-devices/index
    scheduler/index
    mhi/index
+   peci/index
 
 Architecture-agnostic documentation
 -----------------------------------
diff --git a/Documentation/peci/index.rst b/Documentation/peci/index.rst
new file mode 100644
index 000000000000..989de10416e7
--- /dev/null
+++ b/Documentation/peci/index.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+====================
+Linux PECI Subsystem
+====================
+
+.. toctree::
+
+   peci
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/peci/peci.rst b/Documentation/peci/peci.rst
new file mode 100644
index 000000000000..a12c8e10c4a9
--- /dev/null
+++ b/Documentation/peci/peci.rst
@@ -0,0 +1,48 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+========
+Overview
+========
+
+The Platform Environment Control Interface (PECI) is a communication
+interface between Intel processor and management controllers
+(e.g. Baseboard Management Controller, BMC).
+PECI provides services that allow the management controller to
+configure, monitor and debug platform by accessing various registers.
+It defines a dedicated command protocol, where the management
+controller is acting as a PECI originator and the processor - as
+a PECI responder.
+PECI can be used in both single processor and multiple-processor based
+systems.
+
+NOTE:
+Intel PECI specification is not released as a dedicated document,
+instead it is a part of External Design Specification (EDS) for given
+Intel CPU. External Design Specifications are usually not publicly
+available.
+
+PECI Wire
+---------
+
+PECI Wire interface uses a single wire for self-clocking and data
+transfer. It does not require any additional control lines - the
+physical layer is a self-clocked one-wire bus signal that begins each
+bit with a driven, rising edge from an idle near zero volts. The
+duration of the signal driven high allows to determine whether the bit
+value is logic '0' or logic '1'. PECI Wire also includes variable data
+rate established with every message.
+
+For PECI Wire, each processor package will utilize unique, fixed
+addresses within a defined range and that address should
+have a fixed relationship with the processor socket ID - if one of the
+processors is removed, it does not affect addresses of remaining
+processors.
+
+PECI subsystem internals
+------------------------
+
+.. kernel-doc:: include/linux/peci.h
+
+PECI CPU Driver API
+-------------------
+.. kernel-doc:: include/linux/peci-cpu.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 4861a214d9fe..c50d4d0005e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14527,6 +14527,7 @@ R:	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
 L:	openbmc at lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/peci/
+F:	Documentation/peci/
 F:	drivers/peci/
 F:	include/linux/peci-cpu.h
 F:	include/linux/peci.h
-- 
2.31.1

