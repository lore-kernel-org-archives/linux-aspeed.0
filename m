From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 8 Jun 2023 11:27:46 +0200
Subject: [v6 1/4] dt-bindings: pwm: Add ASPEED PWM Control documentation
In-Reply-To: <SG2PR06MB3365558F9A3127744CEF1C068B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
 <20230608021839.12769-2-billy_tsai@aspeedtech.com>
 <4dffd320-8e30-fb30-6ded-79519afddc21@linaro.org>
 <SG2PR06MB3365DD80EA2FD026D400C4A78B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
 <61278e12-ba39-4503-ca74-a7118b0f6e99@linaro.org>
 <SG2PR06MB336528007D2685F8D95DF4078B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
 <fb3cb26b-61d7-5f57-41de-f419aa50ac0b@linaro.org>
 <SG2PR06MB3365558F9A3127744CEF1C068B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
Message-ID: <5b5ccfb9-d6ea-9f22-bc8f-c048da726cc9@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/06/2023 11:15, Billy Tsai wrote:
> On 08/06/2023 10:21, Billy Tsai wrote:
>         >>         On 08/06/2023 09:47, Billy Tsai wrote:
>         >>         >>
>         >>         >>   >> +
>         >>         >>   >> +allOf:
>         >>         >>   >> +  - $ref: pwm.yaml#
>         >>         >>   >> +
>         >>         >>   >> +properties:
>         >>         >>   >> +  compatible:
>         >>         >>   >> +    enum:
>         >>         >>   >> +      - aspeed,ast2600-pwm
>         >>         >>   >> +
>         >>         >>   >> +  "#pwm-cells":
>         >>         >>   >> +    const: 3
>         >>         >>
>         >>         >>   > 3 cells? For one PWM? What are they?
>         >>         >>
>         >>         >> channel, period and polarity.
>         >>
>         >>         > Don't cut my responses. You wrote you have one PWM output, so only one
>         >>         > channel. What do you put then in the channel?
>         >>
>         >> You need to put 0 in the cell of the channel, the example of the dts usage will like following:
>         >>
>         >> pwm0: pwm0 at 1e610000 {
>         >>         compatible = "aspeed,ast2600-pwm";
>         >>         reg = <0x1e610000 0x8>;
>         >>         #pwm-cells = <3>;
>         >>         #address-cells = <1>;
>         >>         #size-cells = <0>;
>         >>         pinctrl-names = "default";
>         >>         pinctrl-0 = <&pinctrl_pwm0_default>;
>         >>         clocks = <&syscon ASPEED_CLK_AHB>;
>         >>         resets = <&syscon ASPEED_RESET_PWM>;
>         >>         status = "okay";
>         >> };
>         >>
>         >> pwm1: pwm1 at 1e610010 {
>         >>         compatible = "aspeed,ast2600-pwm";
>         >>         reg = <0x1e610010 0x8>;
>         >>         #pwm-cells = <3>;
>         >>         #address-cells = <1>;
>         >>         #size-cells = <0>;
>         >>         pinctrl-names = "default";
>         >>         pinctrl-0 = <&pinctrl_pwm1_default>;
>         >>         clocks = <&syscon ASPEED_CLK_AHB>;
>         >>         resets = <&syscon ASPEED_RESET_PWM>;
>         >>         status = "okay";
> 
>         > BTW, these are not two PWM devices but one. I don't understand why you
>         > changed previous design into something like this, but this is not
>         > representing your hardware.
> 
> The previous design of my patch treated our PWM controller as having 16 PWM channels.
> However, from a hardware perspective, it consists of 16 individual PWM chips, each
> with its own set of two 4-byte control registers. These chips operate independently
> and are not affected by each other.

They are affected by each other - you use the same clock and reset line.
I really doubt you have 16 PWM controllers. Anyway, I cannot judge.
Either your previous submissions were totally bogus or this one is.

Best regards,
Krzysztof

