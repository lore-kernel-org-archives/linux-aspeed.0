From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 20 Feb 2023 16:28:47 +0800
Subject: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
In-Reply-To: <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
	 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
Message-ID: <2141e513acc750bf26775f5b435f4dccd41244aa.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ryan,

> AST2600 support new register set for I2Cv2 controller, add bindings
> document to support driver of i2cv2 new register mode controller.

Some comments inline:

> +? clock-frequency:
> +??? description:
> +????? Desired I2C bus clock frequency in Hz. default 100khz.
> +
> +? multi-master:
> +??? type: boolean
> +??? description:
> +????? states that there is another master active on this bus

These are common to all i2c controllers, but I see that
i2c-controller.yaml doesn't include them (while i2c.text does).

I assume we're OK to include these in the device bindings in the
meantime. But in that case, you may also want to include the common
"smbus-alert" property, which you consume in your driver.

> +? timeout:
> +??? type: boolean
> +??? description: Enable i2c bus timeout for master/slave (35ms)
> +
> +? byte-mode:
> +??? type: boolean
> +??? description: Force i2c driver use byte mode transmit
> +
> +? buff-mode:
> +??? type: boolean
> +??? description: Force i2c driver use buffer mode transmit

These three aren't really a property of the hardware, more of the
intended driver configuration. Do they really belong in the DT?

[and how would a DT author know which modes to choose?]

> +? aspeed,gr:
> +??? $ref: /schemas/types.yaml#/definitions/phandle
> +??? description: The phandle of i2c global register node.

We'll probably want this to be consistent with other instances of aspeed
global register references. I've used "aspeed,global-regs" in the
proposed i3c binding:

  https://lore.kernel.org/linux-devicetree/cover.1676532146.git.jk at codeconstruct.com.au/T/#mda2d005f77ca0c481b1f1edadb58fc1b007a5cc3

I'd argue that "global-regs" is a little more clear, but I'm okay with
either way - that change has been Acked but not been merged yet.
Whichever we choose though, it should be consistent.

Cheers,


Jeremy
