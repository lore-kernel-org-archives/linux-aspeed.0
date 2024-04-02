From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 02 Apr 2024 15:11:55 +1030
Subject: [PATCH v1] Revise duty cycle for SMB9 and SMB10
In-Reply-To: <20240401090509.2338027-1-Delphine_CC_Chiu@Wiwynn.com>
References: <20240401090509.2338027-1-Delphine_CC_Chiu@Wiwynn.com>
Message-ID: <3aad5148383ba9e8fd905b09690ffa9c378b31de.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-04-01 at 17:05 +0800, Delphine CC Chiu wrote:
> ARM: dts: aspeed: yosemite4:
> Revise duty cycle for SMB9 and SMB10 to 40:60
> To meet 400kHz-i2c clock low time spec (> 1.3 us).
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 64075cc41d92..b3a2aa8f53a5 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -257,6 +257,7 @@ power-sensor at 40 {
>  &i2c8 {
>  	status = "okay";
>  	bus-frequency = <400000>;
> +	i2c-clk-high-min-percent = <40>;

A grep of the 6.9-rc2 tree doesn't turn up any mention of this property
name.

More work needs to be done if this is meant to have any effect.

What tree are you developing your patches against? If you're sending
them upstream then you must do your work (and test) in the context of
upstream.

Andrew
