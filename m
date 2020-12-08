From: Joel Stanley <joel@jms.id.au>
Date: Tue, 8 Dec 2020 04:41:11 +0000
Subject: [PATCH 1/2] dt-bindings: vendor-prefixes: Add an entry for
 AmpereComputing.com
In-Reply-To: <20201208043700.23098-2-quan@os.amperecomputing.com>
References: <20201208043700.23098-1-quan@os.amperecomputing.com>
 <20201208043700.23098-2-quan@os.amperecomputing.com>
Message-ID: <CACPK8Xcs6ED5C_2RHrG0Bipn8sjPK7yBjcYvJ=UT6w2SRm0swQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Rob,

On Tue, 8 Dec 2020 at 04:37, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>
> Add "ampere" entry for Ampere Computing LLC: amperecomputing.com
>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> Signed-off-by: Phong Vo <phong@os.amperecomputing.com>
> Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>

Do you take this through your tree?

Cheers,

Joel

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 3a76c226771b..a83fa090f3d4 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -85,6 +85,8 @@ patternProperties:
>      description: Shenzhen Amediatech Technology Co., Ltd
>    "^amlogic,.*":
>      description: Amlogic, Inc.
> +  "^ampere,.*":
> +    description: Ampere Computing LLC
>    "^ampire,.*":
>      description: Ampire Co., Ltd.
>    "^ams,.*":
> --
> 2.28.0
>
