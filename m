From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 01 Feb 2024 16:15:39 +1030
Subject: [PATCH v5 11/21] ARM: dts: aspeed: yosemite4: Add eeprom for
 yosemite4 use
In-Reply-To: <20240131084134.328307-12-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-12-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <1823c7e3fd460b64c5bab3c1c6623a0a63e073d6.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> Add eeprom for yosemite4 use
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index e8d7eb7ff568..f00df378a371 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -932,7 +932,7 @@ temperature-sensor at 4b {
>  	};
>  
>  	eeprom at 54 {
> -		compatible = "atmel,24c256";
> +		compatible = "atmel,24c128";

This is changing an existing eeprom, not adding a new one - contrary to
the commit message. It probably should be in a separate patch?
Presumably this is also motivated by the change in the schematics? Some
explanation would be helpful.

I'm half wondering whether it would have been easier to add a separate
DTS for the new version of the schematic rather than make all these
piecemeal changes.

Andrew

