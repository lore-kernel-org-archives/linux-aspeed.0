From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 23 Jul 2019 10:11:05 +0930
Subject: [PATCH v2] ARM: dts: aspeed: tiogapass: Add VR devices
In-Reply-To: <20190723003216.2910042-1-vijaykhemka@fb.com>
References: <20190723003216.2910042-1-vijaykhemka@fb.com>
Message-ID: <a0a8162e-c21b-4b3d-b096-1676c5cc9758@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 23 Jul 2019, at 10:04, Vijay Khemka wrote:
> Adds voltage regulators Infineon pxe1610 devices to Facebook
> tiogapass platform.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

> ---
> In v2: Renamed vr to regulator and fixed some typo in commit message.
> 
>  .../dts/aspeed-bmc-facebook-tiogapass.dts     | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts 
> b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> index c4521eda787c..e722e9aef907 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> @@ -144,6 +144,42 @@
>  &i2c5 {
>  	status = "okay";
>  	// CPU Voltage regulators
> +	regulator at 48 {
> +		compatible = "infineon,pxe1610";
> +		reg = <0x48>;
> +	};
> +	regulator at 4a {
> +		compatible = "infineon,pxe1610";
> +		reg = <0x4a>;
> +	};
> +	regulator at 50 {
> +		compatible = "infineon,pxe1610";
> +		reg = <0x50>;
> +	};
> +	regulator at 52 {
> +		compatible = "infineon,pxe1610";
> +		reg = <0x52>;
> +	};
> +	regulator at 58 {
> +		compatible = "infineon,pxe1610";
> +		reg = <0x58>;
> +	};
> +	regulator at 5a {
> +		compatible = "infineon,pxe1610";
> +		reg = <0x5a>;
> +	};
> +	regulator at 68 {
> +		compatible = "infineon,pxe1610";
> +		reg = <0x68>;
> +	};
> +	regulator at 70 {
> +		compatible = "infineon,pxe1610";
> +		reg = <0x70>;
> +	};
> +	regulator at 72 {
> +		compatible = "infineon,pxe1610";
> +		reg = <0x72>;
> +	};
>  };
>  
>  &i2c6 {
> -- 
> 2.17.1
> 
>
