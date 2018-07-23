From: Joel Stanley <joel@jms.id.au>
Date: Mon, 23 Jul 2018 21:42:18 +0930
Subject: [PATCH 1/4] mtd: spi-nor: aspeed: use command mode for reads
In-Reply-To: <20180622121417.6762-2-clg@kaod.org>
References: <20180622121417.6762-1-clg@kaod.org>
 <20180622121417.6762-2-clg@kaod.org>
Message-ID: <CACPK8Xf-XfxMVMewC5T6u1XzDX3idqk+FeGRLMC+xrKDqtWggg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 22 June 2018 at 21:44, C?dric Le Goater <clg@kaod.org> wrote:
> When reading flash contents, try to use the "command mode" if the AHB
> window configured for the flash module is big enough. Else, just fall
> back to the "user mode" to perform the read.
>
> Signed-off-by: C?dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
