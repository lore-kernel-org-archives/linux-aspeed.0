From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 22 Oct 2020 10:08:55 +1030
Subject: [PATCH] gpio: aspeed: fix ast2600 bank properties
In-Reply-To: <20201019045026.10732-1-billy_tsai@aspeedtech.com>
References: <20201019045026.10732-1-billy_tsai@aspeedtech.com>
Message-ID: <f56ce765-9d94-41b5-bda7-202c165ea8c9@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 19 Oct 2020, at 15:20, Billy Tsai wrote:
> GPIO_T is mapped to the most significant byte of input/output mask, and
> the byte in "output" mask should be 0 because GPIO_T is input only. All
> the other bits need to be 1 because GPIO_Q/R/S support both input and
> output modes.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Good catch, thanks Billy.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
