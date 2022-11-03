From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 3 Nov 2022 10:36:33 +0000
Subject: [PATCH 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
In-Reply-To: <ee6c5a96-81c4-5729-f623-4b23bc3b8e0a@kernel.org>
References: <20221031103809.20225-1-billy_tsai@aspeedtech.com>
 <20221031103809.20225-2-billy_tsai@aspeedtech.com>
 <ee6c5a96-81c4-5729-f623-4b23bc3b8e0a@kernel.org>
Message-ID: <2508B515-E153-42C2-B013-2A64A110BCF2@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 2022/11/3, 5:20 AM, "Krzysztof Kozlowski" <krzk@kernel.org> wrote:

    On 31/10/2022 06:38, Billy Tsai wrote:
    > > +patternProperties:
    > > +  "^pwm(@[0-9a-f]+)?$":
    > > +    $ref: ../pwm/aspeed,ast2600-pwm.yaml

    > Full path, so: /schemas/pwm/aspeed,ast2600-pwm.yaml

    > Why unit addresses are optional?

    > > +
    > > +  "^tach(@[0-9a-f]+)?$":
    > > +    $ref: ../hwmon/aspeed,ast2600-tach.yaml

    > Ditto

    > Why unit addresses are optional?

The pwm_tach is not the bus. I will use
pwm:
    type: object
    $ref: "/schemas/pwm/aspeed,ast2600-pwm.yaml"

tach:
    type: object
    $ref: "/schemas/hwmon/aspeed,ast2600-tach.yaml"
to replace it.

    > > +
    > > +additionalProperties: false
    > > +
    > > +examples:
    > > +  - |
    > > +    #include <dt-bindings/clock/ast2600-clock.h>
    > > +    pwm_tach: pwm_tach at 1e610000 {

    > Node names should be generic.
    > https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

This is the mfd with pwm and tach, so they are combined as the node name.

    > No underscores in node names.

https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#table-1
I see that the underscore is the valid characters for node names.
Did I miss any information?

Thanks

Best Regards,
Billy Tsai

