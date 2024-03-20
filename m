From: Manojkiran Eda <manojkiran.eda@gmail.com>
Date: Wed, 20 Mar 2024 09:59:29 -0000
Subject: [PATCH v2 4/4] dt-bindings: aspeed: Add eSPI controller
In-Reply-To: <bad5df79-e040-4868-9db6-701110894ea3@linaro.org>
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
 <20240319093405.39833-5-manojkiran.eda@gmail.com>
 <bad5df79-e040-4868-9db6-701110894ea3@linaro.org>
Message-ID: <a9faa9b4-9bf6-49b6-b7eb-f642e2d261c3@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 19/03/24 3:26 pm, Krzysztof Kozlowski wrote:
> On 19/03/2024 10:34, Manojkiran Eda wrote:
>> This commit adds the device tree bindings for aspeed eSPI
>> controller.
>>
>> Although aspeed eSPI hardware supports 4 different channels,
>> this commit only adds the support for flash channel, the
>> bindings for other channels could be upstreamed when the driver
>> support for those are added.
>>
>> Signed-off-by: Manojkiran Eda<manojkiran.eda@gmail.com>
>> ---
>>   .../bindings/soc/aspeed/aspeed,espi.yaml      | 94 +++++++++++++++++++
>>   1 file changed, 94 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml b/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
>> new file mode 100644
>> index 000000000000..3d3ad528e3b3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
> Why Rob's comments got ignored?
>
> This is not a soc component.
I did not mean to ignore, i have few reasons listed below that provides 
information on why i felt this belongs into soc.
>
>> @@ -0,0 +1,94 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# # Copyright (c) 2024 IBM Corporation.
>> +# # Copyright (c) 2021 Aspeed Technology Inc.
>> +%YAML 1.2
>> +---
>> +$id:http://devicetree.org/schemas/soc/aspeed/aspeed,espi.yaml#
>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Aspeed eSPI Controller
>> +
>> +maintainers:
>> +  - Manojkiran Eda<manojkiran.eda@gmail.com>
>> +  - Patrick Rudolph<patrick.rudolph@9elements.com>
>> +  - Chia-Wei Wang<chiawei_wang@aspeedtech.com>
>> +  - Ryan Chen<ryan_chen@aspeedtech.com>
>> +
>> +description:
>> +  Aspeed eSPI controller implements a device side eSPI endpoint device
>> +  supporting the flash channel.
> Explain what is eSPI.
eSPI is a serial bus interface for client and server platforms that is 
based on SPI,? using the same master and slave topology but operates 
with a different protocol to meet new requirements. For instance, eSPI 
uses I/O, or input/output, communication, instead of MOSI/MISO used in 
SPI. It also includes a transaction layer on top of the SPI protocol, 
defining packets such as command and response packets that allow both 
the master and slave to initiate alert and reset signals. eSPI supports 
communication between Embedded Controller (EC), Baseboard Management 
Controller (BMC), Super-I/O (SIO) and Port-80 debug cards. I could add 
this to the commit message as well in the next patchset.
>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - aspeed,ast2500-espi
>> +          - aspeed,ast2600-espi
>> +      - const: simple-mfd
>
> That's not simple-mfd. You have driver for this. Drop.
>
>> +      - const: syscon
> That's not syscon. Why do you have ranges then? Where is any explanation
> of hardware which would justify such combination?
>
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  ranges: true
>> +
>> +patternProperties:
>> +  "^espi-ctrl@[0-9a-f]+$":
>> +    type: object
>> +
>> +    description: Controls the flash channel of eSPI hardware
> That explains nothing. Unless you wanted to use here MTD bindings.
>
> This binding did not improve much. I don't understand why this is not
> SPI (nothing in commit msg, nothing in description), what is eSPI,

eSPI uses Peripheral, Virtual Wire, Out of Band, and Flash Access 
channels to communicate different sets of data.

  * The *Peripheral* Channel is used for communication between eSPI host
    bridge located on the master side and eSPI endpoints located on the
    slave side. LPC Host and LPC Peripherals are an example of eSPI host
    bridge and eSPI endpoints respectively.
  * *Virtual Wire* Channel: The Virtual Wire channel is used to
    communicate the state of sideband pins or GPIO tunneled through eSPI
    as in-band messages. Serial IRQ interrupts are communicated through
    this channel as in-band messages.
  * *OOB* Channel: The SMBus packets are tunneled through eSPI as
    Out-Of-Band (OOB) messages. The whole SMBus packet is embedded
    inside the eSPI OOB message as data.
  * *Flash Access* Channel: The Flash Access channel provides a path
    allowing the flash components to be shared run-time between chipset
    and the eSPI slaves that require flash accesses such as EC (Embedded
    Controller) and BMC.

Although , eSPI reuses the timing and electrical specification of Serial 
Peripheral Interface (SPI) but it runs an entirely different protocol to 
meet a set of different requirements. Which is why i felt probably 
placing this in soc was a better choice rather than spi. Do you think 
otherwise ?

>   why
> do you need child device, what are other children (commit msg is quite
> vague here). Why there is no MTD bindings here?
>
> All this looks like crafted for your driver,

Apologies, this was not my intention. I wanted this to be as generic as 
possible. But i don't really have much knowledge on what's the right way 
to model things in kernel at the moment. Still trying to learn and 
understand by looking at various other drivers. Appreciate all the 
feedback.
>   instead of using existing
> DT bindings like SPI or MTD/NAND. This is a strong no-go.

>> +
>> +    properties:
>> +      compatible:
>> +        items:
> No items, just use enum.
sure, will fix it.
>> +          - enum:
>> +              - aspeed,ast2500-espi-ctrl
>> +              - aspeed,ast2600-espi-ctrl
>> +
>> +      interrupts:
>> +        maxItems: 1
>> +
>> +      clocks:
>> +        maxItems: 1
>> +
>> +    required:
>> +      - compatible
>> +      - interrupts
>> +      - clocks
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - ranges
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/ast2600-clock.h>
>> +
>> +    espi: espi at 1e6ee000 {
>> +        compatible = "aspeed,ast2600-espi", "simple-mfd", "syscon";
>> +        reg = <0x1e6ee000 0x1000>;
>> +
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges = <0x0 0x1e6ee000 0x1000>;
>> +
>> +        espi_ctrl: espi-ctrl at 0 {
>> +            compatible = "aspeed,ast2600-espi-ctrl";
>> +            reg = <0x0 0x800>,<0x0 0x4000000>;
> Fix your style in DTS. There is always a space after ','.
sure , will fix that. Is there a link that could help me understand 
various styling requirements on the DTS files. Also is there any 
formatting tool available currently ? that could fix the styling in the 
DTS files automatically rather than manual inspection/modification. Did 
i accidentally missed running some tool check ?
>
>> +            reg-names = "espi_ctrl","espi_flash";
>> +            interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
>> +        };
>> +    };
> Best regards,
> Krzysztof
>
>
Krzysztof,Thanks for the review comments. I am still figuring out few of the 
review comments (would need a little more time, since its my first 
attempt into kernel development) , but mean while I wanted to make sure 
if the direction of choosing "soc" vs "spi" was correct, so that i could 
re-work on the comments.So i have selectively answered to few of your 
comments. Could you let me know if the reasoning that was provided in 
reply to your comments help ? Thanks, Manoj
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240320/f2a0be08/attachment-0001.htm>
