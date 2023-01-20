From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 20 Jan 2023 12:54:24 +1030
Subject: [PATCH] pinctrl: aspeed: Fix confusing types in return value
In-Reply-To: <20230119231856.52014-1-joel@jms.id.au>
References: <20230119231856.52014-1-joel@jms.id.au>
Message-ID: <0f530b87-5c3e-47e1-b097-fff9bcf39955@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 20 Jan 2023, at 09:48, Joel Stanley wrote:
> The function signature is int, but we return a bool. Instead return a
> negative errno as the kerneldoc suggests.
>
> Fixes: 4d3d0e4272d8 ("pinctrl: Add core support for Aspeed SoCs")
> Signed-off-by: Joel Stanley <joel@jms.id.au>

:facepalm:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
