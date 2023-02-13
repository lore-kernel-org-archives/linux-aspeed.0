From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 13 Feb 2023 09:26:30 +0100
Subject: [PATCH 1/4] dt-bindings: aspeed: Add UART controller
In-Reply-To: <KL1PR0601MB3781A9E9E209F2E94CE2F08D91DD9@KL1PR0601MB3781.apcprd06.prod.outlook.com>
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
 <20230210072643.2772-2-chiawei_wang@aspeedtech.com>
 <2d0d1866-95f9-942d-57e0-06a5ed17d35d@linaro.org>
 <KL1PR0601MB3781A9E9E209F2E94CE2F08D91DD9@KL1PR0601MB3781.apcprd06.prod.outlook.com>
Message-ID: <e09d6807-a548-0218-5ff0-274668f1eb94@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/02/2023 02:57, ChiaWei Wang wrote:
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Friday, February 10, 2023 5:13 PM
>>
>> On 10/02/2023 08:26, Chia-Wei Wang wrote:
>>> Add dt-bindings for Aspeed UART controller.
>>
>> Describe the hardware. What's the difference against existing Aspeed UART
>> used everywhere?
> 
> The description will be revised to explain more for UART and Virtual UART controllers.
> 
>>
>>>
>>> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
>>> ---
>>>  .../bindings/serial/aspeed,uart.yaml          | 81
>> +++++++++++++++++++
>>>  1 file changed, 81 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/serial/aspeed,uart.yaml
>>
>> Filename: aspeed,ast2600-uart.yaml
>> (unless you are adding here more compatibles, but your const suggests that it's
>> not going to happen)
>>
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/aspeed,uart.yaml
>>> b/Documentation/devicetree/bindings/serial/aspeed,uart.yaml
>>> new file mode 100644
>>> index 000000000000..10c457d6a72e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/serial/aspeed,uart.yaml
>>> @@ -0,0 +1,81 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/serial/aspeed,uart.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Aspeed Universal Asynchronous Receiver/Transmitter
>>
>> This title matches other Aspeed UARTs, so aren't you duplicating bindings?
>>
>>> +
>>> +maintainers:
>>> +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
>>> +
>>> +allOf:
>>> +  - $ref: serial.yaml#
>>> +
>>> +description: |
>>> +  The Aspeed UART is based on the basic 8250 UART and compatible
>>> +  with 16550A, with support for DMA
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: aspeed,ast2600-uart
>>> +
>>> +  reg:
>>> +    description: The base address of the UART register bank
>>
>> Drop description
> 
> Will revise as suggested.
> 
>>
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    description: The clock the baudrate is derived from
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    description: The IRQ number of the device
>>
>> Drop description
> 
> Will revise as suggested.
> 
>>
>>> +    maxItems: 1
>>> +
>>> +  dma-mode:
>>> +    type: boolean
>>> +    description: Enable DMA
>>
>> Drop property. DMA is enabled on presence of dmas.
>>
>>> +
>>> +  dma-channel:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: The channel number to be used in the DMA engine
>>
>> That's not a correct DMA property. dmas and dma-names git grep dma --
>> Documentation/devicetree/bindings/
>>
>>
>>> +
>>> +  virtual:
>>> +    type: boolean
>>> +    description: Indicate virtual UART
>>
>> Virtual means not existing in real world? We do not describe in DTS
>> non-existing devices. Drop entire property.
> 
> The virtual property indicates it is a Virtual UART device.

vuart already has its bindings, so you do not need this in such case.

> VUART of Aspeed SoC is actually a FIFO exposed in the 16550A UART interface.
> The one head of the FIFO is exposed to Host via eSPI/LPC and the other one is for BMC.
> There is no physical serial link between Host and BMC. And thus named as Virtual UART.

I don't understand what is the virtual in terms of hardware. How you
route your serial lines does not change the type of the device. You need
to describe the hardware in Devicetree, not some concepts for system.

> 
>>
>>> +
>>> +  sirq:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: The serial IRQ number on LPC bus interface
>>
>> Drop entire property.
> 
> Mandatory for Virtual UART

It's not a explanation why this is a property suitable for Devicetree.
IRQ numbers are given via interrupts field.

> 
>>
>>> +
>>> +  sirq-polarity:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: The serial IRQ polarity on LPC bus interface
>>
>> Drop entire property.
> 
> Mandatory for Virtual UART
> 

Same here, this is a flag for interrupts field.


Best regards,
Krzysztof

