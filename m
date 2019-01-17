From: Joel Stanley <joel@jms.id.au>
Date: Thu, 17 Jan 2019 13:16:10 +1100
Subject: [PATCH] ARM: dts: aspeed: Add #interrupt-cells property to gpio
 controllers
In-Reply-To: <20181214120423.3363-1-mark.walton@serialtek.com>
References: <20181214120423.3363-1-mark.walton@serialtek.com>
Message-ID: <CACPK8Xdtt8-fFNpx9SjwVSyS8Zy-6h8020adRaz3ym5Xfpz7GA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 14 Dec 2018 at 23:07, Mark Walton <mark.walton@serialtek.com> wrote:
>
> Allows the GPIO controller to be used as an interrupt parent.
>
> of_irq_find_parent() skips interrupt controller nodes that do
> not have the #interrupt-cells property.
>
> Signed-off-by: Mark Walton <mark.walton@serialtek.com>

Thanks, applied to the aspeed tree for 5.1.

Cheers,

Joel
