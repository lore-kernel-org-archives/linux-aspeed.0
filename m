From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Wed, 28 Aug 2019 10:20:11 +0000
Subject: [PATCH] mtd: spi-nor: aspeed-smc: Add of_node_put()
In-Reply-To: <20190808075104.15928-1-nishkadg.linux@gmail.com>
References: <20190808075104.15928-1-nishkadg.linux@gmail.com>
Message-ID: <96475f82-066c-ff67-3ea9-1fec64eef021@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 08/08/2019 10:51 AM, Nishka Dasgupta wrote:
> External E-Mail
> 
> 
> Each iteration of for_each_available_child_of_node puts the previous
> node, but in the case of a break from the middle of the loop, there is
> no put, thus causing a memory leak. Upon termination of the loop
> (whether by break or a natural exit), either ret will have a non-zero
> value or child will be NULL. Hence add an of_node_put() that will
> execute only when ret has a non-zero value, as calling of_node_put() on
> a possible NULL value does not cause any further issues.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/mtd/spi-nor/aspeed-smc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch.

Thanks,
ta
