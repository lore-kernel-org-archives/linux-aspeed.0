From: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
Date: Mon, 27 Mar 2023 11:12:42 +0700
Subject: [PATCH] ARM: dts: aspeed: mtjade, mtmitchell: Add OCP device
 temperature sensor
In-Reply-To: <20230218171002.8725-1-chanh@os.amperecomputing.com>
References: <20230218171002.8725-1-chanh@os.amperecomputing.com>
Message-ID: <df563be9-cde5-2cd5-1db0-6a1d5e100a06@amperemail.onmicrosoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear reviewers,

Just a gentle ping for the patch.

Thanks,
- Chanh

On 19/02/2023 00:10, Chanh Nguyen wrote:
> Define an I2C alias port from I2C Switch 0x70 at I2C5.
> Add the OCP device temperature sensor via I2C alias port
> as a tmp421 sensor.
> 
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
>   .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 16 ++++++++++
>   .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 29 +++++++++++++++++++
>   2 files changed, 45 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> index 0a51d2e32fab..b93339ed61c0 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> @@ -49,6 +49,11 @@
>   		 */
>   		i2c80 = &nvme_m2_0;
>   		i2c81 = &nvme_m2_1;
> +
> +		/*
> +		 *  i2c bus 82 assigned to OCP slot
> +		 */
> +		i2c82 = &ocpslot;
>   	};
>   
>   	chosen {
> @@ -420,6 +425,17 @@
>   		reg = <0x70>;
>   		i2c-mux-idle-disconnect;
>   
> +		ocpslot: i2c at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0>;
> +
> +			ocp_temp: temperature-sensor at 1f {
> +				compatible = "ti,tmp421";
> +				reg = <0x1f>;
> +			};
> +		};
> +
>   		nvmeslot_0_7: i2c at 3 {
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> index 4b91600eaf62..c832b8ae5999 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> @@ -10,6 +10,14 @@
>   	model = "Ampere Mt.Mitchell BMC";
>   	compatible = "ampere,mtmitchell-bmc", "aspeed,ast2600";
>   
> +	aliases {
> +		/*
> +		 *  i2c bus 30-31 assigned to OCP slot 0-1
> +		 */
> +		i2c30 = &ocpslot_0;
> +		i2c31 = &ocpslot_1;
> +	};
> +
>   	chosen {
>   		stdout-path = &uart5;
>   	};
> @@ -424,6 +432,27 @@
>   		#size-cells = <0>;
>   		reg = <0x70>;
>   		i2c-mux-idle-disconnect;
> +
> +		ocpslot_0: i2c at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0>;
> +
> +			ocpslot_0_temp: temperature-sensor at 1f {
> +				compatible = "ti,tmp421";
> +				reg = <0x1f>;
> +			};
> +		};
> +		ocpslot_1: i2c at 1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x1>;
> +
> +			ocpslot_1_temp: temperature-sensor at 1f {
> +				compatible = "ti,tmp421";
> +				reg = <0x1f>;
> +			};
> +		};
>   	};
>   };
>   
