From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 23 Aug 2024 13:32:00 +0930
Subject: [PATCH -next 1/8] hwmon: (aspeed-g6-pwm-tacho): Simplify with
 scoped for each OF child loop
In-Reply-To: <20240822062956.3490387-2-ruanjinjie@huawei.com>
References: <20240822062956.3490387-1-ruanjinjie@huawei.com>
	 <20240822062956.3490387-2-ruanjinjie@huawei.com>
Message-ID: <d3f26b403f8a281ed44c70bc04bbe42c4a9c29d3.camel@codeconstruct.com.au>
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
