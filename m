From: Rob Herring (Arm) <robh@kernel.org>
Date: Tue, 13 Aug 2024 09:46:26 -0600
Subject: [PATCH v2 2/2] dt-bindings: misc: aspeed,ast2400-cvic: Convert
 to DT schema
In-Reply-To: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-2-c2531e02633d@codeconstruct.com.au>
References: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-0-c2531e02633d@codeconstruct.com.au>
 <20240808-dt-warnings-irq-aspeed-dt-schema-v2-2-c2531e02633d@codeconstruct.com.au>
Message-ID: <172356398413.1009063.989428547920653092.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Thu, 08 Aug 2024 13:44:25 +0930, Andrew Jeffery wrote:
> Address warnings such as:
> 
>     arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: interrupt-controller at 1e6c0080: 'valid-sources' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> and
> 
>     arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/copro-interrupt-controller at 1e6c2000: failed to match any schema with compatible: ['aspeed,ast2400-cvic', 'aspeed-cvic']
> 
> Note that the conversion to DT schema causes some further warnings to
> be emitted, because the Aspeed devicetrees are not in great shape. These
> new warnings are resolved in a separate series:
> 
> https://lore.kernel.org/lkml/20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd at codeconstruct.com.au/
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  .../bindings/misc/aspeed,ast2400-cvic.yaml         | 60 ++++++++++++++++++++++
>  .../devicetree/bindings/misc/aspeed,cvic.txt       | 35 -------------
>  2 files changed, 60 insertions(+), 35 deletions(-)
> 

Applied, thanks!

