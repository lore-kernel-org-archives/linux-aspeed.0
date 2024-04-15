From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 15 Apr 2024 10:24:07 +0930
Subject: [PATCH 3/3] ARM: dts: aspeed: Update Odyssey SBEFIFO compatible
 strings
In-Reply-To: <20240412144358.204129-4-eajames@linux.ibm.com>
References: <20240412144358.204129-1-eajames@linux.ibm.com>
	 <20240412144358.204129-4-eajames@linux.ibm.com>
Message-ID: <5c6f58cc13492988d307504d55cc5d31a512ab8c.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-04-12 at 09:43 -0500, Eddie James wrote:
> Set the new compatible string for Odyssey SBEFIFOs so that they
> don't collect async FFDC.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../dts/aspeed/aspeed-bmc-ibm-everest.dts     | 64 +++++++++----------
>  .../arm/boot/dts/aspeed/ibm-power10-quad.dtsi | 64 +++++++++----------
>  2 files changed, 64 insertions(+), 64 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> index 214b2e6a4c6d..3a2bfdf035cb 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> @@ -2545,7 +2545,7 @@ scom500: scom at 1000 {
>  						};
>  
>  						sbefifo500: sbefifo at 2400 {
> -							compatible = "ibm,p9-sbefifo";
> +							compatible = "ibm,ody-sbefifo";
>  							reg = <0x2400 0x400>;
>  							#address-cells = <1>;
>  							#size-cells = <0>;


Bit of a drive-by comment as I'm not really holding any stakes here,
but did the hardware actually change?

Would it be better to request the behaviour by a property rather than
changing the compatible?

Andrew
