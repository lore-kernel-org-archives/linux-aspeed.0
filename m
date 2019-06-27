From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 27 Jun 2019 13:25:42 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_2/8]_dt-bindings:_pinctrl:_aspeed:_Convert_AST2400_?=
 =?UTF-8?Q?bindings_to_json-schema?=
In-Reply-To: <CAL_JsqKXPzFYTHos-uvCUtBj-bcsNfrzt5GjxQ=PmgeXpp5J-A@mail.gmail.com>
References: <20190626071430.28556-1-andrew@aj.id.au>
 <20190626071430.28556-3-andrew@aj.id.au>
 <CAL_JsqKXPzFYTHos-uvCUtBj-bcsNfrzt5GjxQ=PmgeXpp5J-A@mail.gmail.com>
Message-ID: <30d5585b-7591-4149-87c4-816e4c18fb9d@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 26 Jun 2019, at 23:17, Rob Herring wrote:
> On Wed, Jun 26, 2019 at 1:21 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > +  The pin controller node should be the child of a syscon node with the
> > +  required property:
> > +
> > +  - compatible:     Should be one of the following:
> > +                    "aspeed,ast2400-scu", "syscon", "simple-mfd"
> > +                    "aspeed,g4-scu", "syscon", "simple-mfd"
> > +
> > +  Refer to the the bindings described in
> > +  Documentation/devicetree/bindings/mfd/syscon.txt
> > +
> > +  For the AST2400 pinmux, each mux function has only one associated pin group.
> > +  Each group is named by its function. The following values for the function
> > +  and groups properties are supported:
> > +
> > +  ACPI ADC0 ADC1 ADC10 ADC11 ADC12 ADC13 ADC14 ADC15 ADC2 ADC3 ADC4 ADC5 ADC6
> > +  ADC7 ADC8 ADC9 BMCINT DDCCLK DDCDAT EXTRST FLACK FLBUSY FLWP GPID GPID0 GPID2
> > +  GPID4 GPID6 GPIE0 GPIE2 GPIE4 GPIE6 I2C10 I2C11 I2C12 I2C13 I2C14 I2C3 I2C4
> > +  I2C5 I2C6 I2C7 I2C8 I2C9 LPCPD LPCPME LPCRST LPCSMI MAC1LINK MAC2LINK MDIO1
> > +  MDIO2 NCTS1 NCTS2 NCTS3 NCTS4 NDCD1 NDCD2 NDCD3 NDCD4 NDSR1 NDSR2 NDSR3 NDSR4
> > +  NDTR1 NDTR2 NDTR3 NDTR4 NDTS4 NRI1 NRI2 NRI3 NRI4 NRTS1 NRTS2 NRTS3 OSCCLK
> > +  PWM0 PWM1 PWM2 PWM3 PWM4 PWM5 PWM6 PWM7 RGMII1 RGMII2 RMII1 RMII2 ROM16 ROM8
> > +  ROMCS1 ROMCS2 ROMCS3 ROMCS4 RXD1 RXD2 RXD3 RXD4 SALT1 SALT2 SALT3 SALT4 SD1
> > +  SD2 SGPMCK SGPMI SGPMLD SGPMO SGPSCK SGPSI0 SGPSI1 SGPSLD SIOONCTRL SIOPBI
> > +  SIOPBO SIOPWREQ SIOPWRGD SIOS3 SIOS5 SIOSCI SPI1 SPI1DEBUG SPI1PASSTHRU
> > +  SPICS1 TIMER3 TIMER4 TIMER5 TIMER6 TIMER7 TIMER8 TXD1 TXD2 TXD3 TXD4 UART6
> > +  USB11D1 USB11H2 USB2D1 USB2H1 USBCKI VGABIOS_ROM VGAHS VGAVS VPI18 VPI24
> > +  VPI30 VPO12 VPO24 WDTRST1 WDTRST2
> 
> This should be a schema. You need to define child nodes and list these
> as values for 'function' and 'group'. Ideally, the child nodes would
> have some sort of pattern, but if not, you can just match on '^.*$'
> under patternProperties.

The children don't have any pattern in their node name, which drives
me towards the '^.*$' pattern match, however, what I've found is that
I get the following errors for some of the relevant dts files:

