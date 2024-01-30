From: Corona, Ernesto <ernesto.corona@intel.com>
Date: Tue, 30 Jan 2024 23:30:47 +0000
Subject: [PATCH 30 4/7] Add ABI documentation
Message-ID: <LV8PR11MB8463E4402495BACB9E3ACE588B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Added document that describe the ABI for JTAG class driver

Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
Signed-off-by: Omar Castro <omar.eduardo.castro@linux.intel.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Steven Filary <steven.a.filary@intel.com>
Cc: Jiri Pirko <jiri@nvidia.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>
Cc: Amithash Prasad <amithash@fb.com>
Cc: Patrick Williams <patrickw3@fb.com>
Cc: Luke Chen <luke_chen@aspeedtech.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Rgrs <rgrs@protonmail.com>
---
v29->v30
- Change ABI documentation to reStructuredText (rst) format.
Comments pointed by Paul Fertser
- SRST added to documentation.
- Remove call flow as it was confusing.
- Replaced unsiged int for signed int on file descriptors.
- Specify frq for SIOCFREQ and GIOCFREQ in Hertz.
- Remvoed usleep that was not used on examples.
- Documented padding.

v28->v29
Comments pointed by Steven Filary <steven.a.filary@intel.com>
- Expand bitbang function to accept multiples bitbang operations within
  a single JTAG_IOCBITBANG call. It will receive a buffer with TDI and
  TMS values and it is expected that driver fills TDO fields with its
  corresponding output value for every transaction.

v27->v28
Comments pointed by Steven Filary <steven.a.filary@intel.com>
- Replace JTAG_IOCRUNTEST with JTAG_SIOCSTATE adding support for all
  TAPC end states in SW mode using a lookup table to navigate across
  states.
- Add support for simultaneous READ/WRITE
transfers(JTAG_READ_WRITE_XFER).
- Support for switching JTAG controller mode between target and host
  controller mode.
- Setup JTAG controller mode to host controller only when the driver
  is opened, letting other HW to own the JTAG bus when it isn't in use.
- Include JTAG bit bang IOCTL for low level JTAG control usage
  (JTAG_IOCBITBANG).

v26->v27
v25->v26
Comments pointed by Randy Dunlap <rdunlap@infradead.org>
- fix spell in ABI documentation

v24->v25
Comments pointed by Greg KH <gregkh@linuxfoundation.org>
- Fixed documentation according to new open() behavior

v23->v24
v22->v23
Comments pointed by Randy Dunlap <rdunlap@infradead.org>
- fix spell in ABI doccumentation

v21->v22
Comments pointed by Randy Dunlap <rdunlap@infradead.org>
- fix spell in ABI doccumentation

v20->v21
Comments pointed by Randy Dunlap <rdunlap@infradead.org>
- Fix JTAG dirver help in Kconfig

v19->v20
Comments pointed by Randy Dunlap <rdunlap@infradead.org>
- Fix JTAG doccumentation

v18->v19
Pavel Machek <pavel@ucw.cz>
- Added JTAG doccumentation to Documentation/jtag

v17->v18
v16->v17
v15->v16
v14->v15
v13->v14
v12->v13
v11->v12 Tobias Klauser <tklauser@distanz.ch>
Comments pointed by
- rename /Documentation/ABI/testing/jatg-dev -> jtag-dev
- Typo: s/interfase/interface
v10->v11
v9->v10
Changes added by Oleksandr:
- change jtag-cdev to jtag-dev in documentation
- update KernelVersion and Date in jtag-dev documentation;
v8->v9
v7->v8
v6->v7
Comments pointed by Pavel Machek <pavel@ucw.cz>
- Added jtag-cdev documentation to Documentation/ABI/testing folder
---
 Documentation/ABI/testing/jtag-dev  |  23 +++
 Documentation/jtag/index.rst        |  18 +++
 Documentation/jtag/jtag-summary.rst |  49 ++++++
 Documentation/jtag/jtagdev.rst      | 222 ++++++++++++++++++++++++++++
 4 files changed, 312 insertions(+)
 create mode 100644 Documentation/ABI/testing/jtag-dev
 create mode 100644 Documentation/jtag/index.rst
 create mode 100644 Documentation/jtag/jtag-summary.rst
 create mode 100644 Documentation/jtag/jtagdev.rst

