From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Apr 2024 09:38:28 -0500
Subject: [PATCH v3 01/14] dt-bindings: spi: Document the IBM Power SPI
 controller
In-Reply-To: <992317a7-2606-404c-bc62-4d181ea9e147@kernel.org>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-2-eajames@linux.ibm.com>
 <e2b52bfb-0742-4baf-8269-86075b5cc54e@kernel.org>
 <f1c3947c-e1c8-4dac-bbf7-e9c0dc9c27e9@linux.ibm.com>
 <992317a7-2606-404c-bc62-4d181ea9e147@kernel.org>
Message-ID: <b2bdae97-7cd5-4961-9cd4-1142a862d55f@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 4/28/24 11:39, Krzysztof Kozlowski wrote:
> On 26/04/2024 16:49, Eddie James wrote:
>> On 4/26/24 01:15, Krzysztof Kozlowski wrote:
>>> On 25/04/2024 23:36, Eddie James wrote:
>>>> The IBM Power chips have a basic SPI controller. Document it.
>>> Please use subject prefixes matching the subsystem. You can get them for
>>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>>> your patch is touching.
>>
>> Isn't spi the right subsystem here?
> And what prefix shall be for SPI bindings? Did you run the command or
> just replying to disagree with me?


The correct prefix is either dt-bindings: spi or spi: dt-bindings. I 
used the former. Would you prefer I use the latter? I followed your 
instructions but you see the results are mixed, which is why I asked for 
clarification, wondering if you meant something else, since I already 
used one of the two apparently correct options.


53df0409b59b Merge branch 'for-next' of 
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
f63175733f91 spi: dt-bindings: armada-3700: convert to dtschema
1f48cbd6f00f spi: renesas,sh-msiof: Add r8a779h0 support
eb4fdb4bf46f spi: dt-bindings: cdns,qspi-nor: make cdns,fifo-depth optional
52826aee484b spi: dt-bindings: cdns,qspi-nor: add mobileye,eyeq5-ospi 
compatible
002514d91fcc spi: dt-bindings: cdns,qspi-nor: sort compatibles 
alphabetically
02ec75edaa94 dt-bindings: treewide: add access-controllers description
80a38bfbbd59 spi: dt-bindings: introduce FIFO depth properties
ee09bb727bff spi: dt-bindings: samsung: make dma properties not required
666db8fd4265 spi: dt-bindings: atmel,at91rm9200-spi: remove 9x60 
compatible from list
ff690e75d64b spi: dt-bindings: samsung: add google,gs101-spi compatible
737cf74b3800 spi: dt-bindings: samsung: Add Exynos850 SPI
18ab9e9e8889 dt-bindings: spi: nxp-fspi: support i.MX93 and i.MX95
6685d552a0cc dt-bindings: spi: fsl-lpspi: support i.MX95 LPSPI
f034a151059a dt-bindings: spi: stm32: add st,stm32mp25-spi compatible
e1fca6957f19 spi: dw: Remove Intel Thunder Bay SOC support
4c3ff31a85e3 spi: axi-spi-engine improvements
252eafe11ffc dt-bindings: spi: axi-spi-engine: convert to yaml
54a1dc08e173 spi: dt-bindings: renesas,rspi: Document RZ/Five SoC
09388379b6d7 spi: add stm32f7-spi compatible
1b2e883e1af8 spi: Merge up fix
4056d88866e5 spi: renesas,rzv2m-csi: Add CSI (SPI) target related property
9f778f377cd3 spi: dt-bindings: Make "additionalProperties: true" explicit
da6de6d3ecc1 spi: qup: Allow scaling power domains and
0fc57bf1b2ff spi: dt-bindings: st,stm32-spi: Move "st,spi-midi-ns" to 
spi-peripheral-props.yaml
d15befc0cef4 spi: dt-bindings: qup: Document interconnects
e6419c35f0d9 spi: dt-bindings: qup: Document power-domains and OPP
3b4e5194138b dt-bindings: spi: fsl-imx-cspi: Document missing entries
b0ef97ac89a7 spi: dt-bindings: arm,pl022: Move child node properties to 
separate schema
8f447694c23a Merge tag 'devicetree-for-6.6' of 
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
47aab53331ef dt-bindings: Fix typos
0e19118ab24b dt-bindings: spi: convert spi-brcm63xx.txt to YAML
0d2b6a1b8515 dt-bindings: qspi: cdns,qspi-nor: Add clocks for StarFive 
JH7110 SoC
ffae65fb1ae4 dt-bindings: spi: spi-cadence: Add label property
883622752403 dt-bindings: spi: spi-cadence: Describe power-domains property
b350e6c6297a spi: dt-bindings: add loongson spi
026badeb7055 spi: fspi: Add power-domains to the DT bindings
49aa77165c00 spi: lpspi: Add power-domains to the DT bindings
8858babff615 dt-bindings: spi: add reference file to YAML
b8968c388b69 dt-bindings: spi: Convert Tegra114 SPI to json-schema
17a9ab02f72c dt-bindings: spi: tegra-sflash: Convert to json-schema
8c87a46e2ce3 dt-bindings: spi: tegra-slink: Convert to json-schema
6c1561fb9005 Merge tag 'soc-dt-6.5' of 
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
e884a133340a spi: dt-bindings: atmel,at91rm9200-spi: fix broken sam9x7 
compatible
a3eb95484f27 spi: dt-bindings: atmel,at91rm9200-spi: add sam9x7 compatible
14dde0746e67 spi: dt-bindings: Add bindings for RZ/V2M CSI
01fa9edd8bcf spi: dt-bindings: stm32: do not disable spi-slave property 
for stm32f4-f7
e6afe03351ac spi: stm32: disable spi-slave property for stm32f4-f7
7bac98a338d6 spi: dt-bindings: snps,dw-apb-ssi: Add compatible for Intel 
Mount Evans SoC
d5c421d24d7e dt-bindings: xilinx: Switch xilinx.com emails to amd.com
34fcc0f0a410 spi: dt-bindings: socionext,uniphier: drop address/size-cells
bbd25f1ae8bf spi: dt-bindings: samsung: drop cs-gpios


>
>
> Best regards,
> Krzysztof
>
