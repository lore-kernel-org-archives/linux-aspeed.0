From: Jonathan Corbet <corbet@lwn.net>
Date: Wed, 31 Jan 2024 08:58:50 -0700
Subject: [PATCH 30 4/7] Add ABI documentation
In-Reply-To: <LV8PR11MB8463E4402495BACB9E3ACE588B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
References: <LV8PR11MB8463E4402495BACB9E3ACE588B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Message-ID: <87mssl7av9.fsf@meer.lwn.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"Corona, Ernesto" <ernesto.corona@intel.com> writes:

> Added document that describe the ABI for JTAG class driver

A few comments

> diff --git a/Documentation/jtag/index.rst b/Documentation/jtag/index.rst
> new file mode 100644
> index 000000000000..8a2761d1c17e
> --- /dev/null
> +++ b/Documentation/jtag/index.rst

Please, let's not create another top-level directory for this; this
looks like information that belongs in the userspace-api book.

> @@ -0,0 +1,18 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============================
> +Joint Test Action Group (JTAG)
> +==============================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   jtag-summary
> +   jtagdev
> +
> +.. only::  subproject and html
> +
> +   Indices
> +   =======
> +
> +   * :ref:`genindex`
> diff --git a/Documentation/jtag/jtag-summary.rst b/Documentation/jtag/jtag-summary.rst
> new file mode 100644
> index 000000000000..07cfa7a761d7
> --- /dev/null
> +++ b/Documentation/jtag/jtag-summary.rst
> @@ -0,0 +1,49 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================================
> +Linux kernel JTAG support
> +====================================
> +
> +Introduction to JTAG
> +====================
> +
> +JTAG is an industry standard for verifying hardware. JTAG provides access to
> +many logic signals of a complex integrated circuit, including the device pins.
> +
> +A JTAG interface is a special interface added to a chip.
> +Depending on the version of JTAG, two, four, or five pins are added.
> +
> +The connector pins are:
> + * TDI (Test Data In)
> + * TDO (Test Data Out)
> + * TCK (Test Clock)
> + * TMS (Test Mode Select)
> + * TRST (Test Reset) optional
> +
> +JTAG interface is designed to have two parts - basic core driver and
> +hardware specific driver. The basic driver introduces a general interface
> +which is not dependent of specific hardware. It provides communication
> +between user space and hardware specific driver.
> +Each JTAG device is represented as a char device from (jtag0, jtag1, ...).
> +Access to a JTAG device is performed through IOCTL calls.
> +
> +Call flow example:
> +::

You can express this more readably as just

  Call flow example::



> +
> +	User: open  -> /dev/jatgX -> JTAG core driver -> JTAG hardware specific driver
> +	User: ioctl -> /dev/jtagX -> JTAG core driver -> JTAG hardware specific driver
> +	User: close -> /dev/jatgX -> JTAG core driver -> JTAG hardware specific driver
> +
> +
> +THANKS TO
> +---------
> +Contributors to Linux-JTAG discussions include (in alphabetical order,
> +by last name):
> +
> +- Omar Castro
> +- Ernesto Corona
> +- Steven Filary
> +- Vadim Pasternak
> +- Jiri Pirko
> +- Oleksandr Shamray
> +- Billy Tsai
> \ No newline at end of file

Files should end in a newline

[...]

> +===============  =========  =======  =====================================================
> +Bit Field        Bit begin  Bit end  Description
> +===============  =========  =======  =====================================================
> +rsvd             25         31       Reserved, not used
> +pad data         24         24       Value used for pre and post padding. Either 1 or 0.
> +post pad count   12         23       Number of padding bits to be executed after transfer.
> +pre pad count    0          11       Number of padding bit to be executed before transfer.
> +===============  =========  =======  =====================================================

You should be able to wrap the final column of the table, avoiding these
long lines.

Thanks,

jon
