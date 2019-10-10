From: Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Oct 2019 23:44:06 +0000
Subject: [PATCH v2 3/3] net: ftgmac100: Ungate RCLK for RMII on ASPEED MACs
In-Reply-To: <20191010020756.4198-4-andrew@aj.id.au>
References: <20191010020756.4198-1-andrew@aj.id.au>
 <20191010020756.4198-4-andrew@aj.id.au>
Message-ID: <CACPK8Xf8rEwCiDe1b+FgHQPscJYXuwKFzfrP1vmFeYde=uawyA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2019 at 02:07, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The 50MHz RCLK has to be enabled before the RMII interface will function.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>
