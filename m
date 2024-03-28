From: Manojkiran Eda <manojkiran.eda@gmail.com>
Date: Thu, 28 Mar 2024 11:33:44 -0000
Subject: [PATCH v2 4/4] dt-bindings: aspeed: Add eSPI controller
In-Reply-To: <f2a487c4-eba3-4a78-9a14-67c8754c8b61@linaro.org>
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
 <20240319093405.39833-5-manojkiran.eda@gmail.com>
 <bad5df79-e040-4868-9db6-701110894ea3@linaro.org>
 <a9faa9b4-9bf6-49b6-b7eb-f642e2d261c3@gmail.com>
 <f2a487c4-eba3-4a78-9a14-67c8754c8b61@linaro.org>
Message-ID: <582c276c-ea2f-456c-9bf9-47e39289a0b6@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 20/03/24 8:14 pm, Krzysztof Kozlowski wrote:
> On 20/03/2024 10:59, Manojkiran Eda wrote:
>>
>> On 19/03/24 3:26 pm, Krzysztof Kozlowski wrote:
>>> On 19/03/2024 10:34, Manojkiran Eda wrote:
>>>> This commit adds the device tree bindings for aspeed eSPI
>>>> controller.
>>>>
>>>> Although aspeed eSPI hardware supports 4 different channels,
>>>> this commit only adds the support for flash channel, the
>>>> bindings for other channels could be upstreamed when the driver
>>>> support for those are added.
>>>>
>>>> Signed-off-by: Manojkiran Eda<manojkiran.eda@gmail.com>
>>>> ---
>>>>    .../bindings/soc/aspeed/aspeed,espi.yaml      | 94 +++++++++++++++++++
>>>>    1 file changed, 94 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml b/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
>>>> new file mode 100644
>>>> index 000000000000..3d3ad528e3b3
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
>>> Why Rob's comments got ignored?
>>>
>>> This is not a soc component.
>> I did not mean to ignore, i have few reasons listed below that provides
>> information on why i felt this belongs into soc.
> 
> soc is dumping ground of things which are purely SoC specific, not
> covered by existing hardware structure in bindings. Maybe indeed this
> does not have any other place, but did you actually look?
> 

Yes, i did look at existing hardware bindings, and cannot seem to find 
out any other suitable place. I can definitely look again.

> Anyway, please CC SPI maintainers on future submission.

Sure, will add them.

> 
>>>
>>>> @@ -0,0 +1,94 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +# # Copyright (c) 2024 IBM Corporation.
>>>> +# # Copyright (c) 2021 Aspeed Technology Inc.
>>>> +%YAML 1.2
>>>> +---
>>>> +$id:http://devicetree.org/schemas/soc/aspeed/aspeed,espi.yaml#
>>>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Aspeed eSPI Controller
>>>> +
>>>> +maintainers:
>>>> +  - Manojkiran Eda<manojkiran.eda@gmail.com>
>>>> +  - Patrick Rudolph<patrick.rudolph@9elements.com>
>>>> +  - Chia-Wei Wang<chiawei_wang@aspeedtech.com>
>>>> +  - Ryan Chen<ryan_chen@aspeedtech.com>
>>>> +
>>>> +description:
>>>> +  Aspeed eSPI controller implements a device side eSPI endpoint device
>>>> +  supporting the flash channel.
>>> Explain what is eSPI.
>> eSPI is a serial bus interface for client and server platforms that is
> 
> Explain in description of the hardware.

