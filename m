From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 11 Oct 2024 10:15:17 +1030
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
In-Reply-To: <172857036038.1533242.5775916298170949713.robh@kernel.org>
References: <20241010112337.3840703-1-naresh.solanki@9elements.com>
	 <172857036038.1533242.5775916298170949713.robh@kernel.org>
Message-ID: <4d596ac9a2215be8510369c948e0b9680ee2fce3.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Naresh,

On Thu, 2024-10-10 at 09:30 -0500, Rob Herring (Arm) wrote:
> On Thu, 10 Oct 2024 16:53:31 +0530, Naresh Solanki wrote:
> > Document the new compatibles used on IBM SBP1.
> > 
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > Changes in V4:
> > - Retain Acked-by from v2.
> > - Fix alphabetic order
> > ---
> >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-sbp1.dtb' for 20241010112337.3840703-1-naresh.solanki at 9elements.com:
> 

...

> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mux at 77: interrupts: False schema does not allow [[44, 4]]
> 	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu2 at 58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu2 at 58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu1 at 58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu1 at 58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu3 at 58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu3 at 58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator at 5f: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator at 5f: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator at 5f: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator at 5f: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu0 at 58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu0 at 58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#

These still must be addressed as mentioned on v3 (with more specific
comments regarding the infineon,ir38263 on v4). Please look through the
binding documents for the affected nodes and make sure the nodes in
your DTS conform to their definitions. You can check your work with
`make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-sbp1.dtb` prior to sending.

It may help to base your series on top of [1] to reduce the volume of
output from CHECK_DTBS=y.

Andrew

[1]: https://github.com/amboar/linux/tree/for/bmc/aspeed/dt

