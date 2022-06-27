From: Rob Herring <robh@kernel.org>
Date: Mon, 27 Jun 2022 16:00:58 -0600
Subject: [PATCH v8 2/3] bindings: ipmi: Add binding for SSIF BMC driver
In-Reply-To: <20220615090259.1121405-3-quan@os.amperecomputing.com>
References: <20220615090259.1121405-1-quan@os.amperecomputing.com>
 <20220615090259.1121405-3-quan@os.amperecomputing.com>
Message-ID: <20220627220058.GA3036977-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jun 15, 2022 at 04:02:58PM +0700, Quan Nguyen wrote:
> Add device tree binding document for the SSIF BMC driver.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> v8:
>   + None
> 
> v7:
>   + Change compatible string from "ampere,ssif-bmc" to "ssif-bmc"  [Jae]
> 
> v6:
>   + None
> 
> v5:
>   + None
> 
> v4:
>   + Fix warning with dt_binding_check [Rob]
>   + Change aspeed-ssif-bmc.yaml to ssif-bmc.yaml [Quan]
> 
> v3:
>   + Switched to use DT schema format [Rob]
> 
> v2:
>   + None
> 
>  .../devicetree/bindings/ipmi/ssif-bmc.yaml    | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
