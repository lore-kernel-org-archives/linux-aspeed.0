From: Mark Brown <broonie@kernel.org>
Date: Wed, 29 Jun 2022 18:09:42 +0100
Subject: [PATCH v3 2/2] spi: aspeed: Fix division by zero
In-Reply-To: <20220622161617.3719096-3-clg@kaod.org>
References: <20220622161617.3719096-1-clg@kaod.org>
 <20220622161617.3719096-3-clg@kaod.org>
Message-ID: <YryHVsrqNlhdwKzq@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jun 22, 2022 at 06:16:17PM +0200, C?dric Le Goater wrote:

> Fixes: 54613fc6659b ("spi: aspeed: Add support for direct mapping")

This commit isn't in mainline.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220629/b27fadbe/attachment.sig>
