From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 12 Aug 2024 08:34:20 +0200
Subject: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
In-Reply-To: <OS8PR06MB754103B3285153723708931EF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-2-ryan_chen@aspeedtech.com>
 <2f27285e-6aa5-4e42-b361-224d8d164113@kernel.org>
 <OS8PR06MB75416FAD2A1A16E7BE2D255DF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <10809e91-31be-4110-86c1-1e1ccb05b664@kernel.org>
 <OS8PR06MB7541F4F740FDB17F50EBCACBF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <OS8PR06MB754103B3285153723708931EF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
Message-ID: <a70e619e-daae-4a1d-a854-14356482892e@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/08/2024 08:26, Ryan Chen wrote:
>> Subject: RE: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
>>
>>> Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
>>>
>>> On 09/08/2024 07:55, Ryan Chen wrote:
>>>>> Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for
>>>>> AST2700
>>>>>
>>>>> On 08/08/2024 09:59, Ryan Chen wrote:
>>>>>> Add compatible support for AST2700 clk, reset, pinctrl, silicon-id
>>>>>> and example for AST2700 scu.
>>>>>>
>>>>>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>>>>>> ---
>>>>>>  .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 31
>>>>> +++++++++++++++++--
>>>>>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
>>>>>> b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
>>>>>> index 86ee69c0f45b..c0965f08ae8c 100644
>>>>>> ---
>>>>>> a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
>>>>>> +++
>> b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yam
>>>>>> +++ l
>>>>>> @@ -21,6 +21,8 @@ properties:
>>>>>>            - aspeed,ast2400-scu
>>>>>>            - aspeed,ast2500-scu
>>>>>>            - aspeed,ast2600-scu
>>>>>> +          - aspeed,ast2700-scu0
>>>>>> +          - aspeed,ast2700-scu1
>>>>>
>>>>> What are the differences between these two?
>>>>
>>>> The next [PATCH 4/4] is scu driver that include ast2700-scu0 and
>>>> ast2700-scu1 CLK_OF_DECLARE_DRIVER(ast2700_soc0,
>>>> "aspeed,ast2700-scu0", ast2700_soc0_clk_init);
>>>> CLK_OF_DECLARE_DRIVER(ast2700_soc1, "aspeed,ast2700-scu1",
>>>> ast2700_soc1_clk_init);
>>>
>>> What are hardware differences? Entirely different devices?
>>
>> AST2700 have two soc die connected each other.
>> Each soc die have it own scu, so the naming is ast2700-scu0 for soc0, another
>> is ast2700-scu1 for soc1.
>>
>>>
>>>> So I add these two.
>>>>
>>>>>
>>>>>>        - const: syscon
>>>>>>        - const: simple-mfd
>>>>>>
>>>>>> @@ -30,10 +32,12 @@ properties:
>>>>>>    ranges: true
>>>>>>
>>>>>>    '#address-cells':
>>>>>> -    const: 1
>>>>>> +    minimum: 1
>>>>>> +    maximum: 2
>>>>>>
>>>>>>    '#size-cells':
>>>>>> -    const: 1
>>>>>> +    minimum: 1
>>>>>> +    maximum: 2
>>>>>>
>>>>>>    '#clock-cells':
>>>>>>      const: 1
>>>>>> @@ -56,6 +60,8 @@ patternProperties:
>>>>>>              - aspeed,ast2400-pinctrl
>>>>>>              - aspeed,ast2500-pinctrl
>>>>>>              - aspeed,ast2600-pinctrl
>>>>>> +            - aspeed,ast2700-soc0-pinctrl
>>>>>> +            - aspeed,ast2700-soc1-pinctrl
>>>>>>
>>>>>>      required:
>>>>>>        - compatible
>>>>>> @@ -76,6 +82,7 @@ patternProperties:
>>>>>>                - aspeed,ast2400-silicon-id
>>>>>>                - aspeed,ast2500-silicon-id
>>>>>>                - aspeed,ast2600-silicon-id
>>>>>> +              - aspeed,ast2700-silicon-id
>>>>>>            - const: aspeed,silicon-id
>>>>>>
>>>>>>        reg:
>>>>>> @@ -115,4 +122,24 @@ examples:
>>>>>>              reg = <0x7c 0x4>, <0x150 0x8>;
>>>>>>          };
>>>>>>      };
>>>>>> +  - |
>>>>>> +    soc0 {
>>>>>> +        #address-cells = <2>;
>>>>>> +        #size-cells = <2>;
>>>>>
>>>>> That's the same example as previous, right? The drop, no need.
>>>>
>>>> AST2700 is 64bits address mode platform, that the reason.
>>>> So I add example for 64bits platform descript in dtsi I have to add
>>>> soc0 to be address-cells and size-cells to be <2> Then I can define
>>>> the register to be 64bits address and size.
>>>
>>> That's trivial. Drop.
>> Do you mean, I don?t need add example for ast2700-scu0?
>>
>> Or delete #address-cells = <2>;  #size-cells = <2>; If I remove it will make
>> dt_binding_check fail.
>>>
> Hello Krzysztof
> 
> Use dt_binding_check, it need #address-cells = <2>;  #size-cells = <2> for 64 bit address description.
> Or I don't need example?

Drop example. It's basically the same as existing one.

Best regards,
Krzysztof

