From: Joel Stanley <joel@jms.id.au>
Date: Tue, 1 Sep 2020 05:58:12 +0000
Subject: [PATCH 2/5] input: misc: Add IBM Operation Panel driver
In-Reply-To: <20200820161152.22751-3-eajames@linux.ibm.com>
References: <20200820161152.22751-1-eajames@linux.ibm.com>
 <20200820161152.22751-3-eajames@linux.ibm.com>
Message-ID: <CACPK8XdMqZv5f0X1-G2WPrYSpYMpMjJC4WxNsiKSxqtWb0M1jw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2020 at 16:12, Eddie James <eajames@linux.ibm.com> wrote:
>
> Add a driver to get the button events from the panel and provide
> them to userspace with the input subsystem. The panel is
> connected with I2C and controls the bus, so the driver registers
> as an I2C slave device.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  MAINTAINERS                    |   1 +
>  drivers/input/misc/Kconfig     |  10 ++
>  drivers/input/misc/Makefile    |   1 +
>  drivers/input/misc/ibm-panel.c | 186 +++++++++++++++++++++++++++++++++
>  4 files changed, 198 insertions(+)
>  create mode 100644 drivers/input/misc/ibm-panel.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a9fd08e9cd54..077cc79ad7fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8283,6 +8283,7 @@ M:        Eddie James <eajames@linux.ibm.com>
>  L:     linux-input at vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/input/ibm,op-panel.yaml
> +F:     drivers/input/misc/ibm-panel.c
>
>  IBM Power 842 compression accelerator
>  M:     Haren Myneni <haren@us.ibm.com>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 362e8a01980c..88fb465a18b8 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -708,6 +708,16 @@ config INPUT_ADXL34X_SPI
>           To compile this driver as a module, choose M here: the
>           module will be called adxl34x-spi.
>
> +config INPUT_IBM_PANEL
> +       tristate "IBM Operation Panel driver"
> +       depends on I2C_SLAVE || COMPILE_TEST
> +       help
> +         Supports the IBM Operation Panel as an input device. The panel is a
> +         controller attached to the system with some buttons and an LCD display
> +         that allows someone with physical access to the system to perform
> +         various administrative tasks. This driver only supports the part of
> +         the controller that sends commands to the system.

Is this always attached via a service processor/bmc? If so, mention it
here so people know there's no point enabling it on a host/distro
kernel.

I assume you're implementing the protocol correctly.  If you have a
link to a specification then include that in the file.

The code looks okay to me.

Reviewed-by: Joel Stanley <joel@jms.id.au>
