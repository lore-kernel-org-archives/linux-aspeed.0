From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 28 Aug 2023 08:58:30 +0200
Subject: [PATCH v2] Minerva: Add Meta openBMC Minerva dts file.
In-Reply-To: <20230828031714.107382-1-peteryin.openbmc@gmail.com>
References: <20230828031714.107382-1-peteryin.openbmc@gmail.com>
Message-ID: <9f499fe5-db59-f4c8-6a50-93725b7287fd@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 28/08/2023 05:17, peteryin wrote:
> This is for Meta openBMC Minerva dts.
> 
> Kernel:dev-6.1

??? NAK. We do not develop there.

Also subject is totally wrong. Drop redundant pieces, drop full stop.
Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

> 
> Signed-off-by: peteryin <peteryin.openbmc@gmail.com>
> 
> ---
> v1 link : https://lore.kernel.org/all/fb09f5e6-8381-312f-2f1e-f2b471cec68a at linaro.org/
> 
> Change log:
> v1:
>     1. Create minerva dts file.
> v2:
>     1.Add facebook,minerva-bmc in aspeed.yaml
>     2.use stdout-path
>     3.Add Makefile
> ---
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |   1 +

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.


>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-facebook-minerva.dts  | 329 ++++++++++++++++++
>  3 files changed, 331 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index fb4ce5df2fa0..9d1b26e7ca6b 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -79,6 +79,7 @@ properties:
>                - facebook,elbert-bmc
>                - facebook,fuji-bmc
>                - facebook,greatlakes-bmc
> +              - facebook,minerva-bmc
>                - ibm,everest-bmc
>                - ibm,rainier-bmc
>                - ibm,tacoma-bmc
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 6a897ff40ff0..e7c00905a08b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1603,6 +1603,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-facebook-wedge400.dtb \
>  	aspeed-bmc-facebook-yamp.dtb \
>  	aspeed-bmc-facebook-yosemitev2.dtb \
> +	aspeed-bmc-facebook-minerva.dtb \

Wrong order. 'm' is not after 'y'.

...

> +	/*X0-X7*/	"","","","","","","","",
> +	/*Y0-Y7*/	"","","","","","","","",
> +	/*Z0-Z7*/	"","","","","","","","";
> +};
> +

Still redundant blank line.

Best regards,
Krzysztof

