From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Tue, 11 Dec 2018 10:39:40 -0800
Subject: [PATCH 2/2] ARM: dts: aspeed: Add KCS support for LPC BMC
In-Reply-To: <20181210200753.3018124-3-vijaykhemka@fb.com>
References: <20181210200753.3018124-1-vijaykhemka@fb.com>
 <20181210200753.3018124-3-vijaykhemka@fb.com>
Message-ID: <584ddf6f-2e0c-5c1c-df06-bdd37ecd2489@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vijay,

On 12/10/2018 12:07 PM, Vijay Khemka wrote:
> Added kcs device support for lpc BMC.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>   arch/arm/boot/dts/aspeed-g5.dtsi | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index d107459fc0f8..1bd48655bacb 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -330,8 +330,35 @@
>   				ranges = <0x0 0x1e789000 0x1000>;
>   
>   				lpc_bmc: lpc-bmc at 0 {
> -					compatible = "aspeed,ast2500-lpc-bmc";
> +					compatible = "aspeed,ast2500-lpc-bmc, "simple-mfd", "syscon"";
>   					reg = <0x0 0x80>;
> +					reg-io-width = <4>;
> +
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					ranges = <0x0 0x0 0x80>;
> +
> +					kcs1: kcs1 at 0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0x80>;

This reg property isn't needed at here because kcs_bmc_aspeed module
reads regmap from the parent node. Please check below code in the
driver code.

priv->map = syscon_node_to_regmap(dev->parent->of_node);

> +						interrupts = <8>;
> +						kcs_chan = <1>;
> +						status = "disabled";
> +					};
> +					kcs2: kcs2 at 0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0x80>;

ditto.

> +						interrupts = <8>;
> +						kcs_chan = <2>;
> +						status = "disabled";
> +					};
> +					kcs3: kcs3 at 0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0x80>;

ditto.

> +						interrupts = <8>;
> +						kcs_chan = <3>;
> +						status = "disabled";
> +					};
>   				};
>   
>   				lpc_host: lpc-host at 80 {
> 

You might need to add kcs4 as a sub-node under lpc_host like below:

kcs4: kcs4 at 0 {
	compatible = "aspeed,ast2500-kcs-bmc";
	interrupts = <8>;
	kcs_chan = <4>;
	status = "disabled";
};

This would be uses as an SMM channel.

-Jae
