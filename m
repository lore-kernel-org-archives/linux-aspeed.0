From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 20 Feb 2023 08:59:13 +0100
Subject: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
 i2C driver
In-Reply-To: <TYZPR06MB52741EB5CD43327A877CA20FF2A69@TYZPR06MB5274.apcprd06.prod.outlook.com>
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <20230201103359.1742140-3-ryan_chen@aspeedtech.com>
 <b0f55494-3a17-4d87-7b8f-5b078503cb53@linaro.org>
 <SEZPR06MB52690A1D06F3CFEAAF1FDBDEF2A39@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <b58fad13-12d5-346b-9452-d345c7bf5327@linaro.org>
 <TYZPR06MB5274C8D759C5C762C12A1CE9F2A09@TYZPR06MB5274.apcprd06.prod.outlook.com>
 <c5aa358d-6fb8-9d4d-eef7-d3a8268229e8@linaro.org>
 <TYZPR06MB5274B15C35A6030CB49BFD23F2A09@TYZPR06MB5274.apcprd06.prod.outlook.com>
 <bb73393c-d642-0128-9e63-1a751f090a85@linaro.org>
 <TYZPR06MB52741EB5CD43327A877CA20FF2A69@TYZPR06MB5274.apcprd06.prod.outlook.com>
Message-ID: <861da92e-c1a0-f08c-1241-8e833c32674e@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 18/02/2023 02:19, Ryan Chen wrote:
> Hello Krzysztof,
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Friday, February 17, 2023 4:37 PM
>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
>> Jeffery <andrew@aj.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
>> openbmc at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org;
>> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
>> Subject: Re: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
>> i2C driver
>>
>> On 16/02/2023 10:26, Ryan Chen wrote:
>>> Hello Krzysztof
>>>
>>>> -----Original Message-----
>>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Sent: Thursday, February 16, 2023 5:22 PM
>>>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
>>>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>>>> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>;
>>>> Andrew Jeffery <andrew@aj.id.au>; Philipp Zabel
>>>> <p.zabel@pengutronix.de>; openbmc at lists.ozlabs.org;
>>>> linux-arm-kernel at lists.infradead.org;
>>>> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
>>>> Subject: Re: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for
>>>> AST2600 i2C driver
>>>>
>>>> On 16/02/2023 10:20, Ryan Chen wrote:
>>>>> Hello Krzysztof
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>> Sent: Thursday, February 16, 2023 4:18 AM
>>>>>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
>>>>>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>>>>>> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>;
>>>>>> Andrew Jeffery <andrew@aj.id.au>; Philipp Zabel
>>>>>> <p.zabel@pengutronix.de>; openbmc at lists.ozlabs.org;
>>>>>> linux-arm-kernel at lists.infradead.org;
>>>>>> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
>>>>>> Subject: Re: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support
>>>>>> for
>>>>>> AST2600 i2C driver
>>>>>>
>>>>>> On 15/02/2023 06:43, Ryan Chen wrote:
>>>>>>>>> +  - $ref: /schemas/i2c/i2c-controller.yaml#
>>>>>>>>> +
>>>>>>>>> +properties:
>>>>>>>>> +  compatible:
>>>>>>>>> +    enum:
>>>>>>>>> +      - aspeed,ast2600-i2c
>>>>>>>>
>>>>>>>> NAK. It's already there. Please do not waste our time in
>>>>>>>> submitting duplicated drivers.
>>>>>>>
>>>>>>> It is not duplicated, as my description in cover " This series add
>>>>>>> AST2600 i2c
>>>>>> new register set driver"
>>>>>>> So, this will be different driver compatible.
>>>>>>> The original compatible is
>>>>>>>       - aspeed,ast2400-i2c-bus
>>>>>>>       - aspeed,ast2500-i2c-bus
>>>>>>>       - aspeed,ast2600-i2c-bus
>>>>>>> So the new register set compatible is "- aspeed,ast2600-i2c",
>>>>>>> remove
>>>> "bus".
>>>>>>
>>>>>> Bindings are documenting hardware, so I claim - we already have
>>>>>> this hardware described and this is duplicated. Otherwise - what
>>>>>> are these two I2C controllers and what are the differences? Why
>>>>>> they do not have really different name? Bus looks more like a
>>>>>> mistake than a
>>>> differentiating name.
>>>>> For misunderstanding, or mistaken.
>>>>> I purpose to be aspeed,ast2600-i2cv2, will it more clear way ?
>>>>
>>>> I don't know. I still did not get answers. I asked here several questions.
>>> Those are different i2c controller, as I description in cover letter.
>>
>> The cover letter does not explain here anything. It barely mentions "new
>> register set" and "separate register set". This is really short, so without proper
>> explanations you will get all these questions. Are they compatible? Do they
>> overlap? Are they completely different? If so, why datasheet uses same name
>> for them? So many questions but cover letter is basically two sentences and
>> here:
> 
> Sorry my misunderstanding.
> The legacy register layout is mix master/slave register control together.
> So will let confuse about register.
> The following is add more detail description about new register layout.
> And new feature set add for register.
> 
> -Add new clock divider option for more flexible and accurate clock rate generation
> -Add tCKHighMin timing to guarantee SCL high pulse width.
> -Add support dual pool buffer mode, split 32 bytes pool buffer of each device into 2 x 16 bytes for Tx and Rx individually.
> -Increase DMA buffer size to 4096 bytes and support byte alignment.
> -Re-define the base address of BUS1 ~ BUS16 and Pool buffer.
> -Re-define registers for separating master and slave mode control.
> -Support 4 individual DMA buffers for master Tx and Rx, slave Tx and Rx.
> 
> And following is new register set for package transfer sequence.
> New Master operation mode: S -> Aw -> P {S: Start, Sr: Repeat Start, Aw/r: Address for write/read, P: Stop}.
> New Master operation mode: S -> Aw -> TxD -> P
> New Master operation mode: S -> Ar -> RxD -> P
> New Slave  operation mode: S -> Aw -> RxD -> Sr -> Ar -> TxD -> P.
> -Bus SDA lock auto-release capability for new master DMA command mode.
> -Bus auto timeout for new master/slave DMA mode.
> 
> The following is two versus register layout.
> Old:
> {I2CD00}: Function Control Register     
> {I2CD04}: Clock and AC Timing Control Register \#1  
> {I2CD08}: Clock and AC Timing Control Register \#2 
> {I2CD0C}: Interrupt Control Register   
> {I2CD10}: Interrupt Status Register  
> {I2CD14}: Command/Status Register     
> {I2CD18}: Slave Device Address Register   
> {I2CD1C}: Pool Buffer Control Register   
> {I2CD20}: Transmit/Receive Byte Buffer Register 
> {I2CD24}: DMA Mode Buffer Address Register  
> {I2CD28}: DMA Transfer Length Register 
> {I2CD2C}: Original DMA Mode Buffer Address Setting     
> {I2CD30}: Original DMA Transfer Length Setting and Final Status  
> 
> New Register mode 
> {I2CC00}: Master/Slave Function Control Register    
> {I2CC04}: Master/Slave Clock and AC Timing Control Register  
> {I2CC08}: Master/Slave Transmit/Receive Byte Buffer Register    
> {I2CC0C}: Master/Slave Pool Buffer Control Register   
> {I2CM10}: Master Interrupt Control Register       
> {I2CM14}: Master Interrupt Status Register   
> {I2CM18}: Master Command/Status Register 
> {I2CM1C}: Master DMA Buffer Length Register   
> {I2CS20}: Slave~ Interrupt Control Register        
> {I2CS24}: Slave~ Interrupt Status Register          
> {I2CS28}: Slave~ Command/Status Register          
> {I2CS2C}: Slave~ DMA Buffer Length Register          
> {I2CM30}: Master DMA Mode Tx Buffer Base Address     
> {I2CM34}: Master DMA Mode Rx Buffer Base Address        
> {I2CS38}: Slave~ DMA Mode Tx Buffer Base Address           
> {I2CS3C}: Slave~ DMA Mode Rx Buffer Base Address        
> {I2CS40}: Slave Device Address Register                  
> {I2CM48}: Master DMA Length Status Register                 
> {I2CS4C}: Slave  DMA Length Status Register              
> {I2CC50}: Current DMA Operating Address Status           
> {I2CC54}: Current DMA Operating Length  Status     

Thanks for explanation, yet still I don't get whether these are separate
devices or not. So again, you got several questions and you should
answer them, not only parts of them.

Are they compatible? Do they overlap? Are they completely different? If
so, why datasheet uses same name for them?

I don't understand why we struggle so much to get basic info justifying
this patchset.


Best regards,
Krzysztof

