From: Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Oct 2019 23:41:35 +0000
Subject: [PATCH v2 2/2] clk: aspeed: Add RMII RCLK gates for both AST2500
 MACs
In-Reply-To: <20191010020655.3776-3-andrew@aj.id.au>
References: <20191010020655.3776-1-andrew@aj.id.au>
 <20191010020655.3776-3-andrew@aj.id.au>
Message-ID: <CACPK8Xcrc_2itUcGw6caa8Fp3sJE8oHBO5LJgBtqScwmVAuHJw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2019 at 02:06, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> RCLK is a fixed 50MHz clock derived from HPLL that is described by a
> single gate for each MAC.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>
