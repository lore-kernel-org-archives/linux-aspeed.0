From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 19:36:52 +0100
Subject: [PATCH v2 4/4] dt-bindings: aspeed: Add eSPI controller
In-Reply-To: <582c276c-ea2f-456c-9bf9-47e39289a0b6@gmail.com>
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
 <20240319093405.39833-5-manojkiran.eda@gmail.com>
 <bad5df79-e040-4868-9db6-701110894ea3@linaro.org>
 <a9faa9b4-9bf6-49b6-b7eb-f642e2d261c3@gmail.com>
 <f2a487c4-eba3-4a78-9a14-67c8754c8b61@linaro.org>
 <582c276c-ea2f-456c-9bf9-47e39289a0b6@gmail.com>
Message-ID: <98a5c1b4-b508-45ed-8719-149ec960250c@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 28/03/2024 12:33, Manojkiran Eda wrote:
>>>>> +    description: Controls the flash channel of eSPI hardware
>>>> That explains nothing. Unless you wanted to use here MTD bindings.
>>>>
>>>> This binding did not improve much. I don't understand why this is not
>>>> SPI (nothing in commit msg, nothing in description), what is eSPI,
>>>
>>> eSPI uses Peripheral, Virtual Wire, Out of Band, and Flash Access
>>> channels to communicate different sets of data.
>>
>> And what are these channels? What does it mean a "channel"? Is it just
>> how you organize transfers and classes of devices? Or some sort of
>> addressable instance on the bus?
>>
> 
> Yes, an espi channel provides a means to allow multiple independent 
> flows of traffic to share the same physical bus. Each of the channels 
> has its own dedicated resources such as queue and flow control.

Resources as queue and flow-control? Where are they defined in
Devicetree? Which binding?

> 
>> The channels feel like some sort of software or logical concept, not
>> physical. Physical would be endpoint with peripheral. Or flash memory.
> 
> A channel is a logical communication pathway or interface between the 
> chipset and peripheral devices. The concept of channels in the ESPI 
> protocol helps organize and manage different types of communication 
> between the chipset and peripherals. Each channel may have its own set 
> of protocols, data transfer rates, and supported features, tailored to 
> the requirements of the devices it serves.
> 
>> How do they fit here?
> 
> I am not sure I understand, can you please elaborate ?

All this suggests channel is programming aspect of your device thus does
not have to be represented in DT. I don't know, come with any DT
property to back up your case...

So far I see only interrupts and clocks, but then I would claim these
could be part of parent node.

Rob said it last time: your split of nodes looks artificial and it all
looks like one node.

Your DTS reg like:
	reg = <0x0 0x800>,<0x0 0x4000000>;
proves it. I don't know if this is just bug in your code or some silly
DTS just to create fake children. :/

> 
>>>
>>>    * The *Peripheral* Channel is used for communication between eSPI host
>>>      bridge located on the master side and eSPI endpoints located on the
>>>      slave side. LPC Host and LPC Peripherals are an example of eSPI host
>>>      bridge and eSPI endpoints respectively.
>>>    * *Virtual Wire* Channel: The Virtual Wire channel is used to
>>>      communicate the state of sideband pins or GPIO tunneled through eSPI
>>>      as in-band messages. Serial IRQ interrupts are communicated through
>>>      this channel as in-band messages.
>>>    * *OOB* Channel: The SMBus packets are tunneled through eSPI as
>>>      Out-Of-Band (OOB) messages. The whole SMBus packet is embedded
>>>      inside the eSPI OOB message as data.
>>>    * *Flash Access* Channel: The Flash Access channel provides a path
>>>      allowing the flash components to be shared run-time between chipset
>>>      and the eSPI slaves that require flash accesses such as EC (Embedded
>>>      Controller) and BMC.
>>
>> Please make binding complete, so define all of the channels.
> 
> 
> I would like to inquire about the rationale behind this request. Based 

Rationale - writing bindings document.
https://elixir.bootlin.com/linux/v6.9-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L17


> on previous feedback received from the upstream efforts 
> [https://lore.kernel.org/openbmc/HK0PR06MB37798462D17443C697433D7191D09 at HK0PR06MB3779.apcprd06.prod.outlook.com/], 
> suggestions were made to model the flash channel by utilizing the mtd 
> subsystem, the virtual wire channel by utilizing the GPIO subsystem, and 
> to consider the OOB channel as a type of i2c device, thereby allowing it 
> to be utilized by the existing in-kernel MCTP subsystem, among others. 
> My intention was to prioritize upstreaming the flash channel binding, 
> along with its driver code, before proceeding to address other channels. 

Just to clarify: I don't care about drivers and we do not talk about
them here.

> I am curious to understand if it is a strict requirement to have the 
> complete binding upstreamed before addressing the device drivers code.

What if your other "devices" or "channels" are entirely different and
binding would just not work? Or how can we understand the design if you
upstream only part of it?

Best regards,
Krzysztof

