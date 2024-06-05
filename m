From: Rob Herring (Arm) <robh@kernel.org>
Date: Wed, 05 Jun 2024 07:11:32 -0600
Subject: [PATCH v1] ARM: dts: aspeed: System1: Updates to BMC board
In-Reply-To: <20240604215939.1967329-1-ninad@linux.ibm.com>
References: <20240604215939.1967329-1-ninad@linux.ibm.com>
Message-ID: <171759284804.2200781.9915039390039475490.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Tue, 04 Jun 2024 16:59:39 -0500, Ninad Palsule wrote:
> - Added new power monitor device max5970
> - Changed temperature sensor monitor chip from tmp423 to tmp432
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
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


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20240604215939.1967329-1-ninad at linux.ibm.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: power-monitor at 3a: 'regulators' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: power-monitor at 3a: 'vss1-supply' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: power-monitor at 3a: 'vss2-supply' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#





