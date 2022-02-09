From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 09 Feb 2022 15:45:57 +1030
Subject: [PATCH net] net: mdio: aspeed: Add missing MODULE_DEVICE_TABLE
In-Reply-To: <20220209000359.372978-1-joel@jms.id.au>
References: <20220209000359.372978-1-joel@jms.id.au>
Message-ID: <8748d41d-ac5a-451a-b38b-6ec0fc2bcb99@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 9 Feb 2022, at 10:33, Joel Stanley wrote:
> Fix loading of the driver when built as a module.
>
> Fixes: f160e99462c6 ("net: phy: Add mdio-aspeed")
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
