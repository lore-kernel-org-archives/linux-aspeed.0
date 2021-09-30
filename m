From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Thu, 30 Sep 2021 01:55:20 +0000
Subject: [PATCH v7 3/5] dt-bindings: aspeed: Add UART routing controller
In-Reply-To: <YVTkjKdXcyIVImmP@robh.at.kernel.org>
References: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
 <20210927023053.6728-4-chiawei_wang@aspeedtech.com>
 <YVTkjKdXcyIVImmP@robh.at.kernel.org>
Message-ID: <HK0PR06MB377971D66A2ABA4929D3646791AA9@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, September 30, 2021 6:11 AM
> 
> On Mon, 27 Sep 2021 10:30:51 +0800, Chia-Wei Wang wrote:
> > Add dt-bindings for Aspeed UART routing controller.
> >
> > Signed-off-by: Oskar Senft <osk@google.com>
> > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  4 ++
> >  .../bindings/soc/aspeed/uart-routing.yaml     | 56
> +++++++++++++++++++
> >  2 files changed, 60 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
> >
> 
> Applied, thanks!

Thanks!

Hi Joel,

Could you help to review the rest patches to see if they are ready to be merged into the linux-aspeed tree?
Thanks.

Regards,
Chiawei
