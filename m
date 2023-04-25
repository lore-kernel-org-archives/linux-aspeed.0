From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 25 Apr 2023 15:15:08 +0200
Subject: [PATCH 2/4] ARM: dts: aspeed: mtmitchell: Add I2C Fan
In-Reply-To: <20230425065715.21871-3-chanh@os.amperecomputing.com>
References: <20230425065715.21871-1-chanh@os.amperecomputing.com>
 <20230425065715.21871-3-chanh@os.amperecomputing.com>
Message-ID: <7ee3eec8-b5b4-2591-adcd-1831bf7de02b@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 25/04/2023 08:57, Chanh Nguyen wrote:
> Add the MAX31790 node as a Fan I2C controller. It controls the
> TACH and PWM for Fan Mt.Mitchell system.
> 
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> index e79f56208b89..6455cf80da0e 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> @@ -477,6 +477,18 @@
>  			line-name = "bmc-ocp0-en-n";
>  		};
>  	};
> +
> +	max31790 at 20 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "maxim,max31790";

Unfortunately the compatible is undocumented.

Please run scripts/checkpatch.pl and fix reported warnings.

Best regards,
Krzysztof

