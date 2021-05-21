From: Joel Stanley <joel@jms.id.au>
Date: Fri, 21 May 2021 01:03:38 +0000
Subject: [PATCH v4 2/3] ARM: dts: aspeed: ast2600evb: Add phase correction
 for emmc controller.
In-Reply-To: <20210520101346.16772-3-steven_lee@aspeedtech.com>
References: <20210520101346.16772-1-steven_lee@aspeedtech.com>
 <20210520101346.16772-3-steven_lee@aspeedtech.com>
Message-ID: <CACPK8Xfw8UH-4-oVqcFFMQmfrLqDbdYuACT9Rij62SBLU0+56Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 20 May 2021 at 10:16, Steven Lee <steven_lee@aspeedtech.com> wrote:
>
> Set MMC timing-phase register by adding the phase correction binding in the
> device tree.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Acked-by: Andrew Jeffery <andrew@aj.id.au>

As the aspeed maintainer:

Reviewed-by: Joel Stanley <joel@jms.id.au>

I don't mind if this gets applied directly by the mmc maintainers (I
do not anticpiate any conflicts).

Cheers,

Joel
