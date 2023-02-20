From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 20 Feb 2023 11:43:53 +0100
Subject: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
In-Reply-To: <TYZPR06MB5274714E58C319B4FE3B6E1BF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
 <2141e513acc750bf26775f5b435f4dccd41244aa.camel@codeconstruct.com.au>
 <TYZPR06MB5274714E58C319B4FE3B6E1BF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
Message-ID: <e2765493-0502-8c6d-39ce-e59581131dbf@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 20/02/2023 10:50, Ryan Chen wrote:
>> These are common to all i2c controllers, but I see that i2c-controller.yaml
>> doesn't include them (while i2c.text does).
>>
>> I assume we're OK to include these in the device bindings in the meantime.
>> But in that case, you may also want to include the common "smbus-alert"
>> property, which you consume in your driver.
>>
> Since i2c.text have multi-master, smbus-alert. I don't need those two right?

Yes, these should be dropped.

> 
>>> +? timeout:
>>> +??? type: boolean
>>> +??? description: Enable i2c bus timeout for master/slave (35ms)
>>> +
>>> +? byte-mode:
>>> +??? type: boolean
>>> +??? description: Force i2c driver use byte mode transmit
>>> +
>>> +? buff-mode:
>>> +??? type: boolean
>>> +??? description: Force i2c driver use buffer mode transmit
>>
>> These three aren't really a property of the hardware, more of the intended
>> driver configuration. Do they really belong in the DT?
>>
> Sorry, I am confused. 
> This is hardware controller mode setting for each i2c transfer. 
> So I add it in property for change different i2c transfer mode.
> Is my mis-understand the property setting?

You described the property as "Force I2C driver", so it is a not correct
description. DTS is not for controlling driver. You must describe here
hardware feature/property, not driver behavior. Also, it must be clear
for us why this is being customized per each board.

> 
>> [and how would a DT author know which modes to choose?]

Exactly.


Best regards,
Krzysztof

