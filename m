From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 9 Dec 2022 00:54:13 +0000
Subject: [v4 1/5] dt-bindings: mfd: Add aspeed pwm-tach binding
In-Reply-To: <27055c13-11ab-cc73-f2ba-c269785b0e28@linaro.org>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-2-billy_tsai@aspeedtech.com>
 <c4b188b1-06a4-3cb0-a758-e12942e1f67b@linaro.org>
 <27055c13-11ab-cc73-f2ba-c269785b0e28@linaro.org>
Message-ID: <A5EA19E5-21D8-4954-9636-9B28AC8D946A@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2022/11/23, 4:27 PM, "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org> wrote:

    On 23/11/2022 09:24, Krzysztof Kozlowski wrote:
    > > On 23/11/2022 07:16, Billy Tsai wrote:
    > >> Add device binding for aspeed pwm-tach device which is a multi-function
    > >> device include pwm and tach function.
    > > 
    > > Subject: drop second, redundant "bindings".
    > > Also use proper PATCH prefix.
    > > 
    > >>
    > >> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
    > >> ---
    > >>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 73 +++++++++++++++++++
    > >>  1 file changed, 73 insertions(+)
    > >>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
    > >>
    > >> diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
    > >> new file mode 100644
    > >> index 000000000000..e2a7be2e0a18
    > >> --- /dev/null
    > >> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
    > >> @@ -0,0 +1,73 @@
    > >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
    > >> +# Copyright (C) 2021 Aspeed, Inc.
    > >> +%YAML 1.2
    > >> +---
    > >> +$id: http://devicetree.org/schemas/mfd/aspeed,ast2600-pwm-tach.yaml#
    > >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
    > >> +
    > >> +title: PWM Tach controller
    > >> +
    > >> +description: |
    > >> +  The PWM Tach controller is represented as a multi-function device which
    > >> +  includes:
    > >> +    PWM
    > >> +    Tach
    > >> +
    > >> +maintainers:
    > >> +  - Billy Tsai <billy_tsai@aspeedtech.com>
    > >> +
    > >> +properties:
    > >> +  compatible:
    > >> +    items:
    > >> +      - enum:
    > >> +          - aspeed,ast2600-pwm-tach
    > >> +      - const: syscon
    > >> +      - const: simple-mfd
    > >> +
    > >> +  reg:
    > >> +    maxItems: 1
    > >> +
    > >> +  clocks:
    > >> +    maxItems: 1
    > >> +
    > >> +  resets:
    > >> +    maxItems: 1
    > > 
    > > If this is simple-mfd then it cannot take clocks or resets.  Usually the
    > > recommendation for such case is: This is not simple-mfd, drop it. Drop
    > > also syscon and make a proper device.
    > > 
    > > However I am surprised to see such change, so I have no clue why this
    > > was done.

    > Actually now I see it was like that in previous patch, I just missed it
    > during previous review. Anyway this must be fixed.

I have two module (PWM and TACH) but share with the same base address,
The PWM will use the offset (N*0x10) + 0x0 and 0x04.
The TACH will use the offset (N*0x10) + 0x8 and 0x0c.
The range of the N is 0~15.
Can you give me some advice to fix this problem without using simple-mfd?

Thanks

Best Regards,
Billy Tsai


