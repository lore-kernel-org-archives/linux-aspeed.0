From: Joel Stanley <joel@jms.id.au>
Date: Mon, 23 Jul 2018 21:43:46 +0930
Subject: [PATCH 3/4] mtd: spi-nor: aspeed: retrieve the ABH clock frequency
In-Reply-To: <20180622121417.6762-4-clg@kaod.org>
References: <20180622121417.6762-1-clg@kaod.org>
 <20180622121417.6762-4-clg@kaod.org>
Message-ID: <CACPK8XdLb54FfPjVpeUkjDja_7O9EizJJ8BRJLGxdbMMckjWLg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 22 June 2018 at 21:44, C?dric Le Goater <clg@kaod.org> wrote:
> We will need the AHB frequency to set the SPI clock frequency to
> perform the SPI calibration sequence and optimize the controller
> settings for the fast reads.
>
> Signed-off-by: C?dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
