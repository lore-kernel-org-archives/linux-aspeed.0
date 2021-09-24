From: Rob Herring <robh@kernel.org>
Date: Thu, 23 Sep 2021 20:01:25 -0500
Subject: [PATCH v6 2/4] dt-bindings: aspeed: Add UART routing controller
In-Reply-To: <20210922073241.14119-3-chiawei_wang@aspeedtech.com>
References: <20210922073241.14119-1-chiawei_wang@aspeedtech.com>
 <20210922073241.14119-3-chiawei_wang@aspeedtech.com>
Message-ID: <YU0jZb/VgSTeHMMK@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 22 Sep 2021 15:32:39 +0800, Chia-Wei Wang wrote:
> Add dt-bindings for Aspeed UART routing controller.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  4 ++
>  .../bindings/soc/aspeed/uart-routing.yaml     | 56 +++++++++++++++++++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
