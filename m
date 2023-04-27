From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 27 Apr 2023 10:34:43 +0930
Subject: [PATCH 4/4] ARM: dts: aspeed: mtmitchell: Add MCTP
In-Reply-To: <20230425065715.21871-5-chanh@os.amperecomputing.com>
References: <20230425065715.21871-1-chanh@os.amperecomputing.com>
 <20230425065715.21871-5-chanh@os.amperecomputing.com>
Message-ID: <f5c261ff-7901-434a-aa2f-3b2f684cb4a7@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 25 Apr 2023, at 16:27, Chanh Nguyen wrote:
> Enable MCTP driver on I2C3 bus for MCTP transaction
>
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts 
> b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> index 0b5ea8620063..33e06eafed31 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> @@ -366,6 +366,13 @@
> 
>  &i2c3 {
>  	status = "okay";
> +	bus-frequency = <1000000>;
> +	multi-master;
> +	mctp-controller;
> +	mctp at 10 {
> +		compatible = "mctp-i2c-controller";
> +		reg = <0x10>;

This needs to be `reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;`

Andrew
