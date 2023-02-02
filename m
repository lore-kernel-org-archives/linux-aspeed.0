From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu, 02 Feb 2023 12:25:26 +0800
Subject: [PATCH v4 1/3] dt-bindings: i2c-ast2600: Add support for
 AST2600 I2C global controller
In-Reply-To: <20230201103359.1742140-2-ryan_chen@aspeedtech.com>
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
	 <20230201103359.1742140-2-ryan_chen@aspeedtech.com>
Message-ID: <c227fa62c1040c7c280f1a6559dcf4cf8fb40428.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ryan,

> AST2600 I2C global register controller, add bindings document
> to support driver of i2c global register set.

[...]

> +allOf:
> +? - $ref: /schemas/i2c/i2c-controller.yaml#

Are you sure about this? This particular binding doesn't describe the
i2c controller.

> +
> +properties:
> +? compatible:
> +??? enum:
> +????? - aspeed,ast2600-i2c-global
> +
> +? reg:
> +??? minItems: 1
> +??? items:
> +????? - description: address offset and range of bus
> +????? - description: address offset and range of bus buffer

Seems to be a duplicate here.

Cheers,


Jeremy
