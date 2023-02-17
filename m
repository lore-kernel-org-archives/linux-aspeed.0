From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 17 Feb 2023 12:32:36 +0100
Subject: [PATCH] ARM: dts: aspeed: mtmitchell: Enable NCSI
In-Reply-To: <20230217102122.16547-1-chanh@os.amperecomputing.com>
References: <20230217102122.16547-1-chanh@os.amperecomputing.com>
Message-ID: <c594a426-9ad3-1f67-8261-4d2d68272870@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 17/02/2023 11:21, Chanh Nguyen wrote:
> Support the mac3 (RGMII4) as an NC-SI stack instead of an MDIO PHY.
> 
> The OCP slot #0 and OCP slot #1 use a common the BMC_NCSI signal,
> so we use only one of them at the same time. The OCP slot #0 will
> be enabled by PCA9539's setting by default.
> 
> Also, enable the OCP Auxiliary Power during booting.
> 
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
>  .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 37 ++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> index 4b91600eaf62..e8a6b1f08d6a 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> @@ -251,6 +251,14 @@
>  	pinctrl-0 = <&pinctrl_rgmii1_default>;
>  };
>  
> +&mac3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii4_default>;
> +	clock-names = "MACCLK", "RCLK";
> +	use-ncsi;
> +};
> +
>  &fmc {
>  	status = "okay";
>  	flash at 0 {
> @@ -439,6 +447,26 @@
>  	status = "okay";
>  };
>  
> +&i2c8 {
> +	status = "okay";
> +
> +	pca9539 at 77 {

Node names should be generic, so I believe this is "gpio".
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Best regards,
Krzysztof

