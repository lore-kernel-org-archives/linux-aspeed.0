From: Rob Herring <robh@kernel.org>
Date: Fri, 12 Jan 2024 19:55:03 -0600
Subject: [PATCH v12 1/3] dt-bindings: hwmon: fan: Add fan binding to
 schema
In-Reply-To: <20240108074348.735014-2-billy_tsai@aspeedtech.com>
References: <20240108074348.735014-1-billy_tsai@aspeedtech.com>
 <20240108074348.735014-2-billy_tsai@aspeedtech.com>
Message-ID: <170511090309.3829370.10710486836364106581.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Mon, 08 Jan 2024 15:43:46 +0800, Billy Tsai wrote:
> From: Naresh Solanki <naresh.solanki@9elements.com>
> 
> Add common fan properties bindings to a schema.
> 
> Bindings for fan controllers can reference the common schema for the
> fan
> 
> child nodes:
> 
>   patternProperties:
>     "^fan@[0-2]":
>       type: object
>       $ref: fan-common.yaml#
>       unevaluatedProperties: false
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../devicetree/bindings/hwmon/fan-common.yaml | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

