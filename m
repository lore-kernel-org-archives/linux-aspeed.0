From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 28 Jun 2023 05:30:20 +0000
Subject: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
In-Reply-To: <f76f89a0-7773-6f64-c890-293093d4aba3@roeck-us.net>
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
 <20230608021839.12769-3-billy_tsai@aspeedtech.com>
 <c1c485b0-b68b-4db7-4b67-5d59f1ecb84e@roeck-us.net>
 <SG2PR06MB3365E360F3FCDE639F3D2D1E8B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
 <f76f89a0-7773-6f64-c890-293093d4aba3@roeck-us.net>
Message-ID: <SG2PR06MB33654B0D05D4644D409C5E888B24A@SG2PR06MB3365.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

        On 6/7/23 23:21, Billy Tsai wrote:
        > >          > The code says:
        > >
        > >          > In Aspeed AST2600 SoC features 16 TACH controllers, with each
        > >
        > >          > controller capable of supporting up to 1 input.
        > >
        > >          > which is a bit different. I guess there are no examples anymore,
        > >
        > >          > but I'd really like to see how this looks like in the devicetree file,
        > >
        > >          > and how the driver is supposed to distinguish/select the 16 inputs.
        > >
        > > Hi Roeck,
        > >
        > > The node in the devicetree file will looks like following:
        > >
        > > tach0: tach0 at 1e610008 {
        > >
        > >          compatible = "aspeed,ast2600-tach";
        > >
        > >          reg = <0x1e610008 0x8>;
        > >
        > >          #address-cells = <1>;
        > >
        > >          #size-cells = <0>;
        > >
        > >          pinctrl-names = "default";
        > >
        > >          pinctrl-0 = <&pinctrl_tach0_default>;
        > >
        > >          clocks = <&syscon ASPEED_CLK_AHB>;
        > >
        > >          resets = <&syscon ASPEED_RESET_PWM>;
        > >
        > >          status = "disabled";
        > >
        > > };
        > >

        > Neither reg nor pinctrl is mentioned in the bindings. Maybe that is not needed nowadays,
        > but I find it confusing.

        > Either case, it is highly unusual that there would be 16 instances of this device
        > instead of one. Why is this done ? It doesn't really make sense to me.

Having 16 instances of PWM and Tach is more compatible with our hardware design.
This is because our register layout for PWM and Tach is not continuous.
PWM0 used 0x0 0x4, Tach0 used 0x8 0xc
PWM1 used 0x10 0x14, Tach1 used 0x18 0x1c
...
Each PWM/Tach instance has its own controller register and is not dependent on others.

Thanks

Best Regards,
Billy Tsai
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230628/02c54aee/attachment.htm>
