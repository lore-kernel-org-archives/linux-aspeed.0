From: Rob Herring <robh@kernel.org>
Date: Tue, 09 Apr 2024 08:38:37 -0500
Subject: [PATCH v2 1/5] ARM: dts: aspeed: greatlakes: correct Mellanox
 multi-host property
In-Reply-To: <20240405064624.18997-1-krzysztof.kozlowski@linaro.org>
References: <20240405064624.18997-1-krzysztof.kozlowski@linaro.org>
Message-ID: <171266958251.1032405.3082451019333889181.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Fri, 05 Apr 2024 08:46:20 +0200, Krzysztof Kozlowski wrote:
> "mlx,multi-host" is using incorrect vendor prefix and is not documented.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. None
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ampere-mtmitchell.dtb aspeed/aspeed-bmc-facebook-greatlakes.dtb aspeed/aspeed-bmc-facebook-harma.dtb aspeed/aspeed-bmc-facebook-yosemite4.dtb aspeed/aspeed-bmc-facebook-yosemitev2.dtb' for 20240405064624.18997-1-krzysztof.kozlowski at linaro.org:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: ftgmac at 1e690000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'mellanox,multi-host' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#