diff --git a/Documentation/ABI/testing/jtag-dev b/Documentation/ABI/testing/jtag-dev
new file mode 100644
index 000000000000..93821506d70e
--- /dev/null
+++ b/Documentation/ABI/testing/jtag-dev
@@ -0,0 +1,23 @@
+What:		/dev/jtag[0-9]+
+Date:		July 2018
+KernelVersion:	4.20
+Contact:	oleksandrs at mellanox.com
+Description:
+		The misc device files /dev/jtag* are the interface
+		between JTAG controller interface and userspace.
+
+		The ioctl(2)-based ABI is defined and documented in
+		[include/uapi]<linux/jtag.h>.
+
+		The following file operations are supported:
+
+		open(2)
+		Opens and allocates file descriptor.
+
+		ioctl(2)
+		Initiate various actions.
+		See the inline documentation in [include/uapi]<linux/jtag.h>
+		for descriptions of all ioctls.
+
+Users:
+		userspace tools which wants to access to JTAG bus
diff --git a/Documentation/jtag/index.rst b/Documentation/jtag/index.rst
new file mode 100644
index 000000000000..8a2761d1c17e
--- /dev/null
+++ b/Documentation/jtag/index.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+Joint Test Action Group (JTAG)
+==============================
+
+.. toctree::
+   :maxdepth: 1
+
+   jtag-summary
+   jtagdev
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/jtag/jtag-summary.rst b/Documentation/jtag/jtag-summary.rst
new file mode 100644
index 000000000000..07cfa7a761d7
--- /dev/null
+++ b/Documentation/jtag/jtag-summary.rst
@@ -0,0 +1,49 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================
+Linux kernel JTAG support
+====================================
+
+Introduction to JTAG
+====================
+
+JTAG is an industry standard for verifying hardware. JTAG provides access to
+many logic signals of a complex integrated circuit, including the device pins.
+
+A JTAG interface is a special interface added to a chip.
+Depending on the version of JTAG, two, four, or five pins are added.
+
+The connector pins are:
+ * TDI (Test Data In)
+ * TDO (Test Data Out)
+ * TCK (Test Clock)
+ * TMS (Test Mode Select)
+ * TRST (Test Reset) optional
+
+JTAG interface is designed to have two parts - basic core driver and
+hardware specific driver. The basic driver introduces a general interface
+which is not dependent of specific hardware. It provides communication
+between user space and hardware specific driver.
+Each JTAG device is represented as a char device from (jtag0, jtag1, ...).
+Access to a JTAG device is performed through IOCTL calls.
+
+Call flow example:
+::
+
+	User: open  -> /dev/jatgX -> JTAG core driver -> JTAG hardware specific driver
+	User: ioctl -> /dev/jtagX -> JTAG core driver -> JTAG hardware specific driver
+	User: close -> /dev/jatgX -> JTAG core driver -> JTAG hardware specific driver
+
+
+THANKS TO
+---------
+Contributors to Linux-JTAG discussions include (in alphabetical order,
+by last name):
+
+- Omar Castro
+- Ernesto Corona
+- Steven Filary
+- Vadim Pasternak
+- Jiri Pirko
+- Oleksandr Shamray
+- Billy Tsai
\ No newline at end of file
diff --git a/Documentation/jtag/jtagdev.rst b/Documentation/jtag/jtagdev.rst
new file mode 100644
index 000000000000..883df46ec117
--- /dev/null
+++ b/Documentation/jtag/jtagdev.rst
@@ -0,0 +1,222 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+JTAG userspace API
+==================
+JTAG controller devices can be accessed through a character misc-device.
+
+Each JTAG controller interface can be accessed by using /dev/jtagN.
+
+JTAG system calls set:
+ * SIR (Scan Instruction Register, IEEE 1149.1 Instruction Register scan);
+ * SDR (Scan Data Register, IEEE 1149.1 Data Register scan);
+ * RUNTEST (Forces the IEEE 1149.1 bus to a run state for a specified number of clocks.
+
+open(), close()
+---------------
+Open/Close  device:
+::
+
+	jtag_fd = open("/dev/jtag0", O_RDWR);
+	close(jtag_fd);
+
+ioctl()
+-------
+All access operations to JTAG devices are performed through ioctl interface.
+The IOCTL interface supports these requests:
+::
+
+	JTAG_SIOCSTATE - Force JTAG state machine to go into a TAPC state
+	JTAG_SIOCFREQ - Set JTAG TCK frequency
+	JTAG_GIOCFREQ - Get JTAG TCK frequency
+	JTAG_IOCXFER - send/receive JTAG data Xfer
+	JTAG_GIOCSTATUS - get current JTAG TAP state
+	JTAG_SIOCMODE - set JTAG mode flags.
+	JTAG_IOCBITBANG - JTAG bitbang low level control.
+	JTAG_SIOCTRST - Set TRST pin for JTAG.
+
+JTAG_SIOCFREQ
+~~~~~~~~~~~~~
+Set JTAG clock speed:
+::
+
+	unsigned int jtag_fd;
+	ioctl(jtag_fd, JTAG_SIOCFREQ, &frq);
+
+JTAG_GIOCFREQ
+~~~~~~~~~~~~~
+Get JTAG clock speed:
+::
+
+	unsigned int jtag_fd;
+	ioctl(jtag_fd, JTAG_GIOCFREQ, &frq);
+
+JTAG_SIOCSTATE
+~~~~~~~~~~~~~~
+Force JTAG state machine to go into a TAPC state
+::
+
+	struct jtag_tap_state {
+		__u8	reset;
+		__u8	from;
+		__u8	endstate;
+		__u32	tck;
+	};
+
+reset: one of below options
+::
+
+	JTAG_NO_RESET - go through selected endstate from current state
+	JTAG_FORCE_RESET - go through TEST_LOGIC/RESET state before selected endstate
+
+endstate: any state listed in jtag_tapstate enum
+::
+
+	enum jtag_tapstate {
+		JTAG_STATE_TLRESET,
+		JTAG_STATE_IDLE,
+		JTAG_STATE_SELECTDR,
+		JTAG_STATE_CAPTUREDR,
+		JTAG_STATE_SHIFTDR,
+		JTAG_STATE_EXIT1DR,
+		JTAG_STATE_PAUSEDR,
+		JTAG_STATE_EXIT2DR,
+		JTAG_STATE_UPDATEDR,
+		JTAG_STATE_SELECTIR,
+		JTAG_STATE_CAPTUREIR,
+		JTAG_STATE_SHIFTIR,
+		JTAG_STATE_EXIT1IR,
+		JTAG_STATE_PAUSEIR,
+		JTAG_STATE_EXIT2IR,
+		JTAG_STATE_UPDATEIR
+	};
+
+tck: clock counter
+
+Example:
+::
+
+	struct jtag_tap_state tap_state;
+
+	tap_state.endstate = JTAG_STATE_IDLE;
+	tap_state.reset = 0;
+	tap_state.tck = data_p->tck;
+	usleep(25 * 1000);
+	ioctl(jtag_fd, JTAG_SIOCSTATE, &tap_state);
+
+JTAG_GIOCSTATUS
+~~~~~~~~~~~~~~~
+Get JTAG TAPC current machine state
+::
+
+	unsigned int jtag_fd;
+	jtag_tapstate tapstate;
+	ioctl(jtag_fd, JTAG_GIOCSTATUS, &tapstate);
+
+JTAG_IOCXFER
+~~~~~~~~~~~~
+Send SDR/SIR transaction
+::
+
+	struct jtag_xfer {
+		__u8	type;
+		__u8	direction;
+		__u8	from;
+		__u8	endstate;
+		__u32	padding;
+		__u32	length;
+		__u64	tdio;
+	};
+
+type: transfer type - JTAG_SIR_XFER/JTAG_SDR_XFER
+
+direction: xfer direction - JTAG_READ_XFER/JTAG_WRITE_XFER/JTAG_READ_WRITE_XFER
+
+from: jtag_tapstate enum representing the initial tap state of the chain before xfer.
+
+endstate: end state after transaction finish any of jtag_tapstate enum
+
+padding: padding configuration. See the following table with bitfield descriptions.
+
+===============  =========  =======  =====================================================
+Bit Field        Bit begin  Bit end  Description
+===============  =========  =======  =====================================================
+rsvd             25         31       Reserved, not used
+pad data         24         24       Value used for pre and post padding. Either 1 or 0.
+post pad count   12         23       Number of padding bits to be executed after transfer.
+pre pad count    0          11       Number of padding bit to be executed before transfer.
+===============  =========  =======  =====================================================
+
+length: xfer data length in bits
+
+tdio : xfer data array
+
+Example:
+::
+
+	struct jtag_xfer xfer;
+	static char buf[64];
+	static unsigned int buf_len = 0;
+	[...]
+	xfer.type = JTAG_SDR_XFER;
+	xfer.tdio = (__u64)buf;
+	xfer.length = buf_len;
+	xfer.from = JTAG_STATE_TLRESET;
+	xfer.endstate = JTAG_STATE_IDLE;
+
+	if (is_read)
+		xfer.direction = JTAG_READ_XFER;
+	else if (is_write)
+		xfer.direction = JTAG_WRITE_XFER;
+	else
+		xfer.direction = JTAG_READ_WRITE_XFER;
+
+	ioctl(jtag_fd, JTAG_IOCXFER, &xfer);
+
+JTAG_SIOCMODE
+~~~~~~~~~~~~~
+If hardware driver can support different running modes you can change it.
+
+Example:
+::
+
+	struct jtag_mode mode;
+	mode.feature = JTAG_XFER_MODE;
+	mode.mode = JTAG_XFER_HW_MODE;
+	ioctl(jtag_fd, JTAG_SIOCMODE, &mode);
+
+JTAG_IOCBITBANG
+~~~~~~~~~~~~~~~
+JTAG Bitbang low level operation.
+
+Example:
+::
+
+	struct tck_bitbang bitbang
+	bitbang.tms = 1;
+	bitbang.tdi = 0;
+	ioctl(jtag_fd, JTAG_IOCBITBANG, &bitbang);
+	tdo = bitbang.tdo;
+
+JTAG_SIOCTRST
+~~~~~~~~~~~~~~~
+Set TRST pin for JTAG.
+
+Example:
+::
+
+	unsigned int active = 1;
+	ioctl(jtag_fd, JTAG_SIOCTRST, active);
+
+THANKS TO
+---------
+Contributors to Linux-JTAG discussions include (in alphabetical order,
+by last name):
+
+- Omar Castro
+- Ernesto Corona
+- Steven Filary
+- Vadim Pasternak
+- Jiri Pirko
+- Oleksandr Shamray
+- Billy Tsai
-- 
2.25.1
