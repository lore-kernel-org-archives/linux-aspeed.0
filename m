From: Conor Dooley <conor@kernel.org>
Date: Wed, 14 Feb 2024 18:31:01 +0000
Subject: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [PATCH] Add eSPI device
 driver (flash channel)
In-Reply-To: <KL1PR06MB665234A65DB334B3BDF6AFA6914E2@KL1PR06MB6652.apcprd06.prod.outlook.com>
References: <20240213-espi_driver-v1-1-92741c812843@gmail.com>
 <KL1PR06MB665234A65DB334B3BDF6AFA6914E2@KL1PR06MB6652.apcprd06.prod.outlook.com>
Message-ID: <20240214-yoyo-platinum-dcd0e7e16a22@spud>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 14, 2024 at 11:34:31AM +0000, ChiaWei Wang wrote:
> We appreciate that you are willing to help on the open source contribution. 
> However, please co-work with Aspeed before submitting drivers of Aspeed HW.
> Otherwise, a misleading driver on the community are going to bring tons of customer issues to Aspeed.

It may not apply in this particular case as Aspeed did write the
original driver and it is polite to work with previous authors
when respinning a patchset, but in general there is no need to work
with a hardware vendor before writing drivers for their hardware.

Blocking a driver because that company might receive more support
requests is not the kernel's problem.

Cheers,
Conor.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240214/b0863e96/attachment-0001.sig>
