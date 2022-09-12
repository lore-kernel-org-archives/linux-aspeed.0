From: Mark Brown <broonie@kernel.org>
Date: Mon, 12 Sep 2022 12:52:41 +0100
Subject: [PATCH] spi: Replace `dummy.nbytes` with `dummy.ncycles`
In-Reply-To: <20220911174551.653599-1-sergiu.moga@microchip.com>
References: <20220911174551.653599-1-sergiu.moga@microchip.com>
Message-ID: <Yx8didL1aFc4XxGa@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Sep 11, 2022 at 08:45:53PM +0300, Sergiu Moga wrote:
> In order to properly represent the hardware functionality
> in the core, avoid reconverting the number of dummy cycles
> to the number of bytes and only work with the former.
> Instead, let the drivers that do need this conversion do
> it themselves.

Acked-by: Mark Brown <broonie@kernel.org>

If this gets applied it might be good to have a tag in case we
need it for any SPI updates.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220912/41a68ef6/attachment-0001.sig>
