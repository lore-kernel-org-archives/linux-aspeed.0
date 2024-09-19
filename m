From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 19 Sep 2024 08:57:09 +0200
Subject: [PATCH v3 1/4] dt-bindings: mfd: aspeed: support for AST2700
In-Reply-To: <OS8PR06MB75416C23247B7AC64260C0AFF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240916091039.3584505-1-ryan_chen@aspeedtech.com>
 <20240916091039.3584505-2-ryan_chen@aspeedtech.com>
 <9b356379-907c-4112-8e24-1810cfa40ef6@kernel.org>
 <OS8PR06MB75416C23247B7AC64260C0AFF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
Message-ID: <f79a48e6-e0ff-453f-98c1-1c5acbe6467d@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 19/09/2024 08:05, Ryan Chen wrote:
>>> diff --git
>>> a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
>>> b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
>>> index 86ee69c0f45b..127a357051cd 100644
>>> --- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
>>> @@ -9,6 +9,8 @@ title: Aspeed System Control Unit
>>>  description:
>>>    The Aspeed System Control Unit manages the global behaviour of the
>> SoC,
>>>    configuring elements such as clocks, pinmux, and reset.
>>> +  In AST2700 SOC which has two soc connection, each soc have its own
>>> + scu  register control, ast2700-scu0 for soc0, ast2700-scu1 for soc1.
>>>
>>>  maintainers:
>>>    - Joel Stanley <joel@jms.id.au>
>>> @@ -21,6 +23,8 @@ properties:
>>>            - aspeed,ast2400-scu
>>>            - aspeed,ast2500-scu
>>>            - aspeed,ast2600-scu
>>> +          - aspeed,ast2700-scu0
>>> +          - aspeed,ast2700-scu1
>>>        - const: syscon
>>>        - const: simple-mfd
>>>
>>> @@ -30,10 +34,12 @@ properties:
>>>    ranges: true
>>>
>>>    '#address-cells':
>>> -    const: 1
>>> +    minimum: 1
>>> +    maximum: 2
>>>
>>>    '#size-cells':
>>> -    const: 1
>>> +    minimum: 1
>>> +    maximum: 2
>>
>> Why do the children have 64 bit addressing?
> 
> AST2700 is 64bit address, so it also.

But why do they need it?


Best regards,
Krzysztof