```
/home/andrew/src/linux/aspeed/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dt.yaml: compatible: ['aspeed,g4-pinctrl'] is not of type 'object'                                                                                                                                      
/home/andrew/src/linux/aspeed/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dt.yaml: pinctrl-names: ['default'] is not of type 'object'
/home/andrew/src/linux/aspeed/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dt.yaml: pinctrl-0: [[7, 8, 9, 10, 11, 12]] is not of type 'object'                                                                                                                                     
/home/andrew/src/linux/aspeed/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dt.yaml: phandle: [[13]] is not of type 'object'
/home/andrew/src/linux/aspeed/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dt.yaml: $nodename: ['pinctrl'] is not of type 'object'
/home/andrew/src/linux/aspeed/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dt.yaml: compatible: ['aspeed,g4-pinctrl'] is not of type 'object'                                                                                                                                       
/home/andrew/src/linux/aspeed/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dt.yaml: pinctrl-names: ['default'] is not of type 'object'
/home/andrew/src/linux/aspeed/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dt.yaml: pinctrl-0: [[9, 10, 11, 12]] is not of type 'object'
/home/andrew/src/linux/aspeed/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dt.yaml: phandle: [[13]] is not of type 'object'
/home/andrew/src/linux/aspeed/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dt.yaml: $nodename: ['pinctrl'] is not of type 'object'
```

We shouldn't be expecting these properties in the child nodes, so
something is busted. Looking at processed-schema.yaml, we have:

```
- $filename: /home/andrew/src/linux/aspeed/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
  $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2400-pinctrl.yaml#
  $schema: http://devicetree.org/meta-schemas/core.yaml#
  patternProperties:
    ^.*$:
      patternProperties:
        ^function|groups$:
          allOf:
          - {$ref: /schemas/types.yaml#/definitions/string}
          - additionalItems: false
            items:
              enum: [ACPI, ADC0, ADC1, ADC10, ADC11, ADC12, ADC13, ADC14, ADC15, ADC2,
                ADC3, ADC4, ADC5, ADC6, ADC7, ADC8, ADC9, BMCINT, DDCCLK, DDCDAT,
                EXTRST, FLACK, FLBUSY, FLWP, GPID, GPID0, GPID2, GPID4, GPID6, GPIE0,
                GPIE2, GPIE4, GPIE6, I2C10, I2C11, I2C12, I2C13, I2C14, I2C3, I2C4,
                I2C5, I2C6, I2C7, I2C8, I2C9, LPCPD, LPCPME, LPCRST, LPCSMI, MAC1LINK,
                MAC2LINK, MDIO1, MDIO2, NCTS1, NCTS2, NCTS3, NCTS4, NDCD1, NDCD2,
                NDCD3, NDCD4, NDSR1, NDSR2, NDSR3, NDSR4, NDTR1, NDTR2, NDTR3, NDTR4,
                NDTS4, NRI1, NRI2, NRI3, NRI4, NRTS1, NRTS2, NRTS3, OSCCLK, PWM0,
                PWM1, PWM2, PWM3, PWM4, PWM5, PWM6, PWM7, RGMII1, RGMII2, RMII1, RMII2,
                ROM16, ROM8, ROMCS1, ROMCS2, ROMCS3, ROMCS4, RXD1, RXD2, RXD3, RXD4,
                SALT1, SALT2, SALT3, SALT4, SD1, SD2, SGPMCK, SGPMI, SGPMLD, SGPMO,
                SGPSCK, SGPSI0, SGPSI1, SGPSLD, SIOONCTRL, SIOPBI, SIOPBO, SIOPWREQ,
                SIOPWRGD, SIOS3, SIOS5, SIOSCI, SPI1, SPI1DEBUG, SPI1PASSTHRU, SPICS1,
                TIMER3, TIMER4, TIMER5, TIMER6, TIMER7, TIMER8, TXD1, TXD2, TXD3,
                TXD4, UART6, USB11D1, USB11H2, USB2D1, USB2H1, USBCKI, VGABIOS_ROM,
                VGAHS, VGAVS, VPI18, VPI24, VPI30, VPO12, VPO24, WDTRST1, WDTRST2]
            maxItems: 1
            minItems: 1
            type: array
        pinctrl-[0-9]+: true
      properties: {phandle: true, pinctrl-names: true, status: true}
      type: object
    pinctrl-[0-9]+: true
  properties:
    $nodename: true
    compatible:
      additionalItems: false
      items:
      - enum: ['aspeed,ast2400-pinctrl', 'aspeed,g4-pinctrl']
      maxItems: 1
      minItems: 1
      type: array
    phandle: true
    pinctrl-names: true
    status: true
  required: [compatible]
  select:
    properties:
      compatible:
        contains:
          enum: ['aspeed,ast2400-pinctrl', 'aspeed,g4-pinctrl']
    required: [compatible]
  title: ASPEED AST2400 Pin Controller
```

