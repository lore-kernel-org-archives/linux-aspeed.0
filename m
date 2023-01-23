From: Rob Herring <robh@kernel.org>
Date: Mon, 23 Jan 2023 14:15:07 -0600
Subject: [PATCH 1/2] spi: dt-bindings: drop unneeded quotes
In-Reply-To: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
References: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
Message-ID: <167450490674.2450465.12158974323906034097.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Wed, 18 Jan 2023 18:39:31 +0100, Krzysztof Kozlowski wrote:
> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/spi/allwinner,sun4i-a10-spi.yaml  |  2 +-
>  .../bindings/spi/allwinner,sun6i-a31-spi.yaml  |  2 +-
>  .../bindings/spi/amlogic,meson-gx-spicc.yaml   |  6 +++---
>  .../bindings/spi/amlogic,meson6-spifc.yaml     |  6 +++---
>  .../bindings/spi/aspeed,ast2600-fmc.yaml       |  2 +-
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml |  2 +-
>  .../devicetree/bindings/spi/cdns,xspi.yaml     |  6 +++---
>  .../bindings/spi/fsl,spi-fsl-qspi.yaml         |  2 +-
>  .../devicetree/bindings/spi/fsl-imx-cspi.yaml  |  2 +-
>  .../bindings/spi/mediatek,spi-mt65xx.yaml      |  2 +-
>  .../spi/mediatek,spi-slave-mt27xx.yaml         |  2 +-
>  .../bindings/spi/mikrotik,rb4xx-spi.yaml       |  2 +-
>  .../bindings/spi/mxicy,mx25f0a-spi.yaml        |  2 +-
>  .../devicetree/bindings/spi/mxs-spi.yaml       |  2 +-
>  .../bindings/spi/nvidia,tegra210-quad.yaml     |  2 +-
>  .../bindings/spi/qcom,spi-qcom-qspi.yaml       |  5 ++---
>  .../bindings/spi/realtek,rtl-spi.yaml          |  2 +-
>  .../bindings/spi/snps,dw-apb-ssi.yaml          |  2 +-
>  .../devicetree/bindings/spi/spi-cadence.yaml   |  2 +-
>  .../devicetree/bindings/spi/spi-fsl-lpspi.yaml |  2 +-
>  .../devicetree/bindings/spi/spi-gpio.yaml      |  4 ++--
>  .../devicetree/bindings/spi/spi-mux.yaml       |  4 ++--
>  .../devicetree/bindings/spi/spi-nxp-fspi.yaml  |  2 +-
>  .../devicetree/bindings/spi/spi-pl022.yaml     | 18 +++++++++---------
>  .../devicetree/bindings/spi/spi-rockchip.yaml  |  2 +-
>  .../devicetree/bindings/spi/spi-sifive.yaml    |  6 +++---
>  .../bindings/spi/spi-sunplus-sp7021.yaml       |  2 +-
>  .../devicetree/bindings/spi/spi-xilinx.yaml    |  2 +-
>  .../bindings/spi/spi-zynqmp-qspi.yaml          |  2 +-
>  .../devicetree/bindings/spi/sprd,spi-adi.yaml  |  5 ++---
>  .../devicetree/bindings/spi/st,stm32-qspi.yaml |  2 +-
>  .../devicetree/bindings/spi/st,stm32-spi.yaml  |  2 +-
>  .../bindings/spi/xlnx,zynq-qspi.yaml           |  2 +-
>  33 files changed, 53 insertions(+), 55 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
