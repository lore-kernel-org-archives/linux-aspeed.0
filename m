From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 7 Mar 2023 09:11:36 +0100
Subject: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
In-Reply-To: <SEZPR06MB5269B541150855BF0DABFACFF2B69@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20230226031321.3126756-1-ryan_chen@aspeedtech.com>
 <20230226031321.3126756-2-ryan_chen@aspeedtech.com>
 <53090449-58c9-bc03-56df-aa8ae93c0c26@linaro.org>
 <SEZPR06MB52699DEB2255EB54F35C2A59F2AD9@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <fc20a2d1-e2f9-c22b-dcdf-153cb527eea8@linaro.org>
 <SEZPR06MB526902637624A97D7DFB8523F2B39@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <c41ee6b5-ddb4-1253-de54-a295b3bab2cc@linaro.org>
 <SEZPR06MB5269E7B8785B3CB56A63A916F2B39@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <a3615fe7-aa2a-53e9-2732-ba4512b9369d@linaro.org>
 <SEZPR06MB5269E7B070B239F8E349C427F2B39@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <c5cf6e0a-05dc-dff7-6218-df0984d1ba47@linaro.org>
 <SEZPR06MB5269CB53B51B89C3CA039442F2B09@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <e59fe30a-75d1-eb59-52a3-014fe3c961a6@linaro.org>
 <SEZPR06MB5269B541150855BF0DABFACFF2B69@SEZPR06MB5269.apcprd06.prod.outlook.com>
