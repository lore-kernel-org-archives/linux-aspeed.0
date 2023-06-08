From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 8 Jun 2023 08:21:52 +0000
Subject: [v6 1/4] dt-bindings: pwm: Add ASPEED PWM Control documentation
In-Reply-To: <61278e12-ba39-4503-ca74-a7118b0f6e99@linaro.org>
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
 <20230608021839.12769-2-billy_tsai@aspeedtech.com>
 <4dffd320-8e30-fb30-6ded-79519afddc21@linaro.org>
 <SG2PR06MB3365DD80EA2FD026D400C4A78B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
 <61278e12-ba39-4503-ca74-a7118b0f6e99@linaro.org>
Message-ID: <SG2PR06MB336528007D2685F8D95DF4078B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

        On 08/06/2023 09:47, Billy Tsai wrote:
        >>
        >>   >> +
        >>   >> +allOf:
        >>   >> +  - $ref: pwm.yaml#
        >>   >> +
        >>   >> +properties:
        >>   >> +  compatible:
        >>   >> +    enum:
        >>   >> +      - aspeed,ast2600-pwm
        >>   >> +
        >>   >> +  "#pwm-cells":
        >>   >> +    const: 3
        >>
        >>   > 3 cells? For one PWM? What are they?
        >>
        >> channel, period and polarity.

        > Don't cut my responses. You wrote you have one PWM output, so only one
        > channel. What do you put then in the channel?

You need to put 0 in the cell of the channel, the example of the dts usage will like following:

pwm0: pwm0 at 1e610000 {
        compatible = "aspeed,ast2600-pwm";
        reg = <0x1e610000 0x8>;
        #pwm-cells = <3>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_pwm0_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "okay";
};

pwm1: pwm1 at 1e610010 {
        compatible = "aspeed,ast2600-pwm";
        reg = <0x1e610010 0x8>;
        #pwm-cells = <3>;
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_pwm1_default>;
        clocks = <&syscon ASPEED_CLK_AHB>;
        resets = <&syscon ASPEED_RESET_PWM>;
        status = "okay";
};

fan0: pwm-fan0 {
        compatible = "pwm-fan";
        pwms = <&pwm0 0 40000 0>;            /* Target freq:25 kHz */
        cooling-min-state = <0>;
        cooling-max-state = <3>;
        #cooling-cells = <2>;
        cooling-levels = <0 15 128 255>;
};

fan1: pwm-fan1 {
        compatible = "pwm-fan";
        pwms = <&pwm1 0 40000 0>;            /* Target freq:25 kHz */
        cooling-min-state = <0>;
        cooling-max-state = <3>;
        #cooling-cells = <2>;
        cooling-levels = <0 15 128 255>;
};

        > I will start NAKing such patches without DTS user. It's like reviewing
        > fake code for some unknown solution and trying to get from you piece of
        > answers one by one, because you do not want to share entire part.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230608/91403601/attachment-0001.htm>
