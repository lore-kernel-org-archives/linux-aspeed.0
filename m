From: Rob Herring <robh@kernel.org>
Date: Fri, 04 Mar 2022 09:29:01 -0600
Subject: [PATCH v2 2/2] dt-bindings: gpu: Convert aspeed-gfx bindings to
 yaml
In-Reply-To: <20220304000311.970267-3-joel@jms.id.au>
References: <20220304000311.970267-1-joel@jms.id.au>
 <20220304000311.970267-3-joel@jms.id.au>
Message-ID: <1646407741.272520.3970570.nullmailer@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 04 Mar 2022 10:33:11 +1030, Joel Stanley wrote:
> Convert the bindings to yaml and add the ast2600 compatible string.
> 
> The legacy mfd description was put in place before the gfx bindings
> existed, to document the compatible that is used in the pinctrl
> bindings.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../devicetree/bindings/gpu/aspeed,gfx.yaml   | 69 +++++++++++++++++++
>  .../devicetree/bindings/gpu/aspeed-gfx.txt    | 41 -----------
>  .../devicetree/bindings/mfd/aspeed-gfx.txt    | 17 -----
>  3 files changed, 69 insertions(+), 58 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpu/aspeed,gfx.yaml
>  delete mode 100644 Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
>  delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-gfx.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1600723


display at 1e6e6000: 'memory-region' is a required property
	arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-opp-zaius.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-supermicro-x11spi.dt.yaml