`properties: {phandle: true, pinctrl-names: true, status: true}` has been
merged into my '^.*$' patternProperty, presumably partly from
pinctrl-consumer.yaml, and this seems to be the source of the bad
output. If as a hack I change my pattern to '^.*_default$' the problem
goes away as we no longer try to enforce the constraints on properties
provided by other bindings, but the problem is the node names are
largely freeform[1] (unless I enforce a naming constraint as part of my
bindings?).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt?h=v5.2-rc6#n112

> 
> BTW, You can put the names under a 'definitions' key and then use
> '$ref' to reference them from function and group to avoid duplicating
> the names. Or use patternProperties with '^(function|group)$'.

I've used the patternProperties approach above as I couldn't get the
definitions/$ref approach to work. I did the following:

```
definitions:
  pinctrl-value:
    allOf:
      - $ref: "/schemas/types.yaml#/definitions/string"
      - enum: [ "ACPI", "ADC0", "ADC1", "ADC10", "ADC11", "ADC12", "ADC13",
        "ADC14", "ADC15", "ADC2", "ADC3", "ADC4", "ADC5", "ADC6", "ADC7",
        "ADC8", "ADC9", "BMCINT", "DDCCLK", "DDCDAT", "EXTRST", "FLACK",
        "FLBUSY", "FLWP", "GPID", "GPID0", "GPID2", "GPID4", "GPID6", "GPIE0",
        "GPIE2", "GPIE4", "GPIE6", "I2C10", "I2C11", "I2C12", "I2C13", "I2C14",
        "I2C3", "I2C4", "I2C5", "I2C6", "I2C7", "I2C8", "I2C9", "LPCPD",
        "LPCPME", "LPCRST", "LPCSMI", "MAC1LINK", "MAC2LINK", "MDIO1", "MDIO2",
        "NCTS1", "NCTS2", "NCTS3", "NCTS4", "NDCD1", "NDCD2", "NDCD3", "NDCD4",
        "NDSR1", "NDSR2", "NDSR3", "NDSR4", "NDTR1", "NDTR2", "NDTR3", "NDTR4",
        "NDTS4", "NRI1", "NRI2", "NRI3", "NRI4", "NRTS1", "NRTS2", "NRTS3",
        "OSCCLK", "PWM0", "PWM1", "PWM2", "PWM3", "PWM4", "PWM5", "PWM6",
        "PWM7", "RGMII1", "RGMII2", "RMII1", "RMII2", "ROM16", "ROM8",
        "ROMCS1", "ROMCS2", "ROMCS3", "ROMCS4", "RXD1", "RXD2", "RXD3", "RXD4",
        "SALT1", "SALT2", "SALT3", "SALT4", "SD1", "SD2", "SGPMCK", "SGPMI",
        "SGPMLD", "SGPMO", "SGPSCK", "SGPSI0", "SGPSI1", "SGPSLD", "SIOONCTRL",
        "SIOPBI", "SIOPBO", "SIOPWREQ", "SIOPWRGD", "SIOS3", "SIOS5", "SIOSCI",
        "SPI1", "SPI1DEBUG", "SPI1PASSTHRU", "SPICS1", "TIMER3", "TIMER4",
        "TIMER5", "TIMER6", "TIMER7", "TIMER8", "TXD1", "TXD2", "TXD3", "TXD4",
        "UART6", "USB11D1", "USB11H2", "USB2D1", "USB2H1", "USBCKI",
        "VGABIOS_ROM", "VGAHS", "VGAVS", "VPI18", "VPI24", "VPI30", "VPO12",
        "VPO24", "WDTRST1", "WDTRST2" ]

patternProperties:
  '^.*_default$':
    type: object
    properties:
      function:
        $ref: "#/definitions/pinctrl-value"
      groups:
        $ref: "#/definitions/pinctrl-value"
```

