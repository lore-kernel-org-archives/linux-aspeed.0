From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 1 Dec 2021 10:38:04 +0000
Subject: [PATCH v4 02/13] dt-bindings: Add bindings for peci-aspeed
In-Reply-To: <20211123140706.2945700-3-iwona.winiarska@intel.com>
References: <20211123140706.2945700-1-iwona.winiarska@intel.com>
 <20211123140706.2945700-3-iwona.winiarska@intel.com>
Message-ID: <DDB2E224-472B-41CC-A5C6-BEADB4BF2041@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

On 2021/11/23, 10:10 PM, "openbmc on behalf of Iwona Winiarska" <openbmc-bounces+billy_tsai=aspeedtech.com at lists.ozlabs.org on behalf of iwona.winiarska@intel.com> wrote:

    Add device tree bindings for the peci-aspeed controller driver.

    >   +  aspeed,clock-divider:
    >   +    description:
    >   +      This value determines PECI controller internal clock dividing
    >   +      rate. The divider will be calculated as 2 raised to the power of
    >   +      the given value.
    >   +    $ref: /schemas/types.yaml#/definitions/uint32
    >   +    minimum: 0
    >   +    maximum: 7
    >   +    default: 0
    >   +
    >   +  aspeed,msg-timing:
    >   +    description:
    >   +      Message timing negotiation period. This value will determine the period
    >   +      of message timing negotiation to be issued by PECI controller. The unit
    >   +      of the programmed value is four times of PECI clock period.
    >   +    $ref: /schemas/types.yaml#/definitions/uint32
    >   +    minimum: 0
    >   +    maximum: 255
    >   +    default: 1
    >   +
    >   +  aspeed,addr-timing:
    >   +    description:
    >   +      Address timing negotiation period. This value will determine the period
    >   +      of address timing negotiation to be issued by PECI controller. The unit
    >   +      of the programmed value is four times of PECI clock period.
    >   +    $ref: /schemas/types.yaml#/definitions/uint32
    >   +    minimum: 0
    >   +    maximum: 255
    >   +    default: 1
I suggest deleting these three properties and replacing them with the following

aspeed,peci-bit-time:
        description:
          The bit time driven by PECI controller. The unit of the value is Hz.
    minimum: 2000
    maximum: 1000000

And the driver should use this property to caculate the appropriate clock-divider,
msg-timing and addr-timing, instead of exposing hardware registers to dts.

    >    [...]
    >   +examples:
    >   +  - |
    >   +    #include <dt-bindings/interrupt-controller/arm-gic.h>
    >   +    #include <dt-bindings/clock/ast2600-clock.h>
    >   +    peci-controller at 1e78b000 {
    >   +      compatible = "aspeed,ast2600-peci";
    >   +      reg = <0x1e78b000 0x100>;
    >   +      interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
    >   +      clocks = <&syscon ASPEED_CLK_GATE_REF0CLK>;
    >   +      resets = <&syscon ASPEED_RESET_PECI>;
    >   +      cmd-timeout-ms = <1000>;
    >   +      aspeed,clock-divider = <0>;
    >   +      aspeed,msg-timing = <1>;
    >   +      aspeed,addr-timing = <1>;
    >   +      aspeed,rd-sampling-point = <8>;
    >   +    };
    >   +...
    -- 
    2.31.1

Thanks

Best Regards,
Billy Tsai



