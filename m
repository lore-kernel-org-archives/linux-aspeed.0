From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 29 Mar 2022 13:00:55 +1030
Subject: [PATCH v3 2/2] ARM: dts: aspeed: ast2600-evb: Support KVM
In-Reply-To: <SG2PR06MB2315F24A708B71CA594F8DAEE61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
References: <SG2PR06MB2315F24A708B71CA594F8DAEE61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
Message-ID: <d1aacc80-779e-419b-bc8c-c43aeb704586@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Howard,

On Tue, 29 Mar 2022, at 12:08, Howard Chiu wrote:
> Enable video engine and reserve memory for it.
> Enable USB for HID support

These should be two separate patches. They're unrelated in the sense 
that the video engine is separate from USB (even if your overall goal 
is to enable KVM).

>
> Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 39 +++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts 
> b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> index b7eb552640cb..d535a711bf5a 100644
> --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> @@ -23,6 +23,19 @@ memory at 80000000 {
>  		reg = <0x80000000 0x80000000>;
>  	};
> 
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		video_engine_memory: video {
> +			size = <0x04000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +	};
> +
>  	vcc_sdhci0: regulator-vcc-sdhci0 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "SDHCI0 Vcc";
> @@ -250,14 +263,6 @@ &fsim0 {
>  	status = "okay";
>  };
> 
> -&ehci1 {
> -	status = "okay";
> -};
> -
> -&uhci {
> -	status = "okay";
> -};
> -
>  &sdc {
>  	status = "okay";
>  };
> @@ -300,3 +305,21 @@ &sdhci1 {
>  	vqmmc-supply = <&vccq_sdhci1>;
>  	clk-phase-sd-hs = <7>, <200>;
>  };
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&uhci {
> +	status = "okay";
> +};

This movement of the ehci1 and uhci nodes seems unnecessary?

Andrew
