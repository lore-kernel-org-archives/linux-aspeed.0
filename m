From: Paul Fertser <fercerpav@gmail.com>
Date: Tue, 19 Jan 2021 15:01:26 +0300
Subject: [PATCH v29 4/6] Documentation: jtag: Add ABI documentation
In-Reply-To: <20200413222920.4722-5-ernesto.corona@intel.com>
References: <20200413222920.4722-1-ernesto.corona@intel.com>
 <20200413222920.4722-5-ernesto.corona@intel.com>
Message-ID: <20210119120125.GD2971@home.paul.comp>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This review of the proposed API was written after independently
developing and testing on hardware (only SVF playback to configure a
CPLD) support for OpenOCD[0]. I also include points that come to mind
from my prior experience using wide range of JTAG adapters with
different targets.

On Mon, Apr 13, 2020 at 03:29:18PM -0700, Ernesto Corona wrote:
> --- /dev/null
> +++ b/Documentation/jtag/jtag-summary.rst
> +A JTAG interface is a special interface added to a chip.
> +Depending on the version of JTAG, two, four, or five pins are added.
> +
> +The connector pins are:
> + * TDI (Test Data In)
> + * TDO (Test Data Out)
> + * TCK (Test Clock)
> + * TMS (Test Mode Select)
> + * TRST (Test Reset) optional

Generic JTAG API should also include SRST (system reset), it's
essential when JTAG is used as a transport for different On-Chip-Debug
protocols.

> +Call flow example:
> +::
> +
> +	User: open  -> /dev/jatgX -> JTAG core driver -> JTAG hardware specific driver
> +	User: ioctl -> /dev/jtagX -> JTAG core driver -> JTAG hardware specific driver
> +	User: close -> /dev/jatgX -> JTAG core driver -> JTAG hardware specific driver

s/jatg/jtag/

Not sure about the semantics here, as open needs a filesystem path
while the other two operations take a file descriptor.

> --- /dev/null
> +++ b/Documentation/jtag/jtagdev.rst
> @@ -0,0 +1,194 @@
> +==================
> +JTAG userspace API
> +==================
> +JTAG master devices can be accessed through a character misc-device.
> +
> +Each JTAG master interface can be accessed by using /dev/jtagN.
> +
> +JTAG system calls set:
> + * SIR (Scan Instruction Register, IEEE 1149.1 Instruction Register scan);
> + * SDR (Scan Data Register, IEEE 1149.1 Data Register scan);

These two are handled with JTAG_IOCXFER ioctl.

