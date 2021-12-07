From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 7 Dec 2021 09:49:11 +0100
Subject: [PATCH] dt-bindings: i2c: aspeed: Drop stray '#interrupt-cells'
In-Reply-To: <20211206174237.2298580-1-robh@kernel.org>
References: <20211206174237.2298580-1-robh@kernel.org>
Message-ID: <Ya8gB4mu3yFYCbhp@orome.fritz.box>
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
> ---
>  Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml | 1 -
>  1 file changed, 1 deletion(-)

Interestingly I have a patch for this as well but it does the opposite
and adds interrupt-controller and #interrupt-cells. Upon closer
inspection I was tricked into this because the i2c-aspeed driver
includes linux/irqchip/chained_irq.h and linux/irqdomain.h and therefore
I assumed that it was indeed implementing an interrupt controller. But
none of the symbols in those files are ever used, so your version seems
to be correct.

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211207/233b17ff/attachment.sig>
