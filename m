From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 16 Jan 2024 03:09:59 +0000
Subject: [PATCH v12 1/3] dt-bindings: hwmon: fan: Add fan binding to
 schema
In-Reply-To: <54929342-7e06-4e39-a7e9-e5dc787406ce@linaro.org>
References: <20240108074348.735014-1-billy_tsai@aspeedtech.com>
 <20240108074348.735014-2-billy_tsai@aspeedtech.com>
 <54929342-7e06-4e39-a7e9-e5dc787406ce@linaro.org>
Message-ID: <OSQPR06MB72520F546A22DE55532A33E78B732@OSQPR06MB7252.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > +  pwms:
> > +    description:
> > +      PWM provider.
> > +    maxItems: 1
> > +
> > +  "#cooling-cells":
> > +    const: 2
> > +
> > +  cooling-levels:
> > +    description:
> > +      The control value which correspond to thermal cooling states.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +
> > +  tach-ch:
> > +    description:
> > +      The tach channel used for the fan.
> > +    $ref: /schemas/types.yaml#/definitions/uint8-array

> What is the tach-channel and why is it different from pwm specifier?

Hi Krzysztof,

Using the Aspeed SoC as an example, our SoC features 16 PWMs and 16 tachometer channels that can be employed to control and monitor fans.
The "tach-ch" parameter is utilized to specify which tachometer channel is being used to monitor a specific fan.
The "pwms" parameter is utilized to specify which pwm channel is being used to control a specific fan.

Thanks
Best regards,
Billy Tsai
