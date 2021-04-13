From: Steven Lee <steven_lee@aspeedtech.com>
Date: Tue, 13 Apr 2021 11:38:30 +0800
Subject: [PATCH v1 1/2] dt-bindings: mmc: sdhci-of-aspeed: Add power-gpio
 and power-switch-gpio
In-Reply-To: <OF2606E97A.D9A04B5B-ON002586B6.000DC6EE-002586B6.000EF1DC@notes.na.collabserv.com>
References: <20210413013010.GA353@aspeedtech.com>
 <20210408015218.20560-1-steven_lee@aspeedtech.com>
 <20210408015218.20560-2-steven_lee@aspeedtech.com>
 <20210409184118.GA3934798@robh.at.kernel.org>
 <OF2606E97A.D9A04B5B-ON002586B6.000DC6EE-002586B6.000EF1DC@notes.na.collabserv.com>
Message-ID: <20210413033829.GB3522@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 04/13/2021 10:43, Milton Miller II wrote:
> 
> 
> -----"openbmc" <openbmc-bounces+miltonm=us.ibm.com@lists.ozlabs.org> wrote: -----
> 
> >To: Rob Herring <robh@kernel.org>
> >From: Steven Lee 
> >Sent by: "openbmc" 
> >Date: 04/12/2021 08:31PM
> >Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
> ><devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
> >Ryan Chen <ryan_chen@aspeedtech.com>, "moderated list:ASPEED SD/MMC
> >DRIVER" <linux-aspeed@lists.ozlabs.org>, Andrew Jeffery
> ><andrew@aj.id.au>, "open list:ASPEED SD/MMC DRIVER"
> ><linux-mmc@vger.kernel.org>, "moderated list:ASPEED SD/MMC DRIVER"
> ><openbmc@lists.ozlabs.org>, Ryan Chen <ryanchen.aspeed@gmail.com>,
> >Adrian Hunter <adrian.hunter@intel.com>, open list
> ><linux-kernel@vger.kernel.org>, Chin-Ting Kuo
> ><chin-ting_kuo@aspeedtech.com>, "moderated list:ARM/ASPEED MACHINE
> >SUPPORT" <linux-arm-kernel@lists.infradead.org>
> >Subject: [EXTERNAL] Re: [PATCH v1 1/2] dt-bindings: mmc:
> >sdhci-of-aspeed: Add power-gpio and power-switch-gpio
> >
> >The 04/10/2021 02:41, Rob Herring wrote:
> >> On Thu, Apr 08, 2021 at 09:52:17AM +0800, Steven Lee wrote:
> >> > AST2600-A2 EVB provides the reference design for enabling SD bus
> >power
> >> > and toggling SD bus signal voltage by GPIO pins.
> >> > Add the definition and example for power-gpio and
> >power-switch-gpio
> >> > properties.
> >> > 
> >> > In the reference design, GPIOV0 of AST2600-A2 EVB is connected to
> >power
> >> > load switch that providing 3.3v to SD1 bus vdd. GPIOV1 is
> >connected to
> >> > a 1.8v and a 3.3v power load switch that providing signal voltage
> >to
> >> > SD1 bus.
> >> > If GPIOV0 is active high, SD1 bus is enabled. Otherwise, SD1 bus
> >is
> >> > disabled.
> >> > If GPIOV1 is active high, 3.3v power load switch is enabled, SD1
> >signal
> >> > voltage is 3.3v. Otherwise, 1.8v power load switch will be
> >enabled, SD1
> >> > signal voltage becomes 1.8v.
> >> > 
> >> > AST2600-A2 EVB also support toggling signal voltage for SD2 bus.
> >> > The design is the same as SD1 bus. It uses GPIOV2 as power-gpio
> >and GPIOV3
> >> > as power-switch-gpio.
> >> > 
> >> > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> >> > ---
> >> >  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 25
> >+++++++++++++++++++
> >> >  1 file changed, 25 insertions(+)
> >> > 
> >> > diff --git
> >a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> >b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> >> > index 987b287f3bff..515a74614f3c 100644
> >> > --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> >> > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> >> > @@ -37,6 +37,14 @@ properties:
> >> >    clocks:
> >> >      maxItems: 1
> >> >      description: The SD/SDIO controller clock gate
> >> > +  power-gpio:
> >> 
> >> '-gpios' is the preferred form even if just 1.
> >> 
> >
> >Thanks for reviewing, I will change the name.
> 
> is this a clock gate or a power on gpio?
> 
> 

