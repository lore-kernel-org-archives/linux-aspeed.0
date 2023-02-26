From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Sun, 26 Feb 2023 15:04:16 +0800
Subject: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
In-Reply-To: <20230226031321.3126756-2-ryan_chen@aspeedtech.com>
References: <20230226031321.3126756-1-ryan_chen@aspeedtech.com>
	 <20230226031321.3126756-2-ryan_chen@aspeedtech.com>
Message-ID: <8999ef4a57b035a81b086d8732d119638d46968c.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ryan,

> --- a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> @@ -49,6 +49,25 @@ properties:
> ???? description:
> ?????? states that there is another master active on this bus
> ?
> +? aspeed,timeout:
> +??? type: boolean
> +??? description: I2C bus timeout enable for master/slave mode
> +
> +? aspeed,xfer-mode:
> +??? description: |
> +????? I2C bus transfer mode selection.
> +????? - "byte": I2C bus byte transfer mode.
> +????? - "buffered": I2C bus buffer register transfer mode.
> +????? - "dma": I2C bus dma transfer mode (default)
> +??? items:
> +????? enum: [byte, buffered, dma]
> +??? maxItems: 1
> +??? $ref: /schemas/types.yaml#/definitions/non-unique-string-array

There are still unresolved questions about this xfer-mode property from
previous submissions of this binding. We don't yet have a justification
on why the mode configuration is needed in the device tree rather than
something that is specified in a driver implementation.

By now, I think we well understand what the modes are, and how a driver
implementation might configure them, but none of that has (so far)
provided sufficient rationale on why this belongs in the device tree.

The previous threads had a couple of pending discussions, following up on
those here:

A) You mentioned in [1] that the DMA controller is shared between all i3c
devices, does that have any consequence on which modes individual
devices might want to choose?

B) You implied in [2] that the different transfer modes might be related
to whether there are other masters present on the bus, but the logic
behind that is not clear.

C) In [3] you mentioned that there might be some DRAM savings by using a
particular mode.

and, most importantly:

D) unanswered from [4] and [5]: what are the hardware-specified reasons
why a DT author would chose one mode over another?

If you can write this out in some format like:

 - in hardware situation X, you should use DMA mode
 - in hardware situation Y, you should use byte mode
 - [...]

that might help us to understand where this configuration belongs, or
what a reasonable DT representation should look like, or even if
existing DT schema can already provide the information required to
decide.

Cheers,


Jeremy

[1]: https://lists.ozlabs.org/pipermail/linux-aspeed/2023-February/009876.html
[2]: https://lists.ozlabs.org/pipermail/linux-aspeed/2023-February/009892.html
[3]: https://lists.ozlabs.org/pipermail/linux-aspeed/2023-February/009880.html
[4]: https://lists.ozlabs.org/pipermail/linux-aspeed/2023-February/009871.html
[5]: https://lists.ozlabs.org/pipermail/linux-aspeed/2023-February/009884.html
