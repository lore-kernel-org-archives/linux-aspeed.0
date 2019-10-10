From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 10 Oct 2019 09:16:54 +0200
Subject: [PATCH v2 07/22] mtd: spi-nor: Rework read_cr()
In-Reply-To: <20190924074533.6618-8-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
 <20190924074533.6618-8-tudor.ambarus@microchip.com>
Message-ID: <20191010091648.10d9a993@dhcp-172-31-174-146.wireless.concordia.ca>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <20191010071654.rVJpvgHaJ_Vzjoy5mcuQiGBT8-uYHxEFmlO9--orTPk@z>

On Tue, 24 Sep 2019 07:46:15 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> static int read_cr(struct spi_nor *nor)
> becomes
> static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
> 
> The new function returns 0 on success and -errno otherwise.
> We let the callers pass the pointer to the buffer where the
> value of the Configuration Register will be written. This way
> we avoid the casts between int and u8, which can be confusing.
> 
> Prepend spi_nor_ to the function name, all functions should begin
> with that.
> 

Same as for patch 5, this should be split in several patches.

> Vendors are using both the "Configuration Register" and the
> "Status Register 2" terminology when referring to the second byte
> of the Status Register. Indicate in the description of the function
> that we use the SPINOR_OP_RDCR (35h) command to interrogate the

						  ^query

> Configuration Register.
> 
