From: Rob Herring <robh@kernel.org>
Date: Tue, 21 Mar 2023 16:32:40 -0500
Subject: [PATCH v3 2/5] dt-bindings: dmaengine: Add AST2600 UDMA bindings
In-Reply-To: <20230320081133.23655-3-chiawei_wang@aspeedtech.com>
References: <20230320081133.23655-1-chiawei_wang@aspeedtech.com>
 <20230320081133.23655-3-chiawei_wang@aspeedtech.com>
Message-ID: <167943435989.1648881.16454367602496486662.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Mon, 20 Mar 2023 16:11:30 +0800, Chia-Wei Wang wrote:
> Add the dmaengine bindings for the UART DMA engine of Aspeed AST2600 SoC.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../bindings/dma/aspeed,ast2600-udma.yaml     | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

