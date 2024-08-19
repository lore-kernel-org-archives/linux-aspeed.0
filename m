From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 19 Aug 2024 10:00:29 +0930
Subject: [PATCH v12 10/28] ARM: dts: aspeed: yosemite4: Add power sensor
 for power module reading
In-Reply-To: <20240816092417.3651434-11-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240816092417.3651434-11-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <729e650fc7716b8507b19d43979782a7f2c420cb.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-08-16 at 17:23 +0800, Delphine CC Chiu wrote:
> Add power sensor for power module reading
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 09bbbcb192f5..139a09de24cf 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -906,6 +906,11 @@ gpio at 23 {
>  		"HSC7_ALERT2_R_N","HSC8_ALERT2_R_N";
>  	};
>  
> +	power-sensor at 40 {
> +		compatible = "mps,mp5023";
> +		reg = <0x40>;
> +	};
> +

This appears to be supported by hmwon but there's no binding for the
driver[1]. I'm hesitant to accept it and add more warnings to the
Aspeed devicetrees, but at the same time I'm sympathetic to leaving it
in.

Can you perhaps send a patch for
Documentation/devicetree/bindings/trivial-devices.yaml along with this
series?

Andrew

[1]: https://lore.kernel.org/all/20211217155206.GA3015782 at roeck-us.net/
