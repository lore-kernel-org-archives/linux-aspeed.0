From: Corey Minyard <minyard@acm.org>
Date: Tue, 15 Jun 2021 13:46:57 -0500
Subject: [PATCH v4 00/16] ipmi: Allow raw access to KCS devices
In-Reply-To: <20210608104757.582199-1-andrew@aj.id.au>
References: <20210608104757.582199-1-andrew@aj.id.au>
Message-ID: <20210615184657.GF2921206@minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 08, 2021 at 08:17:41PM +0930, Andrew Jeffery wrote:
> 
> Hello,
> 
> This is the 4th spin of the series refactoring the keyboard-controller-style
> device drivers in the IPMI subsystem.

Ok, no comments and everything looks good, I have this queued for the
next Linux release.

Thanks,

-corey

> 
> v3 can be found at:
> 
> https://lore.kernel.org/lkml/20210510054213.1610760-1-andrew at aj.id.au/
> 
> v4:
> 
> * Makes kcs_bmc_add_device() return an error if no client successfully
>   initialised with respect to the binding of the device driver
> * Retains the existing single-open semantics (v3 allowed multiple-open)
> * Fixes the OBE macro for the NPCM7xx KCS driver
> * Cleans up Yoda-style masks (mask constant on the LHS rather than RHS)
> * Cleans up includes in kcs_bmc_client.h
> * Adds some comments to the SerIO adapter to clarify object lifetimes
> 
> Previously:
> 
> Changes in v3:
> 
> * The series was rebased onto v5.13-rc1
> * v5.13-rc1 includes Chiawei's patches reworking the LPC devicetree bindings,
>   so they're no-longer required in the series.
> * After some discussion with Arnd[1] and investigating the serio subsystem,
>   I've replaced the "raw" KCS driver (patch 16/21 in v2) with a serio adaptor
>   (patch 11/16 in this series). The adaptor allows us to take advantage of the
>   existing chardevs provided by serio.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/37e75b07-a5c6-422f-84b3-54f2bea0b917 at www.fastmail.com/
> 
> Changes in v2 include:
> 
> * A rebase onto v5.12-rc2
> * Incorporation of off-list feedback on SerIRQ configuration from
>   Chiawei
> * Further validation on hardware for ASPEED KCS devices 2, 3 and 4
> * Lifting the existing single-open constraint of the IPMI chardev
> * Fixes addressing Rob's feedback on the conversion of the ASPEED KCS
>   binding to dt-schema
> * Fixes addressing Rob's feedback on the new aspeed,lpc-interrupts
>   property definition for the ASPEED KCS binding
> 
> Please test and review!
> 
> Andrew
> 
> Andrew Jeffery (16):
>   ipmi: kcs_bmc_aspeed: Use of match data to extract KCS properties
>   ipmi: kcs_bmc: Make status update atomic
>   ipmi: kcs_bmc: Rename {read,write}_{status,data}() functions
>   ipmi: kcs_bmc: Split out kcs_bmc_cdev_ipmi
>   ipmi: kcs_bmc: Turn the driver data-structures inside-out
>   ipmi: kcs_bmc: Split headers into device and client
>   ipmi: kcs_bmc: Strip private client data from struct kcs_bmc
>   ipmi: kcs_bmc: Decouple the IPMI chardev from the core
>   ipmi: kcs_bmc: Allow clients to control KCS IRQ state
>   ipmi: kcs_bmc: Enable IBF on open
>   ipmi: kcs_bmc: Add serio adaptor
>   dt-bindings: ipmi: Convert ASPEED KCS binding to schema
>   dt-bindings: ipmi: Add optional SerIRQ property to ASPEED KCS devices
>   ipmi: kcs_bmc_aspeed: Implement KCS SerIRQ configuration
>   ipmi: kcs_bmc_aspeed: Fix IBFIE typo from datasheet
>   ipmi: kcs_bmc_aspeed: Optionally apply status address
> 
>  .../bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml | 106 +++
>  .../bindings/ipmi/aspeed-kcs-bmc.txt          |  33 -
>  drivers/char/ipmi/Kconfig                     |  27 +
>  drivers/char/ipmi/Makefile                    |   2 +
>  drivers/char/ipmi/kcs_bmc.c                   | 523 ++++-----------
>  drivers/char/ipmi/kcs_bmc.h                   |  92 +--
>  drivers/char/ipmi/kcs_bmc_aspeed.c            | 633 +++++++++++++-----
>  drivers/char/ipmi/kcs_bmc_cdev_ipmi.c         | 568 ++++++++++++++++
>  drivers/char/ipmi/kcs_bmc_client.h            |  45 ++
>  drivers/char/ipmi/kcs_bmc_device.h            |  22 +
>  drivers/char/ipmi/kcs_bmc_npcm7xx.c           |  92 ++-
>  drivers/char/ipmi/kcs_bmc_serio.c             | 157 +++++
>  12 files changed, 1594 insertions(+), 706 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
>  create mode 100644 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
>  create mode 100644 drivers/char/ipmi/kcs_bmc_client.h
>  create mode 100644 drivers/char/ipmi/kcs_bmc_device.h
>  create mode 100644 drivers/char/ipmi/kcs_bmc_serio.c
> 
> -- 
> 2.30.2
> 
