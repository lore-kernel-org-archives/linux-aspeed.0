From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 20 Nov 2019 16:36:55 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_v3_3/3]_mmc:_sdhci-of-aspeed:_add_inversion_signal_?=
 =?UTF-8?Q?presence?=
In-Reply-To: <20191118104646.3838-4-i.mikhaylov@yadro.com>
References: <20191118104646.3838-1-i.mikhaylov@yadro.com>
 <20191118104646.3838-4-i.mikhaylov@yadro.com>
Message-ID: <b525ea84-aaa0-45b3-95fd-a1b3518511b3@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2019, at 21:16, Ivan Mikhaylov wrote:
> Add read_l callback in sdhci_ops with flipping of SDHCI_CARD_PRESENT
> bit in case of inverted card detection signal.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
