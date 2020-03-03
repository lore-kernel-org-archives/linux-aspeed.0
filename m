From: Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Tue, 3 Mar 2020 12:22:22 +0200
Subject: [PATCH 12/23] mtd: spi-nor: Move Intel bits out of core.c
In-Reply-To: <20200302180730.1886678-13-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
 <20200302180730.1886678-13-tudor.ambarus@microchip.com>
Message-ID: <20200303102222.GL2540@lahna.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 02, 2020 at 06:07:51PM +0000, Tudor.Ambarus at microchip.com wrote:
> From: Boris Brezillon <bbrezillon@kernel.org>
> 
> Create a SPI NOR manufacturer driver for Intel chips, and move the
> Intel definitions outside of core.c.
> 
> Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