> + * RUNTEST (Forces the IEEE 1149.1 bus to a run state for a specified number of clocks.

This should be handled by JTAG_SIOCSTATE ioctl, apparently.

ioctl itself is a system call here, the items mentioned are just
different arguments to it, AFAICT.

> +JTAG_SIOCFREQ
> +~~~~~~~~~~~~~
> +Set JTAG clock speed:
> +::
> +
> +	unsigned int jtag_fd;
> +	ioctl(jtag_fd, JTAG_SIOCFREQ, &frq);

The example defining jtag_fd looks confusing. Not only it is usually a
bad idea to use unsigned int for a file descriptor (as open() returns
a signed one that should be checked for errors), but in this example
it's not assigned anything. And "frq" is not specified at all, so it's
unclear what type it really should be, and what measurement units are
supposed to be used. And I'm still not sure it needs to be a
pointer. It's also unclear how a userspace should tell if the
frequency was successfully set or if it was probably out of range for
the specific adapter (the ioctl should return a documented error in
this case).

> +JTAG_SIOCSTATE
> +~~~~~~~~~~~~~~
> +Force JTAG state machine to go into a TAPC state
> +::
> +
> +	struct jtag_end_tap_state {
> +		__u8	reset;
> +		__u8	endstate;
> +		__u8	tck;

Limiting tck to 255 maximum is unreasonable.

> +	};
> +
> +reset: one of below options
> +::
> +
> +	JTAG_NO_RESET - go through selected endstate from current state
> +	JTAG_FORCE_RESET - go through TEST_LOGIC/RESET state before selected endstate
> +
> +endstate: any state listed in jtag_endstate enum
> +::
> +
> +	enum jtag_endstate {
> +		JTAG_STATE_TLRESET,
> +		JTAG_STATE_IDLE,
> +		JTAG_STATE_SELECTDR,
> +		JTAG_STATE_CAPTUREDR,
> +		JTAG_STATE_SHIFTDR,
> +		JTAG_STATE_EXIT1DR,
> +		JTAG_STATE_PAUSEDR,
> +		JTAG_STATE_EXIT2DR,
> +		JTAG_STATE_UPDATEDR,
> +		JTAG_STATE_SELECTIR,
> +		JTAG_STATE_CAPTUREIR,
> +		JTAG_STATE_SHIFTIR,
> +		JTAG_STATE_EXIT1IR,
> +		JTAG_STATE_PAUSEIR,
> +		JTAG_STATE_EXIT2IR,
> +		JTAG_STATE_UPDATEIR
> +	};

Even though there's no standard mapping between JTAG states and
numbers, I would suggest to use the one documented by ARM[1] for their
TAPSM register as was found in ARM7, ARM9 and other cores. Chances are
that a userspace utility might have easier time converting between
different encodings, at least it's the case for OpenOCD.

> +tck: clock counter

This is not nearly enough documentation for the parameter, IMHO. It
doesn't work anyway in the current version so I had to add some
bitbanging for CPLD configuration to work...

> +Example:
> +::
> +
> +	struct jtag_end_tap_state end_state;
> +
> +	end_state.endstate = JTAG_STATE_IDLE;
> +	end_state.reset = 0;
> +	end_state.tck = data_p->tck;
> +	usleep(25 * 1000);
> +	ioctl(jtag_fd, JTAG_SIOCSTATE, &end_state);

usleep doesn't seem to be doing anything useful at all here.

> +JTAG_GIOCSTATUS
> +~~~~~~~~~~~~~~~
> +Get JTAG TAPC current machine state
> +::
> +
> +	unsigned int jtag_fd;
> +	jtag_endstate endstate;
> +	ioctl(jtag_fd, JTAG_GIOCSTATUS, &endstate);

This should probably also include information about TRST and SRST states.

> +JTAG_IOCXFER
> +~~~~~~~~~~~~
> +Send SDR/SIR transaction
> +::
> +
> +	struct jtag_xfer {
> +		__u8	type;
> +		__u8	direction;
> +		__u8	endstate;
> +		__u8	padding;

padding is both undocumented and unused.

> +		__u32	length;
> +		__u64	tdio;
> +	};
> +
> +type: transfer type - JTAG_SIR_XFER/JTAG_SDR_XFER
> +
> +direction: xfer direction - JTAG_READ_XFER/JTAG_WRITE_XFER/JTAG_READ_WRITE_XFER
> +
> +length: xfer data length in bits

I'm not sure if calling it just "length" is clear enough. Probably a
better name would be "bitcount"?

> +tdio : xfer data array

It's not exactly obvious that this is a pointer to user buffer
containing data to be shifted out. Bit and byte order are not
specified.

I also do not like the idea to reuse input buffer for output. It might
be const in the user app, it might be used after the JTAG operation
for logging or verification purposes etc. Are there other popular APIs
that do not split input and output into their own buffers?

> +JTAG_SIOCMODE
> +~~~~~~~~~~~~~
> +If hardware driver can support different running modes you can change it.
> +
> +Example:
> +::
> +
> +	struct jtag_mode mode;
> +	mode.feature = JTAG_XFER_MODE;
> +	mode.mode = JTAG_XFER_HW_MODE;
> +	ioctl(jtag_fd, JTAG_SIOCMODE, &mode);

This is absolutely not generic enough, and struct jtag_mode is just
odd. And not documented here, the example is not extensive.

Please consider providing instead a generic function to pass arbitrary
data to the adapter driver _and_ to get some information back from it.

> +JTAG_IOCBITBANG
> +~~~~~~~~~~~~~~~
> +JTAG Bitbang low level operation.
> +
> +Example:
> +::
> +
> +	struct tck_bitbang bitbang

missing semicolon, missing declaration/documentation of the struct
fields.

> +	bitbang.tms = 1;
> +	bitbang.tdi = 0;
> +	ioctl(jtag_fd, JTAG_IOCBITBANG, &bitbang);
> +	tdo = bitbang.tdo;

This is ok, used it for implementing RUNTEST/STABLECLOCKS.


Now follows the list of what I consider to be missing in this API if
it's supposed to be generic enough to cover all regular JTAG devices:

1. Multiple devices might be used at the same time, including
hotplugging. This requires methods to somehow enumerate them, read
serial numbers, probably allow matching on VID:PID for USB adapters;
some people also want to be able to match based on "location"
(e.g. USB bus topology, full path leading to the device).

2. Bitbang-style control is often needed for SRST and TRST lines.

3. Many adapters have LED(s) that host software is supposed to
control.

4. It'd be useful to have a way to emit a TMS sequence, e.g. modern
ARM devices support both SWD and JTAG transports and a special
sequence is needed to switch between them.

[0] http://openocd.zylin.com/#/c/5975/
[1] https://documentation-service.arm.com/static/5e8e27fcfd977155116a637f

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav at gmail.com
