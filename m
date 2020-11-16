From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 16 Nov 2020 14:40:55 +1030
Subject: =?UTF-8?Q?Re:_[PATCH]_soc:_aspeed:_Fix_a_reference_leak_in_aspeed=5Fsoci?=
 =?UTF-8?Q?nfo=5Finit()?=
In-Reply-To: <20201113100850.GA168908@mwanda>
References: <20201113100850.GA168908@mwanda>
Message-ID: <07558590-438a-4347-820e-c117b19dac20@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 13 Nov 2020, at 20:38, Dan Carpenter wrote:
> This needs to call of_node_put(np) before returning if of_iomap() fails.
> 
> Fixes: e0218dca5787 ("soc: aspeed: Add soc info driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
