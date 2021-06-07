From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 08 Jun 2021 09:18:52 +0930
Subject: [PATCH v4 5/7] gpio: gpio-aspeed-sgpio: Add set_config function
In-Reply-To: <20210607071514.11727-6-steven_lee@aspeedtech.com>
References: <20210607071514.11727-1-steven_lee@aspeedtech.com>
 <20210607071514.11727-6-steven_lee@aspeedtech.com>
Message-ID: <27d1ae78-a58c-4e40-b844-2bbd4bda15f4@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 7 Jun 2021, at 16:45, Steven Lee wrote:
> AST SoC supports *retain pin state* function when wdt reset.
> The patch adds set_config function for handling sgpio reset tolerance
> register.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