Sure, i will add this description in the binding document in the future 
submission.
> 
>> based on SPI,? using the same master and slave topology but operates
>> with a different protocol to meet new requirements. For instance, eSPI
>> uses I/O, or input/output, communication, instead of MOSI/MISO used in
>> SPI. It also includes a transaction layer on top of the SPI protocol,
>> defining packets such as command and response packets that allow both
>> the master and slave to initiate alert and reset signals. eSPI supports
>> communication between Embedded Controller (EC), Baseboard Management
>> Controller (BMC), Super-I/O (SIO) and Port-80 debug cards. I could add
>> this to the commit message as well in the next patchset.
>>>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - enum:
>>>> +          - aspeed,ast2500-espi
>>>> +          - aspeed,ast2600-espi
>>>> +      - const: simple-mfd
>>>
>>> That's not simple-mfd. You have driver for this. Drop.
>>>
>>>> +      - const: syscon
>>> That's not syscon. Why do you have ranges then? Where is any explanation
>>> of hardware which would justify such combination?
>>>
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  "#address-cells":
>>>> +    const: 1
>>>> +
>>>> +  "#size-cells":
>>>> +    const: 1
>>>> +
>>>> +  ranges: true
>>>> +
>>>> +patternProperties:
>>>> +  "^espi-ctrl@[0-9a-f]+$":
>>>> +    type: object
>>>> +
>>>> +    description: Controls the flash channel of eSPI hardware
>>> That explains nothing. Unless you wanted to use here MTD bindings.
>>>
>>> This binding did not improve much. I don't understand why this is not
>>> SPI (nothing in commit msg, nothing in description), what is eSPI,
>>
>> eSPI uses Peripheral, Virtual Wire, Out of Band, and Flash Access
>> channels to communicate different sets of data.
> 
> And what are these channels? What does it mean a "channel"? Is it just
> how you organize transfers and classes of devices? Or some sort of
> addressable instance on the bus?
> 

Yes, an espi channel provides a means to allow multiple independent 
flows of traffic to share the same physical bus. Each of the channels 
has its own dedicated resources such as queue and flow control.

> The channels feel like some sort of software or logical concept, not
> physical. Physical would be endpoint with peripheral. Or flash memory.

A channel is a logical communication pathway or interface between the 
chipset and peripheral devices. The concept of channels in the ESPI 
protocol helps organize and manage different types of communication 
between the chipset and peripherals. Each channel may have its own set 
of protocols, data transfer rates, and supported features, tailored to 
the requirements of the devices it serves.

> How do they fit here?

I am not sure I understand, can you please elaborate ?

>>
>>    * The *Peripheral* Channel is used for communication between eSPI host
>>      bridge located on the master side and eSPI endpoints located on the
>>      slave side. LPC Host and LPC Peripherals are an example of eSPI host
>>      bridge and eSPI endpoints respectively.
>>    * *Virtual Wire* Channel: The Virtual Wire channel is used to
>>      communicate the state of sideband pins or GPIO tunneled through eSPI
>>      as in-band messages. Serial IRQ interrupts are communicated through
>>      this channel as in-band messages.
>>    * *OOB* Channel: The SMBus packets are tunneled through eSPI as
>>      Out-Of-Band (OOB) messages. The whole SMBus packet is embedded
>>      inside the eSPI OOB message as data.
>>    * *Flash Access* Channel: The Flash Access channel provides a path
>>      allowing the flash components to be shared run-time between chipset
>>      and the eSPI slaves that require flash accesses such as EC (Embedded
>>      Controller) and BMC.
> 
> Please make binding complete, so define all of the channels.


I would like to inquire about the rationale behind this request. Based 
on previous feedback received from the upstream efforts 
[https://lore.kernel.org/openbmc/HK0PR06MB37798462D17443C697433D7191D09 at HK0PR06MB3779.apcprd06.prod.outlook.com/], 
suggestions were made to model the flash channel by utilizing the mtd 
subsystem, the virtual wire channel by utilizing the GPIO subsystem, and 
to consider the OOB channel as a type of i2c device, thereby allowing it 
to be utilized by the existing in-kernel MCTP subsystem, among others. 
My intention was to prioritize upstreaming the flash channel binding, 
along with its driver code, before proceeding to address other channels. 
I am curious to understand if it is a strict requirement to have the 
complete binding upstreamed before addressing the device drivers code.

> 
>>
>> Although , eSPI reuses the timing and electrical specification of Serial
>> Peripheral Interface (SPI) but it runs an entirely different protocol to
>> meet a set of different requirements. Which is why i felt probably
>> placing this in soc was a better choice rather than spi. Do you think
>> otherwise ?
> 
> soc is dumping ground for things do not fit other places. Are there any
> other buses / IP blocks similar to this one?
> 
> 
> Best regards,
> Krzysztof
> 

Thanks,
Manoj