But it gave me output like:

```
/home/andrew/src/linux/aspeed/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dt.yaml: wdtrst2_default:function: ['WDTRST2'] is not one of ['ACPI', 'ADC0', 'ADC1', 'ADC10', 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'DDCCLK', 'DDCDAT', 'EXTRST', 'FLACK', 'FLBUSY', 'FLWP', 'GPID', 'GPID0', 'GPID2', 'GPID4', 'GPID6', 'GPIE0', 'GPIE2', 'GPIE4', 'GPIE6', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'LPCPD', 'LPCPME', 'LPCRST', 'LPCSMI', 'MAC1LINK', 'MAC2LINK', 'MDIO1', 'MDIO2', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NDTS4', 'NRI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS1', 'NRTS2', 'NRTS3', 'OSCCLK', 'PWM0', 'PWM1', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'RGMII1', 'RGMII2', 'RMII1', 'RMII2', 'ROM16', 'ROM8', 'ROMCS1', 'ROMCS2', 'ROMCS3', 'ROMCS4', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT2', 'SALT3', 'SALT4', 'SD1', 'SD2', 'SGPMCK', 'SGPMI', 'SGPMLD', 'SGPMO', 'SGPSCK', 'SGPSI0', 'SGPSI1', 'SGPSLD', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1DEBUG', 'SPI1PASSTHRU', 'SPICS1', 'TIMER3', 'TIMER4', 'TIMER5', 'TIMER6', 'TIMER7', 'TIMER8', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART6', 'USB11D1', 'USB11H2', 'USB2D1', 'USB2H1', 'USBCKI', 'VGABIOS_ROM', 'VGAHS', 'VGAVS', 'VPI18', 'VPI24', 'VPI30', 'VPO12', 'VPO24', 'WDTRST1', 'WDTRST2']
/home/andrew/src/linux/aspeed/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dt.yaml: wdtrst2_default:groups: ['WDTRST2'] is not one of ['ACPI', 'ADC0', 'ADC1', 'ADC10', 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'DDCCLK', 'DDCDAT', 'EXTRST', 'FLACK', 'FLBUSY', 'FLWP', 'GPID', 'GPID0', 'GPID2', 'GPID4', 'GPID6', 'GPIE0', 'GPIE2', 'GPIE4', 'GPIE6', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'LPCPD', 'LPCPME', 'LPCRST', 'LPCSMI', 'MAC1LINK', 'MAC2LINK', 'MDIO1', 'MDIO2', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NDTS4', 'NRI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS1', 'NRTS2', 'NRTS3', 'OSCCLK', 'PWM0', 'PWM1', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'RGMII1', 'RGMII2', 'RMII1', 'RMII2', 'ROM16', 'ROM8', 'ROMCS1', 'ROMCS2', 'ROMCS3', 'ROMCS4', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT2', 'SALT3', 'SALT4', 'SD1', 'SD2', 'SGPMCK', 'SGPMI', 'SGPMLD', 'SGPMO', 'SGPSCK', 'SGPSI0', 'SGPSI1', 'SGPSLD', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1DEBUG', 'SPI1PASSTHRU', 'SPICS1', 'TIMER3', 'TIMER4', 'TIMER5', 'TIMER6', 'TIMER7', 'TIMER8', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART6', 'USB11D1', 'USB11H2', 'USB2D1', 'USB2H1', 'USBCKI', 'VGABIOS_ROM', 'VGAHS', 'VGAVS', 'VPI18', 'VPI24', 'VPI30', 'VPO12', 'VPO24', 'WDTRST1', 'WDTRST2']
```

Clearly I haven't got it quite right, but I'm not sure what's wrong with my approach. Can you tell me? It looks like the property is interpreted as a string-array rather than a string, but I'm not sure why.

Cheers,

Andrew
