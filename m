From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 20 Feb 2018 17:47:12 +0100
Subject: [PATCH v2 0/3] reset: simple: enable for ASPEED SoCs
In-Reply-To: <20180220014330.23425-1-joel@jms.id.au>
References: <20180220014330.23425-1-joel@jms.id.au>
Message-ID: <1519145232.3470.13.camel@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

On Tue, 2018-02-20 at 12:13 +1030, Joel Stanley wrote:
> v2: Fix typos in bindings document, add Rob's ack
> 
> This series that enables the simple reset driver for the ASPEED SoCs.

Thanks, I have applied patches 1 (with fixup for a whitespace issue that
git complained about) and 2 to the reset/next branch.
I have dropped patch 3 for now because it doesn't seem necessary, but if
there is an actual user that wants to disable reset-simple and UART on
small ASPEED systems, I'll be happy to add it with an explanation.

regards
Philipp
