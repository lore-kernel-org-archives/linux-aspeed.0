From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 27 Jan 2021 10:54:55 +1030
Subject: [PATCH v5 1/5] dt-bindings: aspeed-lpc: Remove LPC partitioning
In-Reply-To: <20210114131622.8951-2-chiawei_wang@aspeedtech.com>
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
 <20210114131622.8951-2-chiawei_wang@aspeedtech.com>
Message-ID: <85f00459-4a39-441e-8119-8e12f8132cfe@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 14 Jan 2021, at 23:46, Chia-Wei, Wang wrote:
> The LPC controller has no concept of the BMC and the Host partitions.
> This patch fixes the documentation by removing the description on LPC
> partitions. The register offsets illustrated in the DTS node examples
> are also fixed to adapt to the LPC DTS change.
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>

Any thoughts Lee? If you ack it would you be happy for the patch to go through 
the Aspeed tree?

Andrew
