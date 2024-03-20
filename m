From: Rob Herring <robh@kernel.org>
Date: Wed, 20 Mar 2024 10:40:48 -0500
Subject: [PATCH v2 4/4] dt-bindings: aspeed: Add eSPI controller
In-Reply-To: <a9faa9b4-9bf6-49b6-b7eb-f642e2d261c3@gmail.com>
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
 <20240319093405.39833-5-manojkiran.eda@gmail.com>
 <bad5df79-e040-4868-9db6-701110894ea3@linaro.org>
 <a9faa9b4-9bf6-49b6-b7eb-f642e2d261c3@gmail.com>
Message-ID: <20240320154048.GA1777957-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 20, 2024 at 03:29:15PM +0530, Manojkiran Eda wrote:
>    On 19/03/24 3:26 pm, Krzysztof Kozlowski wrote:
> 
> On 19/03/2024 10:34, Manojkiran Eda wrote:
> 
> This commit adds the device tree bindings for aspeed eSPI
> controller.
> 
> Although aspeed eSPI hardware supports 4 different channels,
> this commit only adds the support for flash channel, the
> bindings for other channels could be upstreamed when the driver
> support for those are added.
> 
> Signed-off-by: Manojkiran Eda [1]<manojkiran.eda@gmail.com>
> ---
>  .../bindings/soc/aspeed/aspeed,espi.yaml      | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yam
> l
> 
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml b/Doc
> umentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
> new file mode 100644
> index 000000000000..3d3ad528e3b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
> 
> Why Rob's comments got ignored?
> 
> This is not a soc component.
> 
>    I did not mean to ignore, i have few reasons listed below that provides
>    information on why i felt this belongs into soc.

Fix you email program to not send multi-part (txt plus html) emails. 
Plain text only on maillists.

Rob
