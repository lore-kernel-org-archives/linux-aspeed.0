From: Joel Stanley <joel@jms.id.au>
Date: Mon, 23 Jul 2018 21:42:59 +0930
Subject: [PATCH 2/4] mtd: spi-nor: aspeed: add support for SPI dual IO
 read mode
In-Reply-To: <20180622121417.6762-3-clg@kaod.org>
References: <20180622121417.6762-1-clg@kaod.org>
 <20180622121417.6762-3-clg@kaod.org>
Message-ID: <CACPK8XcwxQWppks5CsKhEHPC_jk+NQXcYZz3UNgZxOEEpnsLyg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 22 June 2018 at 21:44, C?dric Le Goater <clg@kaod.org> wrote:
> Implements support for the dual IO read mode on aspeed SMC/FMC
> controllers which uses both MISO and MOSI lines for data during a read
> to double the read bandwidth.
>
> Still to be done SNOR_PROTO_1_2_2
>
> Based on work from Robert Lippert <roblip@gmail.com>
>
> Signed-off-by: C?dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