A power on gpio.

> >
> >> > +    description:
> >> > +      The GPIO for enabling/disabling SD bus power.
> >> > +    maxItems: 1
> >> 
> >> blank line
> >> 
> >
> >I will remove the blank line.
> >
> >> > +  power-switch-gpio:
> >> > +    description:
> >> > +      The GPIO for toggling the signal voltage between 3.3v and
> >1.8v.
> 
> Which way does it toggle for which voltage?
> 
> Oh, you said in the change log but not in the binding.
>

I will add description in the binding.

> But please, use gpio controled regulators as Ulf suggested and is
> already used by other mmc controllers upstream.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/
> Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
> 

Thanks for reviewing and the information, I will use gpio-regulator
instead of power-gpio and power-switch-gpio.

> Ulf> Please do not model these as GPIO pins like this. Instead, it's better
> Ulf> to model them as gpio regulators, since the mmc core manages them as
> Ulf> regulators.
> Ulf> 
> Ulf> We have a vmmc regulator (corresponding to vdd) and a vqmmc regulator
> Ulf> (corresponding the signal-voltage level). These are also described in
> Ulf> the common mmc DT bindings, see
> Ulf> Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> Ulf> .
> 
> milton
> 
> >> > +    maxItems: 1
> >> >  
> >> >  patternProperties:
> >> >    "^sdhci@[0-9a-f]+$":
> >> > @@ -61,6 +69,14 @@ patternProperties:
> >> >        sdhci,auto-cmd12:
> >> >          type: boolean
> >> >          description: Specifies that controller should use auto
> >CMD12
> >> > +      power-gpio:
> >> > +        description:
> >> > +          The GPIO for enabling/disabling SD bus power.
> >> > +        maxItems: 1
> >> > +      power-switch-gpio:
> >> > +        description:
> >> > +          The GPIO for toggling the signal voltage between 3.3v
> >and 1.8v.
> >> > +        maxItems: 1
> >> >      required:
> >> >        - compatible
> >> >        - reg
> >> > @@ -80,6 +96,7 @@ required:
> >> >  examples:
> >> >    - |
> >> >      #include <dt-bindings/clock/aspeed-clock.h>
> >> > +    #include <dt-bindings/gpio/aspeed-gpio.h>
> >> >      sdc at 1e740000 {
> >> >              compatible = "aspeed,ast2500-sd-controller";
> >> >              reg = <0x1e740000 0x100>;
> >> > @@ -94,6 +111,10 @@ examples:
> >> >                      interrupts = <26>;
> >> >                      sdhci,auto-cmd12;
> >> >                      clocks = <&syscon ASPEED_CLK_SDIO>;
> >> > +                    power-gpio = <&gpio0 ASPEED_GPIO(V, 0)
> >> > +                                     GPIO_ACTIVE_HIGH>;
> >> > +                    power-switch-gpio = <&gpio0 ASPEED_GPIO(V,
> >1)
> >> > +                                     GPIO_ACTIVE_HIGH>;
> >> >              };
> >> >  
> >> >              sdhci1: sdhci at 200 {
> >> > @@ -102,5 +123,9 @@ examples:
> >> >                      interrupts = <26>;
> >> >                      sdhci,auto-cmd12;
> >> >                      clocks = <&syscon ASPEED_CLK_SDIO>;
> >> > +                    power-gpio = <&gpio0 ASPEED_GPIO(V, 2)
> >> > +                                     GPIO_ACTIVE_HIGH>;
> >> > +                    power-switch-gpio = <&gpio0 ASPEED_GPIO(V,
> >3)
> >> > +                                     GPIO_ACTIVE_HIGH>;
> >> >              };
> >> >      };
> >> > -- 
> >> > 2.17.1
> >> > 
> >
> >
> 
