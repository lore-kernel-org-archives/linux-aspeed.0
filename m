From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 8 Jun 2023 06:21:23 +0000
Subject: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
In-Reply-To: <c1c485b0-b68b-4db7-4b67-5d59f1ecb84e@roeck-us.net>
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
 <20230608021839.12769-3-billy_tsai@aspeedtech.com>
 <c1c485b0-b68b-4db7-4b67-5d59f1ecb84e@roeck-us.net>
Message-ID: <SG2PR06MB3365E360F3FCDE639F3D2D1E8B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

        > The code says:

        > In Aspeed AST2600 SoC features 16 TACH controllers, with each
        > controller capable of supporting up to 1 input.

        > which is a bit different. I guess there are no examples anymore,
        > but I'd really like to see how this looks like in the devicetree file,
        > and how the driver is supposed to distinguish/select the 16 inputs.
Hi Roeck,

The node in the devicetree file will looks like following:

tach0: tach0 at 1e610008 {
        compatible = "aspeed,ast2600-tach";
        reg = <0x1e610008 0x8>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_tach0_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "disabled";
};

tach1: tach1 at 1e610018 {
        compatible = "aspeed,ast2600-tach";
        reg = <0x1e610018 0x8>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_tach1_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "disabled";
};

tach2: tach2 at 1e610028 {
        compatible = "aspeed,ast2600-tach";
        reg = <0x1e610028 0x8>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_tach2_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "disabled";
};

tach3: tach3 at 1e610038 {
        compatible = "aspeed,ast2600-tach";
        reg = <0x1e610038 0x8>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_tach3_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "disabled";
};

tach4: tach4 at 1e610048 {
        compatible = "aspeed,ast2600-tach";
        reg = <0x1e610048 0x8>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_tach4_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "disabled";
};

tach5: tach5 at 1e610058 {
        compatible = "aspeed,ast2600-tach";
        reg = <0x1e610058 0x8>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_tach5_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "disabled";
};

tach6: tach6 at 1e610068 {
        compatible = "aspeed,ast2600-tach";
        reg = <0x1e610068 0x8>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_tach6_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "disabled";
};

tach7: tach7 at 1e610078 {
        compatible = "aspeed,ast2600-tach";
        reg = <0x1e610078 0x8>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_tach7_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "disabled";
};

tach8: tach8 at 1e610088 {
        compatible = "aspeed,ast2600-tach";
        reg = <0x1e610088 0x8>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_tach8_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "disabled";
};

tach9: tach9 at 1e610098 {
        compatible = "aspeed,ast2600-tach";
        reg = <0x1e610098 0x8>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_tach9_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "disabled";
};

tach10: tach10 at 1e6100A8 {
        compatible = "aspeed,ast2600-tach";
        reg = <0x1e6100A8 0x8>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_tach10_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "disabled";
};

tach11: tach11 at 1e6100B8 {
        compatible = "aspeed,ast2600-tach";
        reg = <0x1e6100B8 0x8>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_tach11_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "disabled";
};

tach12: tach12 at 1e6100C8 {
        compatible = "aspeed,ast2600-tach";
        reg = <0x1e6100C8 0x8>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_tach12_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "disabled";
};

tach13: tach13 at 1e6100D8 {
        compatible = "aspeed,ast2600-tach";
        reg = <0x1e6100D8 0x8>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_tach13_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "disabled";
};

tach14: tach14 at 1e6100E8 {
        compatible = "aspeed,ast2600-tach";
        reg = <0x1e6100E8 0x8>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_tach14_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "disabled";
};

tach15: tach15 at 1e6100F8 {
        compatible = "aspeed,ast2600-tach";
        reg = <0x1e6100F8 0x8>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_tach15_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "disabled";
};

Thanks
Best Regards,
Billy Tsai

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230608/84e95682/attachment-0001.htm>
