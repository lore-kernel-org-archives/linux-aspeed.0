From: Patrick Venture <venture@google.com>
Date: Mon, 22 Apr 2019 12:24:28 -0700
Subject: [PATCH v2] soc: add aspeed folder and misc drivers
In-Reply-To: <20190422175419.189895-1-venture@google.com>
References: <20190422175419.189895-1-venture@google.com>
Message-ID: <CAO=notxpGXLBPwsHAJdt8CwQMdNcCE=EeFymgxez_goaqnGoHQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 22, 2019 at 10:54 AM Patrick Venture <venture@google.com> wrote:
>
> Create a SoC folder for the ASPEED parts and place the misc drivers
> currently present into this folder.  These drivers are not generic part
> drivers, but rather only apply to the ASPEED SoCs.
>
> Signed-off-by: Patrick Venture <venture@google.com>
> ---
> v2:
>  Added configuration option for ASPEED to soc/Makefile
> ---
>  drivers/misc/Kconfig                          | 16 ----------------
>  drivers/misc/Makefile                         |  2 --
>  drivers/soc/Kconfig                           |  1 +
>  drivers/soc/Makefile                          |  1 +
>  drivers/soc/aspeed/Kconfig                    | 19 +++++++++++++++++++
>  drivers/soc/aspeed/Makefile                   |  2 ++
>  .../{misc => soc/aspeed}/aspeed-lpc-ctrl.c    |  0
>  .../{misc => soc/aspeed}/aspeed-lpc-snoop.c   |  0
>  8 files changed, 23 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/soc/aspeed/Kconfig
>  create mode 100644 drivers/soc/aspeed/Makefile
>  rename drivers/{misc => soc/aspeed}/aspeed-lpc-ctrl.c (100%)
>  rename drivers/{misc => soc/aspeed}/aspeed-lpc-snoop.c (100%)
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 42ab8ec92a04..b80cb6af0cb4 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -496,22 +496,6 @@ config VEXPRESS_SYSCFG
>           bus. System Configuration interface is one of the possible means
>           of generating transactions on this bus.
>
> -config ASPEED_LPC_CTRL
> -       depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> -       tristate "Aspeed ast2400/2500 HOST LPC to BMC bridge control"
> -       ---help---
> -         Control Aspeed ast2400/2500 HOST LPC to BMC mappings through
> -         ioctl()s, the driver also provides a read/write interface to a BMC ram
> -         region where the host LPC read/write region can be buffered.
> -
> -config ASPEED_LPC_SNOOP
> -       tristate "Aspeed ast2500 HOST LPC snoop support"
> -       depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> -       help
> -         Provides a driver to control the LPC snoop interface which
> -         allows the BMC to listen on and save the data written by
> -         the host to an arbitrary LPC I/O port.
> -
>  config PCI_ENDPOINT_TEST
>         depends on PCI
>         select CRC32
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index d5b7d3404dc7..b9affcdaa3d6 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -54,8 +54,6 @@ obj-$(CONFIG_GENWQE)          += genwqe/
>  obj-$(CONFIG_ECHO)             += echo/
>  obj-$(CONFIG_VEXPRESS_SYSCFG)  += vexpress-syscfg.o
>  obj-$(CONFIG_CXL_BASE)         += cxl/
> -obj-$(CONFIG_ASPEED_LPC_CTRL)  += aspeed-lpc-ctrl.o
> -obj-$(CONFIG_ASPEED_LPC_SNOOP) += aspeed-lpc-snoop.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)        += pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)             += ocxl/
>  obj-y                          += cardreader/
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index c07b4a85253f..b750a88547c7 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -2,6 +2,7 @@ menu "SOC (System On Chip) specific Drivers"
>
>  source "drivers/soc/actions/Kconfig"
>  source "drivers/soc/amlogic/Kconfig"
> +source "drivers/soc/aspeed/Kconfig"
>  source "drivers/soc/atmel/Kconfig"
>  source "drivers/soc/bcm/Kconfig"
>  source "drivers/soc/fsl/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 90b686e586c6..814128fe479f 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -4,6 +4,7 @@
>  #
>
>  obj-$(CONFIG_ARCH_ACTIONS)     += actions/
> +obj-$(CONFIG_ARCH_ASPEED)      += aspeed/
>  obj-$(CONFIG_ARCH_AT91)                += atmel/
>  obj-y                          += bcm/
>  obj-$(CONFIG_ARCH_DOVE)                += dove/
> diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
> new file mode 100644
> index 000000000000..457282cd1da5
> --- /dev/null
> +++ b/drivers/soc/aspeed/Kconfig
> @@ -0,0 +1,19 @@
> +menu "Aspeed SoC drivers"
> +
> +config ASPEED_LPC_CTRL
> +       depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> +       tristate "Aspeed ast2400/2500 HOST LPC to BMC bridge control"
> +       ---help---
> +         Control Aspeed ast2400/2500 HOST LPC to BMC mappings through
> +         ioctl()s, the driver also provides a read/write interface to a BMC ram
> +         region where the host LPC read/write region can be buffered.
> +
> +config ASPEED_LPC_SNOOP
> +       tristate "Aspeed ast2500 HOST LPC snoop support"
> +       depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> +       help
> +         Provides a driver to control the LPC snoop interface which
> +         allows the BMC to listen on and save the data written by
> +         the host to an arbitrary LPC I/O port.
> +
> +
> diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
> new file mode 100644
> index 000000000000..cfaa9adc67b5
> --- /dev/null
> +++ b/drivers/soc/aspeed/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_ASPEED_LPC_CTRL)  += aspeed-lpc-ctrl.o
> +obj-$(CONFIG_ASPEED_LPC_SNOOP) += aspeed-lpc-snoop.o
> diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> similarity index 100%
> rename from drivers/misc/aspeed-lpc-ctrl.c
> rename to drivers/soc/aspeed/aspeed-lpc-ctrl.c
> diff --git a/drivers/misc/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> similarity index 100%
> rename from drivers/misc/aspeed-lpc-snoop.c
> rename to drivers/soc/aspeed/aspeed-lpc-snoop.c
> --
> 2.21.0.593.g511ec345e18-goog
>

Fixed CC on this reply (Gmail button didn't behave as expected) and
replied to the v2 patchset instead of accidentally the first.

Given this patchset, I have several patches that move the drivers into
the folder, and thought about writing it up as a series.  I wanted to
see how this patchset would do before I staged the rest -- my question
is, should this patchset create the folder with the empty Kconfig and
Makefile, and then have follow-on patches that provide content to
split out the process into multiple logical steps?
