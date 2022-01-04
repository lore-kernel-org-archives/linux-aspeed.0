From: Patrick Williams <patrick@stwcx.xyz>
Date: Tue, 4 Jan 2022 17:18:22 -0600
Subject: [PATCH] ARM: dts: aspeed: update dts of Bletchley platform
In-Reply-To: <20220104093008.624-1-potin.lai@quantatw.com>
References: <20220104093008.624-1-potin.lai@quantatw.com>
Message-ID: <YdTVvuXiPPRaMw99@heinlein>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Potin,

A few minor comments.  You might want to leave more information in the device
tree for a few of these since they seem like non-obvious settings.

On Tue, Jan 04, 2022 at 05:30:08PM +0800, Potin Lai wrote:
> updates:
> * seperate leds into multiple groups
> * switch sled numbering to 1-based
> * disable inchip rtc
> * add flash1 in fmc
> * switch spi2 pnor using spi-gpio
> * update gpio-line-names
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  .../dts/aspeed-bmc-facebook-bletchley.dts     | 277 +++++++++++-------
>  1 file changed, 163 insertions(+), 114 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> index f973ea883b97..d617cfebcb18 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
...
>  
>  &rtc {
> -	status = "okay";
> +	status = "disabled";
>  };

Since it is more atypical to disable the in-chip RTC would you mind leaving a
comment in the DTS as to why?  I see we have the nxp,pcf85263 later on.

>  &spi2 {
>  	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_spi2_default>;
> +
> +	compatible = "spi-gpio";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
> +	gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
> +	gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
> +	num-chipselects = <1>;
> +	cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
>  
>  	flash at 0 {
>  		status = "okay";
>  		m25p,fast-read;
>  		label = "pnor";
> -		spi-max-frequency = <100000000>;
> +		spi-max-frequency = <12000000>;
>  	};
>  };

Why is this one being changed to spi-gpio?  That is significantly worse
performance.  Is there another (non-NOR) SPI device on this bus that is missing
from the device tree?

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220104/0126caf3/attachment.sig>
