From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 30 Aug 2023 08:56:41 +0200
Subject: [PATCH v3 1/1] ARM: dts: aspeed: Minerva: Add Facebook Minerva
 (AST2600) BMC
In-Reply-To: <20230830025133.3756506-1-peteryin.openbmc@gmail.com>
References: <20230830025133.3756506-1-peteryin.openbmc@gmail.com>
Message-ID: <03729949-1994-6ce1-253b-886a254ac0af@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 30/08/2023 04:51, peteryin wrote:
> Add linux device tree entry related to
> Minerva specific devices connected to BMC SoC.
> 
> Signed-off-by: peteryin <peteryin.openbmc@gmail.com>
> ---
> v1 link : https://lore.kernel.org/all/fb09f5e6-8381-312f-2f1e-f2b471cec68a at linaro.org/
> v2 link : https://lore.kernel.org/lkml/9f499fe5-db59-f4c8-6a50-93725b7287fd at linaro.org/
> 
> Change log:
> 
> v3:
>     1.Fixed commit description.
>     2.Add sgpio line name to sgpioP.
>     3.Add ipmb debug card bus.
> 
> v2:
>     1.Add facebook,minerva-bmc in aspeed.yaml
>     2.Use stdout-path
>     3.Add Makefile
> 
> v1:
>     1. Create minerva dts file.
> 
> ---
>  .../bindings/arm/aspeed/aspeed.yaml           |   1 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-facebook-minerva.dts  | 384 ++++++++++++++++++
>  3 files changed, 386 insertions(+)
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

Nothing improved here. Checkpatch still complains. Bindings are always
separate patches.

Also, this patch does not apply to any tree.

Best regards,
Krzysztof

