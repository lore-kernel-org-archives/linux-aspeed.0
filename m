From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Oct 2022 08:14:08 -0500
Subject: [PATCH v2 3/4] dt-bindings: crypto: add documentation for Aspeed
 ACRY
In-Reply-To: <20221004032841.3714928-4-neal_liu@aspeedtech.com>
References: <20221004032841.3714928-1-neal_liu@aspeedtech.com>
 <20221004032841.3714928-4-neal_liu@aspeedtech.com>
Message-ID: <166497564756.3256206.1489547324996590627.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 04 Oct 2022 11:28:40 +0800, Neal Liu wrote:
> Add device tree binding documentation for the Aspeed
> ECDSA/RSA ACRY Engines Controller.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  .../bindings/crypto/aspeed,ast2600-acry.yaml  | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  2 files changed, 50 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
