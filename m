From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 19 Sep 2024 10:52:24 +0930
Subject: [PATCH v2 3/3] ARM: dts: aspeed: yosemite4: Add power module
 and ADC on Medusa Board
In-Reply-To: <20240918095438.1345886-4-Delphine_CC_Chiu@wiwynn.com>
References: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240918095438.1345886-4-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <11a0ae09bc722b1f21ae76df99bd8c1d885c85d1.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ricky,

On Wed, 2024-09-18 at 17:54 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> Add RTQ6056 as 2nd source ADC sensor on Medusa Board.

Can you unpack why this is related in the commit message? I assume it's
for something like battery monitoring? An explanation would help
though.

> Add power sensors on Medusa board:
> - Add XDP710 as 2nd source HSC to monitor P48V PSU power.
> - Add MP5023 as P12V efuse (Driver exists but un-documented).
> - Add PMBUS sensors as P12V Delta Module.

Generally if you're listing multiple things the change does in the
commit message you should have split the patch up accordingly.

There's some good advice here:

https://docs.kernel.org/process/5.Posting.html#patch-preparation

and here:

https://github.com/axboe/liburing/blob/master/CONTRIBUTING.md?plain=1#L21-L32

> 
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 45 ++++++++++++++++++-
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 98477792aa00..e486b9d78f61 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -284,15 +284,25 @@ &i2c10 {
>  &i2c11 {
>  	status = "okay";
>  	power-sensor at 10 {
> -		compatible = "adi, adm1272";
> +		compatible = "adi,adm1272";
>  		reg = <0x10>;
>  	};

This was outright busted. The hunk is a fix, as is the second instance
below. Please separate these out into their own patch and add a Fixes:
tag to it.

>  
> +	power-sensor at 11 {
> +		compatible = "infineon,xdp710";
> +		reg = <0x11>;
> +	};
> +
>  	power-sensor at 12 {
> -		compatible = "adi, adm1272";
> +		compatible = "adi,adm1272";

(i.e. this one also)

>  		reg = <0x12>;
>  	};
>  
> +	power-sensor at 13 {
> +		compatible = "infineon,xdp710";
> +		reg = <0x13>;
> +	};
> +
>  	gpio at 20 {
>  		compatible = "nxp,pca9555";
>  		reg = <0x20>;
> @@ -321,6 +331,17 @@ gpio at 23 {
>  		#gpio-cells = <2>;
>  	};
>  
> +	power-sensor at 40 {
> +		compatible = "mps,mp5023";
> +		reg = <0x40>;
> +	};
> +
> +	adc at 41 {
> +		compatible = "richtek,rtq6056";
> +		reg = <0x41>;
> +		#io-channel-cells = <1>;
> +	};
> +
>  	temperature-sensor at 48 {
>  		compatible = "ti,tmp75";
>  		reg = <0x48>;
> @@ -345,6 +366,26 @@ eeprom at 54 {
>  		compatible = "atmel,24c256";
>  		reg = <0x54>;
>  	};
> +
> +	power-sensor at 62 {
> +		compatible = "pmbus";
> +		reg = <0x62>;
> +	};
> +
> +	power-sensor at 64 {
> +		compatible = "pmbus";
> +		reg = <0x64>;
> +	};
> +
> +	power-sensor at 65 {
> +		compatible = "pmbus";
> +		reg = <0x65>;
> +	};
> +
> +	power-sensor at 68 {
> +		compatible = "pmbus";
> +		reg = <0x68>;
> +	};

See the discussion on your proposed DT binding document; I expect these
will need to change.

Andrew