Message-ID: <d33145c3-e985-4d3c-a08c-6a249a8dc463@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/03/2023 01:48, Ryan Chen wrote:
> Hello Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Sunday, March 5, 2023 5:49 PM
>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Wolfram Sang
>> <wsa@kernel.org>
>> Cc: Joel Stanley <joel@jms.id.au>; Brendan Higgins
>> <brendan.higgins@linux.dev>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Andrew Jeffery <andrew@aj.id.au>;
>> devicetree at vger.kernel.org; Philipp Zabel <p.zabel@pengutronix.de>; Rob
>> Herring <robh+dt@kernel.org>; Benjamin Herrenschmidt
>> <benh@kernel.crashing.org>; linux-aspeed at lists.ozlabs.org;
>> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
>> openbmc at lists.ozlabs.org; linux-i2c at vger.kernel.org
>> Subject: Re: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for AST2600-i2cv2
>>
>> On 04/03/2023 02:33, Ryan Chen wrote:
>>> Hello Krzysztof,
>>>
>>>> -----Original Message-----
>>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Sent: Friday, March 3, 2023 6:41 PM
>>>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Wolfram Sang
>>>> <wsa@kernel.org>
>>>> Cc: Joel Stanley <joel@jms.id.au>; Brendan Higgins
>>>> <brendan.higgins@linux.dev>; Krzysztof Kozlowski
>>>> <krzysztof.kozlowski+dt@linaro.org>; Andrew Jeffery
>>>> <andrew@aj.id.au>; devicetree at vger.kernel.org; Philipp Zabel
>>>> <p.zabel@pengutronix.de>; Rob Herring <robh+dt@kernel.org>; Benjamin
>>>> Herrenschmidt <benh@kernel.crashing.org>;
>>>> linux-aspeed at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org;
>>>> linux-kernel at vger.kernel.org; openbmc at lists.ozlabs.org;
>>>> linux-i2c at vger.kernel.org
>>>> Subject: Re: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for
>>>> AST2600-i2cv2
>>>>
>>>> On 03/03/2023 11:16, Ryan Chen wrote:
>>>>>>>>>>> aspeed,timout properites:
>>>>>>>>>>> For example I2C controller as slave mode, and suddenly
>>>>>> disconnected.
>>>>>>>>>>> Slave state machine will keep waiting for master clock in for
>>>>>>>>>>> rx/tx
>>>>>>>> transmit.
>>>>>>>>>>> So it need timeout setting to enable timeout unlock controller
>> state.
>>>>>>>>>>> And in another side. In Master side also need avoid suddenly
>>>>>>>>>>> slave
>>>>>>>>>> miss(un-plug), Master will timeout and release the SDA/SCL.
>>>>>>>>>>>
>>>>>>>>>>> Do you mean add those description into ore aspeed,timout
>>>>>>>>>>> properites
>>>>>>>>>> description?
>>>>>>>>>>
>>>>>>>>>> You are describing here one particular feature you want to
>>>>>>>>>> enable in the driver which looks non-scalable and more
>>>>>>>>>> difficult to
>>>>>> configure/use.
>>>>>>>>>> What I was looking for is to describe the actual configuration
>>>>>>>>>> you have
>>>>>> (e.g.
>>>>>>>>>> multi-master) which leads to enable or disable such feature in
>>>>>>>>>> your
>>>>>>>> hardware.
>>>>>>>>>> Especially that bool value does not scale later to actual
>>>>>>>>>> timeout values in time (ms)...
>>>>>>>>>>
>>>>>>>>>> I don't know I2C that much, but I wonder - why this should be
>>>>>>>>>> specific to Aspeed I2C and no other I2C controllers implement it?
>>>>>>>>>> IOW, this looks quite generic and every I2C controller should
>>>>>>>>>> have it. Adding it specific to Aspeed suggests that either we
>>>>>>>>>> miss a generic property or this should not be in DT at all
>>>>>>>>>> (because no one else has
>>>>>>>> it...).
>>>>>>>>>>
>>>>>>>>>> Also I wonder, why you wouldn't enable timeout always...
>>>>>>>>>>
>>>>>>>>>> +Cc Wolfram,
>>>>>>>>>> Maybe you know whether bool "timeout" property for one
>>>>>>>>>> controller makes sense? Why we do not have it for all controllers?
>>>>>>>>>>
>>>>>>>>> Because, i2c bus didn?t specific timeout.
>>>>>>>>> But SMBus defines a clock low time-out, TIMEOUT of 35 ms.
>>>>>>>>>
>>>>>>>>> It have definition in SMBus specification.
>>>>>>>>> http://smbus.org/specs/SMBus_3_1_20180319.pdf
>>>>>>>>> You can check Page 18, Note3 that have timeout description.
>>>>>>>>
>>>>>>>> Then you have already property for this - "smbus"?
>>>>>>> To be a property "smbus", that would be a big topic, I saw fsl i2c
>>>>>>> also have this.
>>>>>>> https://github.com/torvalds/linux/blob/master/Documentation/device
>>>>>>> tr
>>>>>>> ee
>>>>>>> /bindings/i2c/i2c-mpc.yaml#L43-L47
>>>>>>> So, I just think the "timeout" property.
>>>>>>
>>>>>> Yeah and this is the only place. It also differs because it allows
>>>>>> actual timeout values.
>>>>> Thanks, So can I still keep the property "aspeed,timeout" here?
>>>>> It is the only place.
>>>>
>>>> No, because none of my concerns above are addressed.
>>>>
>>> Thanks, I realize your concerns.
>>>
>>> So, I modify it like i2c-mpc.yaml
>>> https://github.com/torvalds/linux/blob/master/Documentation/devicetree
>>> /bindings/i2c/i2c-mpc.yaml#L43-L47
>>>
>>>   aspeed,timeout:
>>>     $ref: /schemas/types.yaml#/definitions/uint32
>>>     description: |
>>>       I2C bus timeout in microseconds
>>> Is this way acceptable?
>>
>> So, let's repeat my last questions:
>>
>> 1. Why you wouldn't enable timeout always...
>>
>> You wrote:
>>> http://smbus.org/specs/SMBus_3_1_20180319.pdf
>>> You can check Page 18, Note3 that have timeout description.
>>
>> which indicates you should always use timeout, doesn't it?
> 
> Yes, if board design the bus is connected with SMBUS device, it should enable.
> But in my previous statement, the board design is two multi-master devices connected each other. 

For which you have the property, thus case is solved, isn't it? You want
timeout always except for multi-master?

> And both device is transfer with MCTP protocol. 
> That will not SMBUS protocol. 
> They need have timeout that prevent unexpected un-plug.
> I do the study with smbus in Linux, that will different slave call back. Compare with smbus slave and mctp slave.
> So in this scenario, that is only enable for timeout. 

And the driver knows which protocol it is going to talk and such choice
should not be in DT.

>  
>> 2. Why we do not have it for all controllers with SMBus v3? Why this one is
>> special?
> 
> Not all bus is connected with smbus. Most are i2c device connected in board.
> That will be specific statement for each bus.

That's not the answer to my question. Why other controllers which can be
connected to I2C or SMBus devices do not need this property?

Best regards,
Krzysztof

