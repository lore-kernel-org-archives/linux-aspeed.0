From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 8 Jun 2023 10:36:36 +0200
Subject: [v6 1/4] dt-bindings: pwm: Add ASPEED PWM Control documentation
In-Reply-To: <SG2PR06MB336528007D2685F8D95DF4078B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
 <20230608021839.12769-2-billy_tsai@aspeedtech.com>
 <4dffd320-8e30-fb30-6ded-79519afddc21@linaro.org>
 <SG2PR06MB3365DD80EA2FD026D400C4A78B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
 <61278e12-ba39-4503-ca74-a7118b0f6e99@linaro.org>
 <SG2PR06MB336528007D2685F8D95DF4078B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
Message-ID: <9f8a9208-62d4-0c96-7d1c-a452d3d7e799@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/06/2023 10:21, Billy Tsai wrote:
>         On 08/06/2023 09:47, Billy Tsai wrote:
>         >>
>         >>   >> +
>         >>   >> +allOf:
>         >>   >> +  - $ref: pwm.yaml#
>         >>   >> +
>         >>   >> +properties:
>         >>   >> +  compatible:
>         >>   >> +    enum:
>         >>   >> +      - aspeed,ast2600-pwm
>         >>   >> +
>         >>   >> +  "#pwm-cells":
>         >>   >> +    const: 3
>         >>
>         >>   > 3 cells? For one PWM? What are they?
>         >>
>         >> channel, period and polarity.
> 
>         > Don't cut my responses. You wrote you have one PWM output, so only one
>         > channel. What do you put then in the channel?
> 
> You need to put 0 in the cell of the channel, the example of the dts usage will like following:

If you always put 0 isn't this a proof that it's wrong?



Best regards,
Krzysztof

