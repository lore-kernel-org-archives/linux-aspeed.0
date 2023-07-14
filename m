From: 蔡承達 <billyking19920205@gmail.com>
Date: Fri, 14 Jul 2023 15:04:10 +0800
Subject: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control documentation
Message-ID: <CAGUgbhCqOJaEPjS96o2au21uW4NhqFScm4Ayd8PzOQvqxQ94SQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

        On 6/7/23 23:21, Billy Tsai wrote:

        > > >          > The code says:

        > > >

        > > >          > In Aspeed AST2600 SoC features 16 TACH
controllers, with each

        > > >

        > > >          > controller capable of supporting up to 1 input.

        > > >

        > > >          > which is a bit different. I guess there are no
examples anymore,

        > > >

        > > >          > but I'd really like to see how this looks like in
the devicetree file,

        > > >

        > > >          > and how the driver is supposed to
distinguish/select the 16 inputs.

        > > >

        > > > Hi Roeck,

        > > >

        > > > The node in the devicetree file will looks like following:

        > > >

        > > > tach0: tach0 at 1e610008 {

        > > >

        > > >          compatible = "aspeed,ast2600-tach";

        > > >

        > > >          reg = <0x1e610008 0x8>;

        > > >

        > > >          #address-cells = <1>;

        > > >

        > > >          #size-cells = <0>;

        > > >

        > > >          pinctrl-names = "default";

        > > >

        > > >          pinctrl-0 = <&pinctrl_tach0_default>;

        > > >

        > > >          clocks = <&syscon ASPEED_CLK_AHB>;

        > > >

        > > >          resets = <&syscon ASPEED_RESET_PWM>;

        > > >

        > > >          status = "disabled";

        > > >

        > > > };

        > > >



        > > Neither reg nor pinctrl is mentioned in the bindings. Maybe
that is not needed nowadays,

        > > but I find it confusing.



        > > Either case, it is highly unusual that there would be 16
instances of this device

        > > instead of one. Why is this done ? It doesn't really make sense
to me.



        > Having 16 instances of PWM and Tach is more compatible with our
hardware design.

        > This is because our register layout for PWM and Tach is not
continuous.

        > PWM0 used 0x0 0x4, Tach0 used 0x8 0xc

        > PWM1 used 0x10 0x14, Tach1 used 0x18 0x1c

        > ...

        > Each PWM/Tach instance has its own controller register and is not
dependent on others.



Hi Guenter,



Did you receive a response to my previous email?

I would like to inquire if you have any further concerns regarding the PWM
and Tach with 16 instances.



Thanks



Best Regards,

Billy Tsai
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230714/a77627bb/attachment-0001.htm>
