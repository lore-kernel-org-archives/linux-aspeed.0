From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 3 Nov 2021 09:20:36 -0500
Subject: [PATCH v1] ARM: dts: aspeed: Adding Facebook Bletchley BMC
In-Reply-To: <20211103071417.388388-1-howard.chiu@quantatw.com>
References: <20211103071417.388388-1-howard.chiu@quantatw.com>
Message-ID: <YYKatBCCroiYxLew@heinlein>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Howard,

Thanks for supplying this.  I have a few comments below.

On Wed, Nov 03, 2021 at 03:14:18PM +0800, Howard Chiu wrote:
> Initial introduction of Facebook Bletchley equipped with
> Aspeed 2600 BMC SoC.
> 
> Signed-off-by: Howard Chiu <howard.chiu@quantatw.com>
> ---
>  arch/arm/boot/dts/Makefile                    |    1 +
>  .../dts/aspeed-bmc-facebook-bletchley.dts     | 1160 +++++++++++++++++
>  2 files changed, 1161 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7e0934180724..2cc2d804e75a 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1474,6 +1474,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-facebook-wedge400.dtb \
>  	aspeed-bmc-facebook-yamp.dtb \
>  	aspeed-bmc-facebook-yosemitev2.dtb \
> +	aspeed-bmc-facebook-bletchley.dtb \
>  	aspeed-bmc-ibm-everest.dtb \
>  	aspeed-bmc-ibm-rainier.dtb \
>  	aspeed-bmc-ibm-rainier-1s4u.dtb \

I believe the preference is to keep these sorted.

> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> new file mode 100644
> index 000000000000..af30be95fb23
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts

> +
> +	chosen {
> +		bootargs = "console=ttyS4,115200n8";
> +	};

Do we want this to be 115200 or 57600?

> +		fan1_ember {
> +			retain-state-shutdown;
> +			default-state = "off";
> +			gpios = <&fan_ioexp 13 GPIO_ACTIVE_HIGH>;

I see a number of references to 'ember'/'EMBER'.  I think the intention is
'amber'.

    amber: a honey-yellow color typical of amber 
           or a yellow light used as a cautionary signal

    ember: a small piece of burning or glowing coal or wood in a dying fire.


> +&fmc {
> +	status = "okay";
> +	flash at 0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64.dtsi"

Is this board using 64MB or 128MB modules?  Many of the newer systems have been
starting to use 128MB.  I just want to confirm this is correct.

> +	sled0_ioexp: pca9539 at 76 {
> +		compatible = "nxp,pca9539";
> +		reg = <0x76>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		gpio-line-names =
> +		"","SLED0_BMC_CCG5_INT","SLED0_INA230_ALERT","SLED0_P12V_STBY_ALERT",
> +		"SLED0_SSD_ALERT","SLED0_MS_DETECT","SLED0_MD_REF_PWM","",
> +		"SLED0_MD_STBY_RESET","SLED0_MD_IOEXP_EN_FAULT","SLED0_MD_DIR","SLED0_MD_DECAY",
> +		"SLED0_MD_MODE1","SLED0_MD_MODE2","SLED0_MD_MODE3","SLED0_AC_PWR_EN";

In general, in OpenBMC, we have a preference for the GPIOs to not be schematic
names but to be named based on their [software-oriented] function.  Please take
a look at:

    https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md

Any function you see that isn't documented there we should try to get documented
before fixing the GPIO name to match it.

> +		gpio-line-names =
> +		"SLED0_EMBER_LED","SLED0_BLUE_LED","SLED0_RST_IOEXP","",

The LEDs are ones I know are already documented in the above linked file.

> +&i2c13 {
> +	multi-master;
> +	aspeed,hw-timeout-ms = <1000>;
> +	status = "okay";
> +};

Was this intentional to have defined a multi-master bus with nothing on it?

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211103/bb996475/attachment.sig>
