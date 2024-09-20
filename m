From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 20 Sep 2024 07:33:07 +0000
Subject: [PATCH v3 1/4] dt-bindings: mfd: aspeed: support for AST2700
In-Reply-To: <3185f620-28be-49b8-85f4-7ff8dd5ffce0@kernel.org>
References: <20240916091039.3584505-1-ryan_chen@aspeedtech.com>
 <20240916091039.3584505-2-ryan_chen@aspeedtech.com>
 <9b356379-907c-4112-8e24-1810cfa40ef6@kernel.org>
 <OS8PR06MB75416C23247B7AC64260C0AFF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <f79a48e6-e0ff-453f-98c1-1c5acbe6467d@kernel.org>
 <OS8PR06MB7541FDB6A74119A160B1A57CF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <3185f620-28be-49b8-85f4-7ff8dd5ffce0@kernel.org>
Message-ID: <OS8PR06MB7541773C1DC1CCE8E4149E3AF26C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: aspeed: support for AST2700
> 
> On 19/09/2024 09:13, Ryan Chen wrote:
> >> Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: aspeed: support for
> >> AST2700
> >>
> >> On 19/09/2024 08:05, Ryan Chen wrote:
> >>>>> diff --git
> >>>>> a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> >>>>> b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> >>>>> index 86ee69c0f45b..127a357051cd 100644
> >>>>> ---
> >>>>> a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> >>>>> +++
> b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yam
> >>>>> +++ l
> >>>>> @@ -9,6 +9,8 @@ title: Aspeed System Control Unit
> >>>>>  description:
> >>>>>    The Aspeed System Control Unit manages the global behaviour of
> >>>>> the
> >>>> SoC,
> >>>>>    configuring elements such as clocks, pinmux, and reset.
> >>>>> +  In AST2700 SOC which has two soc connection, each soc have its
> >>>>> + own scu  register control, ast2700-scu0 for soc0, ast2700-scu1
> >>>>> + for
> >> soc1.
> >>>>>
> >>>>>  maintainers:
> >>>>>    - Joel Stanley <joel@jms.id.au> @@ -21,6 +23,8 @@ properties:
> >>>>>            - aspeed,ast2400-scu
> >>>>>            - aspeed,ast2500-scu
> >>>>>            - aspeed,ast2600-scu
> >>>>> +          - aspeed,ast2700-scu0
> >>>>> +          - aspeed,ast2700-scu1
> >>>>>        - const: syscon
> >>>>>        - const: simple-mfd
> >>>>>
> >>>>> @@ -30,10 +34,12 @@ properties:
> >>>>>    ranges: true
> >>>>>
> >>>>>    '#address-cells':
> >>>>> -    const: 1
> >>>>> +    minimum: 1
> >>>>> +    maximum: 2
> >>>>>
> >>>>>    '#size-cells':
> >>>>> -    const: 1
> >>>>> +    minimum: 1
> >>>>> +    maximum: 2
> >>>>
> >>>> Why do the children have 64 bit addressing?
> >>>
> >>> AST2700 is 64bit address, so it also.
> >>
> >> But why do they need it?
> >>
> > Sorry, I may not understand your point.
> 
> I asked why do you think children require 64-bit addressing, instead of working
> with existing 32-bit address.
> 
> > Since address-cell = <2>, Do you mean size-cell still 1?
> 
> No... although that's another point, how bug address size is there? For the
> children?
> 
> > If yes. I do the dts check it need size-cells=<2>, when I do
> > address-cells = <2>
> 
> Well, I talk about bus and children addressing. It's kind of obvious that
> changing one property means using different reg...
> 
Understood your point, I don?t use so much for size, size-cell = <1> is enough, will keep <1>
> Best regards,
> Krzysztof

