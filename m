From: Mark Brown <broonie@kernel.org>
Date: Wed, 29 Jun 2022 18:27:43 +0100
Subject: [PATCH v3 2/2] spi: aspeed: Fix division by zero
In-Reply-To: <59b82730-f09f-f7e5-0e2f-4ad1765f0f6e@kaod.org>
References: <20220622161617.3719096-1-clg@kaod.org>
 <20220622161617.3719096-3-clg@kaod.org>
 <YryHVsrqNlhdwKzq@sirena.org.uk>
 <59b82730-f09f-f7e5-0e2f-4ad1765f0f6e@kaod.org>
Message-ID: <YryLj6iWVkqWowDg@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jun 29, 2022 at 07:21:08PM +0200, C?dric Le Goater wrote:
> On 6/29/22 19:09, Mark Brown wrote:
> > On Wed, Jun 22, 2022 at 06:16:17PM +0200, C?dric Le Goater wrote:
> > 
> > > Fixes: 54613fc6659b ("spi: aspeed: Add support for direct mapping")
> > 
> > This commit isn't in mainline.

> drat. It's the OpenBMC kernel. I will resend. Sorry about that.

It's OK, I fixed it up locally.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 484 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220629/32b9a265/attachment.sig>
