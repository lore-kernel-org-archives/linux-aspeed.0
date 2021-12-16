From: Wolfram Sang <wsa@kernel.org>
Date: Thu, 16 Dec 2021 22:27:23 +0100
Subject: [PATCH] i2c: aspeed: Remove unused includes
In-Reply-To: <20211207141722.440213-1-thierry.reding@gmail.com>
References: <20211207141722.440213-1-thierry.reding@gmail.com>
Message-ID: <YbuvOyAfPyhHqBnJ@kunai>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 07, 2021 at 03:17:22PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> No symbols from the linux/irqchip/chained_irq.h and linux/irqdomain.h
> headers are used in the driver, so they can be removed.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211216/4c6576e0/attachment.sig>
