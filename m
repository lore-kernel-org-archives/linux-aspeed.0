From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 27 Feb 2020 15:10:55 +1100
Subject: [PATCH v4 6/7] ARM: dts: aspeed-g4: add vhub port and endpoint
 properties
In-Reply-To: <20200226230346.672-7-rentao.bupt@gmail.com>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
 <20200226230346.672-7-rentao.bupt@gmail.com>
Message-ID: <83d7b817234f99c92272f7950129c56a58f4de54.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2020-02-26 at 15:03 -0800, rentao.bupt at gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Add "aspeed,vhub-downstream-ports" and "aspeed,vhub-generic-
> endpoints"
> properties to describe supported number of vhub ports and endpoints.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


> ---
>  No change in v2/v3/v4.
>    - It's given v4 to align with the version of the patch series.
> 
>  arch/arm/boot/dts/aspeed-g4.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi
> b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 807a0fc20670..8e04303e8514 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -164,6 +164,8 @@
>  			reg = <0x1e6a0000 0x300>;
>  			interrupts = <5>;
>  			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> +			aspeed,vhub-downstream-ports = <5>;
> +			aspeed,vhub-generic-endpoints = <15>;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pinctrl_usb2d_default>;
>  			status = "disabled";

