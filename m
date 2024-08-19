From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 19 Aug 2024 10:16:47 +0930
Subject: [PATCH v12 18/28] ARM: dts: aspeed: yosemite4: add mctp config
 for NIC
In-Reply-To: <20240816092417.3651434-19-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240816092417.3651434-19-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <aa4a9c154f54a2f1b5b55fa80bdd2e14aa3d1b3b.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-08-16 at 17:24 +0800, Delphine CC Chiu wrote:
> add mctp config for NIC
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index b46a0b9940e2..7b8a2384d99d 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1281,40 +1281,64 @@ imux24: i2c at 0 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0>;
> +			mctp-controller;
>  			temperature-sensor at 1f {
>  				compatible = "ti,tmp421";
>  				reg = <0x1f>;
>  			};
> +
> +			temperature-sensor at 3c {
> +				compatible = "smsc,emc1403";
> +				reg = <0x3c>;
> +			};

These nodes are unrelated to MCTP? Given we're assembling the puzzle
via the jigsaw pieces in the rest of the series, please split the
addition of these nodes out to a separate patch.

Further, the EMC1403 compatible is undocumented as of v6.11-rc1, and a
brief search didn't turn up anything on the lists. Please send a patch
adding it to the trivial-devices binding document.

Andrew
