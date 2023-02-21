From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 21 Feb 2023 12:04:38 +0100
Subject: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
In-Reply-To: <SEZPR06MB5269502D7CBCD5698B65FF9FF2A59@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
 <676c7777-635c-cc1f-b919-d33e84a45442@linaro.org>
 <TYZPR06MB527427ADCCD29DFD77FB0EE3F2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
 <80d873d4-d813-6c25-8f47-f5ff9af718ec@linaro.org>
 <SEZPR06MB5269502D7CBCD5698B65FF9FF2A59@SEZPR06MB5269.apcprd06.prod.outlook.com>
Message-ID: <c0ac0ab3-87fc-e74a-b4e2-3cf1b3a8a5e2@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/02/2023 11:42, Ryan Chen wrote:
>>>>> +    type: boolean
>>>>> +    description: Enable i2c bus timeout for master/slave (35ms)
>>>>
>>>> Why this is property for DT? It's for sure not bool, but proper type
>>>> coming from units.
>>> This is i2c controller feature for enable slave mode inactive timeout
>>> and also master mode sda/scl auto release timeout.
>>> So I will modify to
>>>   aspeed,timeout:
>>> 	type: boolean
>>>     description: I2C bus timeout enable for master/slave mode
>>
>> This does not answer my concerns. Why this is board specific?
> Sorry, can?t catch your point.
> It is not board specific. It is controller feature.
> ASPEED SOC chip is server product, master connect may have fingerprint
> connect to another board. And also support hotplug.
> For example I2C controller as slave mode, and suddenly disconnected.
> Slave state machine will keep waiting for master clock in for rx/tx transfer.
> So it need timeout setting to enable timeout unlock controller state.
> And in another side. As master mode, slave is clock stretching.
> The master will be keep waiting, until slave release cll stretching.

OK, thanks for describing the feature. I still do not see how this is DT
related.

> 
> So in those reason add this timeout design in controller. 

You need to justify why DT is correct place for this property. DT is not
for configuring OS, but to describe hardware. I gave you one possibility
- why different boards would like to set this property. You said it is
not board specific, thus all boards will have it (or none of them).
Without any other reason, this is not a DT property. Drop.

>>
>>>
>>>>> +
>>>>> +  byte-mode:
>>>>> +    type: boolean
>>>>> +    description: Force i2c driver use byte mode transmit
>>>>
>>>> Drop, not a DT property.
>>>>
>>>>> +
>>>>> +  buff-mode:
>>>>> +    type: boolean
>>>>> +    description: Force i2c driver use buffer mode transmit
>>>>
>>>> Drop, not a DT property.
>>>>
>>> The controller support 3 different for transfer.
>>> Byte mode: it means step by step to issue transfer.
>>> Example i2c read, each step will issue interrupt then enable next step.
>>> Sr (start read) | D | D | D | P
>>> Buffer mode: it means, the data can prepare into buffer register, then
>>> Trigger transfer. So Sr D D D P, only have only 1 interrupt handling.
>>> The DMA mode most like with buffer mode, The differ is data prepare in
>>> DRAM, than trigger transfer.
>>>
>>> So, should I modify to
>>>   aspeed,byte:
>>> 	type: boolean
>>>     description: Enable i2c controller transfer with byte mode
>>>
>>>   aspeed,buff:
>>> 	type: boolean
>>>     description: Enable i2c controller transfer with buff mode
>>
>> 1. No, these are not bools but enum in such case.
> 
> Thanks, will modify following.
> aspeed,xfer_mode:
>     enum: [0, 1, 2]
>     description:
>       0: byte mode, 1: buff_mode, 2: dma_mode

Just keep it text - byte, buffered, dma

> 
>> 2. And why exactly this is board-specific?
> 
> No, it not depends on board design. It is only for register control for controller transfer behave.
> The controller support 3 different trigger mode for transfer.
> Assign bus#1 ~ 3 : dma tranfer and assign bus#4 ~ 6 : buffer mode transfer,
> That can reduce the dram usage. 

Then anyway it does not look like property for Devicetree. DT describes
hardware, not OS behavior.

Best regards,
Krzysztof

