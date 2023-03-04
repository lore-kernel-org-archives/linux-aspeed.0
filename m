From: Tudor Ambarus <tudor.ambarus@gmail.com>
Date: Sat, 4 Mar 2023 07:59:16 +0200
Subject: [PATCH] spi: Replace `dummy.nbytes` with `dummy.ncycles`
In-Reply-To: <20220911174551.653599-1-sergiu.moga@microchip.com>
References: <20220911174551.653599-1-sergiu.moga@microchip.com>
Message-ID: <5bd48f09-f7ba-e5b3-60ba-49ecd1493e36@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

Sergiu changed his interests, I'm going to send a new version of this
patch. We really need the conversion in SPI NOR as there are flashes
that require a number of dummy cycles that is not multiple of 8.

Cheers,
ta
