From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 21 Feb 2024 08:22:27 +0100
Subject: [PATCH] dt-bindings: gpio: Convert Aspeed binding to YAML schema
In-Reply-To: <18dfd5f2eff5049fa5e3a098490dc601cf146f96.camel@codeconstruct.com.au>
References: <20240220052918.742793-1-andrew@codeconstruct.com.au>
 <0d1dd262-b6dd-4d71-9239-8b0aec8cceff@linaro.org>
 <18dfd5f2eff5049fa5e3a098490dc601cf146f96.camel@codeconstruct.com.au>
Message-ID: <9393d46b-6bb1-4aef-84ac-b22abeac7656@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/02/2024 03:41, Andrew Jeffery wrote:
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - aspeed,ast2400-gpio
>>>>> +      - aspeed,ast2500-gpio
>>>>> +      - aspeed,ast2600-gpio
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clocks:
>>>>> +    maxItems: 1
>>>>> +    description: The clock to use for debounce timings
>>>>> +
>>>>> +  interrupts:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  interrupt-controller: true
>>>>> +
>>>>> +  "#interrupt-cells":
>>>>> +    const: 2
>>>>> +
>>>
>>> ngpios with some constraints
> 
> Is this just with regard to the constraints I have under allOf above?

You miss ngpios.



Best regards,
Krzysztof

