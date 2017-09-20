From: Joel Stanley <joel@jms.id.au>
Date: Wed, 20 Sep 2017 15:37:13 +0930
Subject: [PATCH v2 1/4] watchdog: aspeed: Retain watchdog enabled state
In-Reply-To: <20170920053020.6860-2-andrew@aj.id.au>
References: <20170920053020.6860-1-andrew@aj.id.au>
 <20170920053020.6860-2-andrew@aj.id.au>
Message-ID: <CACPK8XfK8voWhPoYg0kG-OhQoTH_B+=ES8BqbT26bdPYf39d1A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 20, 2017 at 3:00 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> An unintended post-condition of probe() is that the watchdog is
> disabled. This behaviour was introduced by an unnecessary write to the
> control register to configure the hardware based on the devicetree. The
> write is unnecessary because the cached control value that is
> manipulated by the code parsing the devicetree is eventually written by
> aspeed_wdt_enable(), which is when we care how the control register
> should be configured.
>
> Remove the write to restore expected behaviour.
>
> Fixes: b7f0b8ad25f3 ("drivers/watchdog: ASPEED reference dev tree properties for config")
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks,

Joel
