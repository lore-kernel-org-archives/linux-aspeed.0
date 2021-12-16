From: Wolfram Sang <wsa@kernel.org>
Date: Thu, 16 Dec 2021 22:27:32 +0100
Subject: [PATCH] dt-bindings: i2c: aspeed: Drop stray '#interrupt-cells'
In-Reply-To: <20211206174237.2298580-1-robh@kernel.org>
References: <20211206174237.2298580-1-robh@kernel.org>
Message-ID: <YbuvRPcjRY5Y06vi@kunai>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 06, 2021 at 11:42:37AM -0600, Rob Herring wrote:
> '#interrupt-cells' is not documented which causes a warning when
> 'unevaluatedProperties' is implemented. Unless the I2C controller is
> also an interrupt controller, '#interrupt-cells' is not valid. This
> doesn't appear to be the case from the driver, so just remove it from
> the example.
> 
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Rayn Chen <rayn_chen@aspeedtech.com>
> Cc: linux-i2c at vger.kernel.org
> Cc: openbmc at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-aspeed at lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211216/6e4b8ea2/attachment.sig>
