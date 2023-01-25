From: Rob Herring <robh@kernel.org>
Date: Wed, 25 Jan 2023 14:05:39 -0600
Subject: [PATCH v2 2/2] spi: dt-bindings: cleanup examples - indentation,
 lowercase hex
In-Reply-To: <20230124083342.34869-2-krzysztof.kozlowski@linaro.org>
References: <20230124083342.34869-1-krzysztof.kozlowski@linaro.org>
 <20230124083342.34869-2-krzysztof.kozlowski@linaro.org>
Message-ID: <167467713905.2768614.7865748447151198568.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Tue, 24 Jan 2023 09:33:42 +0100, Krzysztof Kozlowski wrote:
> Cleanup examples:
>  - use 4-space indentation (for cases when it is neither 4 not 2 space),
>  - drop redundant blank lines,
>  - use lowercase hex.
> 
> No functional impact except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au> # aspeed
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org> # meson
> 
> ---
> 
> Changes since v1:
> 1. Adjust indentation in two more examples (cdns,qspi-nor, st,stm32-spi)
> 2. Add tags
> ---
>  .../bindings/spi/amlogic,meson-gx-spicc.yaml  |  26 +--
>  .../bindings/spi/amlogic,meson6-spifc.yaml    |  22 +--
>  .../bindings/spi/aspeed,ast2600-fmc.yaml      |  24 +--
>  .../bindings/spi/brcm,spi-bcm-qspi.yaml       | 156 +++++++++---------
>  .../bindings/spi/cdns,qspi-nor.yaml           |  34 ++--
>  .../bindings/spi/nvidia,tegra210-quad.yaml    |  42 ++---
>  .../bindings/spi/qcom,spi-qcom-qspi.yaml      |   1 -
>  .../devicetree/bindings/spi/renesas,rspi.yaml |  22 +--
>  .../bindings/spi/spi-sunplus-sp7021.yaml      |   4 +-
>  .../devicetree/bindings/spi/st,stm32-spi.yaml |  23 ++-
>  10 files changed, 176 insertions(+), 178 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
