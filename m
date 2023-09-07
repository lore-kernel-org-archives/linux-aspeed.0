From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 7 Sep 2023 07:24:56 +0000
Subject: [PATCH v8 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
In-Reply-To: <20230905170735.GA3528724-robh@kernel.org>
References: <20230830123202.3408318-1-billy_tsai@aspeedtech.com>
 <20230830123202.3408318-3-billy_tsai@aspeedtech.com>
 <20230905170735.GA3528724-robh@kernel.org>
Message-ID: <SG2PR06MB3365982279825C98859FF1768BEEA@SG2PR06MB3365.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/aspeed-clock.h>
>> +    pwm_tach: pwm-tach-controller at 1e610000 {
>> +      compatible = "aspeed,ast2600-pwm-tach";
>> +      reg = <0x1e610000 0x100>;
>> +      clocks = <&syscon ASPEED_CLK_AHB>;
>> +      resets = <&syscon ASPEED_RESET_PWM>;
>> +      #pwm-cells = <3>;

> Blank line.

>> +      fan0_hwmon {
>> +        tach-ch = <0x0>;

> Don't you need 'pwms'?

Yes, I only want to create the fan monitor without fan control.

> +      };
