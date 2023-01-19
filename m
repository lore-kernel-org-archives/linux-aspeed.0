From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 19 Jan 2023 08:21:12 +0100
Subject: [PATCH 2/2] spi: dt-bindings: cleanup examples - indentation,
 lowercase hex
In-Reply-To: <20230118173932.358153-2-krzysztof.kozlowski@linaro.org>
References: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
 <20230118173932.358153-2-krzysztof.kozlowski@linaro.org>
Message-ID: <a9059443-f125-f6dc-4686-8212165cd431@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 18/01/2023 18:39, Krzysztof Kozlowski wrote:
> Cleanup examples:
>   - use 4-space indentation (for cases when it is neither 4 not 2 space),
>   - drop redundant blank lines,
>   - use lowercase hex.
> 
> No functional impact except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/spi/amlogic,meson-gx-spicc.yaml  |  26 +--
>   .../bindings/spi/amlogic,meson6-spifc.yaml    |  22 +--

For meson changes:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

>   .../bindings/spi/aspeed,ast2600-fmc.yaml      |  24 +--
>   .../bindings/spi/brcm,spi-bcm-qspi.yaml       | 156 +++++++++---------
>   .../bindings/spi/cdns,qspi-nor.yaml           |   4 +-
>   .../bindings/spi/nvidia,tegra210-quad.yaml    |  42 ++---
>   .../bindings/spi/qcom,spi-qcom-qspi.yaml      |   1 -
>   .../devicetree/bindings/spi/renesas,rspi.yaml |  22 +--
>   .../bindings/spi/spi-sunplus-sp7021.yaml      |   4 +-
>   .../devicetree/bindings/spi/st,stm32-spi.yaml |   1 -
>   10 files changed, 150 insertions(+), 152 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> index e5eca3a6f132..4e28e6e9d8e0 100644
> --- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> @@ -100,17 +100,17 @@ unevaluatedProperties: false
>   examples:
>     - |
>       spi at c1108d80 {
> -          compatible = "amlogic,meson-gx-spicc";
> -          reg = <0xc1108d80 0x80>;
> -          interrupts = <112>;
> -          clocks = <&clk81>;
> -          clock-names = "core";
> -          #address-cells = <1>;
> -          #size-cells = <0>;
> -
> -          display at 0 {
> -              compatible = "lg,lg4573";
> -              spi-max-frequency = <1000000>;
> -              reg = <0>;
> -          };
> +        compatible = "amlogic,meson-gx-spicc";
> +        reg = <0xc1108d80 0x80>;
> +        interrupts = <112>;
> +        clocks = <&clk81>;
> +        clock-names = "core";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        display at 0 {
> +            compatible = "lg,lg4573";
> +            spi-max-frequency = <1000000>;
> +            reg = <0>;
> +        };
>       };
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
> index 806043fed4d1..8e769ccda97f 100644
> --- a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
> @@ -40,15 +40,15 @@ unevaluatedProperties: false
>   examples:
>     - |
>       spi at c1108c80 {
> -          compatible = "amlogic,meson6-spifc";
> -          reg = <0xc1108c80 0x80>;
> -          clocks = <&clk81>;
> -          #address-cells = <1>;
> -          #size-cells = <0>;
> -
> -          flash: flash at 0 {
> -              compatible = "spansion,m25p80", "jedec,spi-nor";
> -              reg = <0>;
> -              spi-max-frequency = <40000000>;
> -          };
> +        compatible = "amlogic,meson6-spifc";
> +        reg = <0xc1108c80 0x80>;
> +        clocks = <&clk81>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flash: flash at 0 {
> +            compatible = "spansion,m25p80", "jedec,spi-nor";
> +            reg = <0>;
> +            spi-max-frequency = <40000000>;
> +        };
>       };

<snip>

