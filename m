From: Patrick Williams <patrick@stwcx.xyz>
Date: Fri, 17 Jun 2022 11:42:35 -0500
Subject: [PATCH v2] ARM: dts: aspeed: Adding Facebook Yosemite V3.5 BMC
In-Reply-To: <20220616120707.GA22590@logan-ThinkPad-T14-Gen-1>
References: <20220616120707.GA22590@logan-ThinkPad-T14-Gen-1>
Message-ID: <Yqyu+y9ms/DmFCbJ@heinlein.stwcx.org.github.beta.tailscale.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jun 16, 2022 at 05:37:07PM +0530, Logananth Sundararaj wrote:
> The Yosemite V3.5 is a facebook multi-node server
> platform that host four OCP server. The BMC
> in the Yosemite V3.5 platform based on AST2600 SoC.
> 
> This patch adds linux device tree entry related to
> Yosemite V3.5 specific devices connected to BMC SoC.
> 
> Signed-off-by: Logananth Sundararaj <logananth_s@hcl.com>
> 
> ---
> --- v2 - Enabled i2c drivers.
> --- v1 - Initial draft.
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-facebook-fby35.dts    | 277 ++++++++++++++++++
>  2 files changed, 278 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts

A few comments below.

...
> +&uart5 {
> +	status = "okay";
> +	/* Workaround for AST2600 A0 */
> +	compatible = "snps,dw-apb-uart";
> +};

Is this comment accurate?  Are we using A0 hardware on this system?

> +&fmc {
> +	status = "okay";
> +	reg = <0x1e620000 0xc4>, <0x20000000 0x8000000>;
> +	flash at 0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "spi0.1";
> +		spi-max-frequency = <50000000>;
> +		spi-tx-bus-width = <2>;
> +		spi-rx-bus-width = <2>;
> +		#include "openbmc-flash-layout-64.dtsi"
> +	};
> +};

Aren't there two SPI flashes?  It seems like it based on:
https://github.com/facebook/openbmc-linux/blob/dev-5.10/arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts#L162

> +
> +&spi1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi1_default>;
> +
> +	flash at 0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "pnor";
> +		spi-rx-bus-width = <4>;
> +		spi-max-frequency = <100000000>;
> +	};
> +};

What is SPI1 used for?  I don't see it in the facebook/openbmc-linux
DTS.

> -- 
> 2.17.1
> 

Are we missing the pwm/tach support?  Or is that still not upstream from
Aspeed?

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220617/15c63c32/attachment-0001.sig>
