From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Nov 2021 16:31:27 +0000
Subject: [PATCH/RFC 14/17] regulator: ti-abb: Use bitfield helpers
In-Reply-To: <c8508cae36c52c750dbb12493dd44d92fcf51ad4.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <c8508cae36c52c750dbb12493dd44d92fcf51ad4.1637592133.git.geert+renesas@glider.be>
Message-ID: <YZvF3yh9XnTcaXe9@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 22, 2021 at 04:54:07PM +0100, Geert Uytterhoeven wrote:
> Use the field_{get,prep}() helpers, instead of open-coding the same
> operations.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211122/773be379/attachment-0001.sig>
