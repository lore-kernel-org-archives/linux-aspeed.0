From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 19 Jan 2023 08:20:35 +0100
Subject: [PATCH 1/2] spi: dt-bindings: drop unneeded quotes
In-Reply-To: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
References: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
Message-ID: <ad80f09b-3e05-ac71-b471-2b0279eb5ae6@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 18/01/2023 18:39, Krzysztof Kozlowski wrote:
> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/spi/allwinner,sun4i-a10-spi.yaml  |  2 +-
>   .../bindings/spi/allwinner,sun6i-a31-spi.yaml  |  2 +-
>   .../bindings/spi/amlogic,meson-gx-spicc.yaml   |  6 +++---
>   .../bindings/spi/amlogic,meson6-spifc.yaml     |  6 +++---

For meson changes:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

>   .../bindings/spi/aspeed,ast2600-fmc.yaml       |  2 +-
>   .../devicetree/bindings/spi/cdns,qspi-nor.yaml |  2 +-
>   .../devicetree/bindings/spi/cdns,xspi.yaml     |  6 +++---
>   .../bindings/spi/fsl,spi-fsl-qspi.yaml         |  2 +-
>   .../devicetree/bindings/spi/fsl-imx-cspi.yaml  |  2 +-
>   .../bindings/spi/mediatek,spi-mt65xx.yaml      |  2 +-
>   .../spi/mediatek,spi-slave-mt27xx.yaml         |  2 +-
>   .../bindings/spi/mikrotik,rb4xx-spi.yaml       |  2 +-
>   .../bindings/spi/mxicy,mx25f0a-spi.yaml        |  2 +-
>   .../devicetree/bindings/spi/mxs-spi.yaml       |  2 +-
>   .../bindings/spi/nvidia,tegra210-quad.yaml     |  2 +-
>   .../bindings/spi/qcom,spi-qcom-qspi.yaml       |  5 ++---
>   .../bindings/spi/realtek,rtl-spi.yaml          |  2 +-
>   .../bindings/spi/snps,dw-apb-ssi.yaml          |  2 +-
>   .../devicetree/bindings/spi/spi-cadence.yaml   |  2 +-
>   .../devicetree/bindings/spi/spi-fsl-lpspi.yaml |  2 +-
>   .../devicetree/bindings/spi/spi-gpio.yaml      |  4 ++--
>   .../devicetree/bindings/spi/spi-mux.yaml       |  4 ++--
>   .../devicetree/bindings/spi/spi-nxp-fspi.yaml  |  2 +-
>   .../devicetree/bindings/spi/spi-pl022.yaml     | 18 +++++++++---------
>   .../devicetree/bindings/spi/spi-rockchip.yaml  |  2 +-
>   .../devicetree/bindings/spi/spi-sifive.yaml    |  6 +++---
>   .../bindings/spi/spi-sunplus-sp7021.yaml       |  2 +-
>   .../devicetree/bindings/spi/spi-xilinx.yaml    |  2 +-
>   .../bindings/spi/spi-zynqmp-qspi.yaml          |  2 +-
>   .../devicetree/bindings/spi/sprd,spi-adi.yaml  |  5 ++---
>   .../devicetree/bindings/spi/st,stm32-qspi.yaml |  2 +-
>   .../devicetree/bindings/spi/st,stm32-spi.yaml  |  2 +-
>   .../bindings/spi/xlnx,zynq-qspi.yaml           |  2 +-
>   33 files changed, 53 insertions(+), 55 deletions(-)
> 

<snip>

> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> index 53eb6562b979..e5eca3a6f132 100644
> --- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> @@ -2,8 +2,8 @@
>   # Copyright 2019 BayLibre, SAS
>   %YAML 1.2
>   ---
> -$id: "http://devicetree.org/schemas/spi/amlogic,meson-gx-spicc.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/spi/amlogic,meson-gx-spicc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>   
>   title: Amlogic Meson SPI Communication Controller
>   
> @@ -41,7 +41,7 @@ properties:
>       maxItems: 2
>   
>   allOf:
> -  - $ref: "spi-controller.yaml#"
> +  - $ref: spi-controller.yaml#
>     - if:
>         properties:
>           compatible:
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
> index ac3b2ec300ac..806043fed4d1 100644
> --- a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
> @@ -2,8 +2,8 @@
>   # Copyright 2019 BayLibre, SAS
>   %YAML 1.2
>   ---
> -$id: "http://devicetree.org/schemas/spi/amlogic,meson6-spifc.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/spi/amlogic,meson6-spifc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>   
>   title: Amlogic Meson SPI Flash Controller
>   
> @@ -11,7 +11,7 @@ maintainers:
>     - Neil Armstrong <neil.armstrong@linaro.org>
>   
>   allOf:
> -  - $ref: "spi-controller.yaml#"
> +  - $ref: spi-controller.yaml#
>   
>   description: |
>     The Meson SPIFC is a controller optimized for communication with SPI

<snip>

