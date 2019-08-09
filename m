From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 09 Aug 2019 10:08:45 +0930
Subject: [PATCH] mtd: spi-nor: aspeed-smc: Add of_node_put()
In-Reply-To: <20190808075104.15928-1-nishkadg.linux@gmail.com>
References: <20190808075104.15928-1-nishkadg.linux@gmail.com>
Message-ID: <7335d5d1-77c7-4cfe-9ba5-2fc81e3e69eb@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 8 Aug 2019, at 17:21, Nishka Dasgupta wrote:
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

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
