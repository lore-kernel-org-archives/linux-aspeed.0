From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 8 Jun 2023 07:47:23 +0000
Subject: [v6 1/4] dt-bindings: pwm: Add ASPEED PWM Control documentation
In-Reply-To: <4dffd320-8e30-fb30-6ded-79519afddc21@linaro.org>
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
 <20230608021839.12769-2-billy_tsai@aspeedtech.com>
 <4dffd320-8e30-fb30-6ded-79519afddc21@linaro.org>
Message-ID: <SG2PR06MB3365DD80EA2FD026D400C4A78B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


  >> +
  >> +allOf:
  >> +  - $ref: pwm.yaml#
  >> +
  >> +properties:
  >> +  compatible:
  >> +    enum:
  >> +      - aspeed,ast2600-pwm
  >> +
  >> +  "#pwm-cells":
  >> +    const: 3

  > 3 cells? For one PWM? What are they?

channel, period and polarity.

  >> +
  >> +  clocks:
  >> +    maxItems: 1
  >> +
  >> +  resets:
  >> +    maxItems: 1
  >> +
  >> +required:
  >> +  - compatible
  >> +  - clocks
  >> +  - resets
  >> +
  >> +additionalProperties: false

  > Missing examples. All bindings need examples.

The examples will looks like following:

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
  status = "disabled";
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
  status = "disabled";
};
...

Thanks

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230608/1cd9195e/attachment-0001.htm>
