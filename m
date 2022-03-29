From: Mark Brown <broonie@kernel.org>
Date: Tue, 29 Mar 2022 11:49:59 +0100
Subject: [PATCH v4 03/11] spi: spi-mem: Convert Aspeed SMC driver to
 spi-mem
In-Reply-To: <db2f4ec0-dffb-805b-ec5a-24bf724e8ab5@kaod.org>
References: <db2f4ec0-dffb-805b-ec5a-24bf724e8ab5@kaod.org>
Message-ID: <YkLkV2mvHJ/EyVMn@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 29, 2022 at 10:56:49AM +0200, C?dric Le Goater wrote:

> This patchset was sent a bit early and commit 7f852ec58af6 ("mtd: aspeed-smc:
> improve probe resilience") was applied after which conflicts with the removal
> of the aspeed-smc.c file.

> Would you prefer a rebase and resend ? on -rc2 when the tree is stabilized ?

A rebase on -rc1 (assuming the change makes it in there) would be good.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220329/44c59a69/attachment-0001.sig>
