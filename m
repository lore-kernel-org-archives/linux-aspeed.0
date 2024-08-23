From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 23 Aug 2024 13:33:18 +0930
Subject: [PATCH -next 2/8] hwmon: (aspeed-pwm-tacho): Simplify with
 scoped for each OF child loop
In-Reply-To: <20240822062956.3490387-3-ruanjinjie@huawei.com>
References: <20240822062956.3490387-1-ruanjinjie@huawei.com>
	 <20240822062956.3490387-3-ruanjinjie@huawei.com>
Message-ID: <703d486dc1d268aaad03d916aef12a031473139c.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2024-08-22 at 14:29 +0800, Jinjie Ruan wrote:
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
