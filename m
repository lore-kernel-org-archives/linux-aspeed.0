From: Mark Brown <broonie@kernel.org>
Date: Thu, 16 May 2024 19:24:46 +0100
Subject: [PATCH v3 38/40] spi: fsi: Calculate clock divider from local
 bus frequency
In-Reply-To: <20240516181907.3468796-39-eajames@linux.ibm.com>
References: <20240516181907.3468796-1-eajames@linux.ibm.com>
 <20240516181907.3468796-39-eajames@linux.ibm.com>
Message-ID: <a3cf96f2-fa53-4f18-90f0-c21d6df5b2af@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 16, 2024 at 01:19:05PM -0500, Eddie James wrote:
> Use the new FSI device local bus clock to calculate the proper SPI
> clock divider.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240516/17513089/attachment.sig>
