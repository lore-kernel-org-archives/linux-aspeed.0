From: Jernej Škrabec <jernej.skrabec@gmail.com>
Date: Sat, 18 Mar 2023 08:59:04 +0100
Subject: [PATCH] dt-bindings: pinctrl: Drop unneeded quotes
In-Reply-To: <20230317233623.3968172-1-robh@kernel.org>
References: <20230317233623.3968172-1-robh@kernel.org>
Message-ID: <1846135.tdWV9SEqCh@jernej-laptop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dne sobota, 18. marec 2023 ob 00:36:18 CET je Rob Herring napisal(a):
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pinctrl/actions,s500-pinctrl.yaml         |  2 +-
>  .../bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |  2 +-

For Allwinner:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  .../devicetree/bindings/pinctrl/apple,pinctrl.yaml     |  2 +-
>  .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml       |  4 ++--
>  .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml       |  4 ++--
>  .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml       |  6 +++---
>  .../bindings/pinctrl/brcm,bcm6318-pinctrl.yaml         |  2 +-
>  .../bindings/pinctrl/brcm,bcm63268-pinctrl.yaml        |  2 +-
>  .../bindings/pinctrl/brcm,bcm6328-pinctrl.yaml         |  2 +-
>  .../bindings/pinctrl/brcm,bcm6358-pinctrl.yaml         |  2 +-
>  .../bindings/pinctrl/brcm,bcm6362-pinctrl.yaml         |  2 +-
>  .../bindings/pinctrl/brcm,bcm6368-pinctrl.yaml         |  2 +-
>  .../devicetree/bindings/pinctrl/brcm,ns-pinmux.yaml    |  2 +-
>  .../devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml |  2 +-
>  .../devicetree/bindings/pinctrl/cirrus,lochnagar.yaml  |  2 +-
>  .../devicetree/bindings/pinctrl/cirrus,madera.yaml     |  4 ++--
>  .../devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml  |  2 +-
>  .../devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml |  2 +-
>  .../devicetree/bindings/pinctrl/fsl,imx8m-pinctrl.yaml |  2 +-
>  .../bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml          |  2 +-
>  .../devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml |  2 +-
>  .../devicetree/bindings/pinctrl/ingenic,pinctrl.yaml   |  2 +-
>  .../devicetree/bindings/pinctrl/intel,lgm-io.yaml      |  2 +-
>  .../bindings/pinctrl/marvell,ac5-pinctrl.yaml          |  4 ++--
>  .../bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml      |  4 ++--
>  .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml      |  4 ++--
>  .../bindings/pinctrl/mediatek,mt7622-pinctrl.yaml      |  6 +++---
>  .../bindings/pinctrl/mediatek,mt7986-pinctrl.yaml      |  6 +++---
>  .../bindings/pinctrl/mediatek,mt8183-pinctrl.yaml      |  4 ++--
>  .../bindings/pinctrl/mediatek,mt8188-pinctrl.yaml      |  2 +-
>  .../bindings/pinctrl/mediatek,pinctrl-mt6795.yaml      |  4 ++--
>  .../bindings/pinctrl/mscc,ocelot-pinctrl.yaml          |  6 +++---
>  .../devicetree/bindings/pinctrl/pinctrl-mt8186.yaml    |  2 +-
>  .../devicetree/bindings/pinctrl/pinctrl-mt8192.yaml    |  4 ++--
>  .../devicetree/bindings/pinctrl/pinctrl-mt8195.yaml    |  4 ++--
>  .../devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml    |  4 ++--
>  .../devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml     |  4 ++--
>  .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml         |  2 +-
>  .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml         |  2 +-
>  .../devicetree/bindings/pinctrl/qcom,tlmm-common.yaml  |  2 +-
>  .../bindings/pinctrl/ralink,mt7620-pinctrl.yaml        |  2 +-
>  .../bindings/pinctrl/ralink,mt7621-pinctrl.yaml        |  2 +-
>  .../bindings/pinctrl/ralink,rt2880-pinctrl.yaml        |  2 +-
>  .../bindings/pinctrl/ralink,rt305x-pinctrl.yaml        |  2 +-
>  .../bindings/pinctrl/ralink,rt3883-pinctrl.yaml        |  2 +-
>  .../devicetree/bindings/pinctrl/renesas,pfc.yaml       |  2 +-
>  .../bindings/pinctrl/renesas,rza1-ports.yaml           |  2 +-
>  .../bindings/pinctrl/renesas,rza2-pinctrl.yaml         |  2 +-
>  .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml        |  2 +-
>  .../bindings/pinctrl/renesas,rzn1-pinctrl.yaml         |  2 +-
>  .../bindings/pinctrl/renesas,rzv2m-pinctrl.yaml        |  2 +-
>  .../devicetree/bindings/pinctrl/rockchip,pinctrl.yaml  | 10 +++++-----
>  .../devicetree/bindings/pinctrl/samsung,pinctrl.yaml   |  2 +-
>  .../devicetree/bindings/pinctrl/semtech,sx1501q.yaml   |  6 +++---
>  .../bindings/pinctrl/socionext,uniphier-pinctrl.yaml   |  2 +-
>  .../devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml  | 10 +++++-----
>  .../bindings/pinctrl/starfive,jh7100-pinctrl.yaml      |  6 +++---
>  .../bindings/pinctrl/sunplus,sp7021-pinctrl.yaml       |  6 +++---
>  .../bindings/pinctrl/toshiba,visconti-pinctrl.yaml     |  8 ++++----
>  .../devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml |  2 +-
>  60 files changed, 97 insertions(+), 97 deletions(-)



