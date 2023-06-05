From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Mon, 5 Jun 2023 09:54:53 +0200
Subject: [PATCH 00/89] i2c: Convert to platform remove callback returning
 void
In-Reply-To: <ZHijKtBbH2sCSuT4@shikoro>
References: <20230508205306.1474415-1-u.kleine-koenig@pengutronix.de>
 <20230601073322.ww25ajaurktqsryr@pengutronix.de>
 <ZHijKtBbH2sCSuT4@shikoro>
Message-ID: <ZH2UzYLPEQay3MBT@shikoro>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jun 01, 2023 at 03:54:50PM +0200, Wolfram Sang wrote:
> 
> > I wonder how this series will go in. My expectation was that Wolfram
> > picks up the whole series via his tree?!
> 
> Will do. I am currently super-busy, though.

Whole series applied to for-next. I squashed all the commits into one.
These are mostly simple changes which we won't revert anyhow, but fix
incrementally if we ever find an issue.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230605/1d0e58f6/attachment-0001.sig>
