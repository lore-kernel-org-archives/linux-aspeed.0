From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 3 Feb 2024 07:13:08 -0800
Subject: [PATCH v13 1/3] dt-bindings: hwmon: fan: Add fan binding to
 schema
In-Reply-To: <20240124060705.1342461-2-billy_tsai@aspeedtech.com>
References: <20240124060705.1342461-1-billy_tsai@aspeedtech.com>
 <20240124060705.1342461-2-billy_tsai@aspeedtech.com>
Message-ID: <e1b1c69f-a2ff-4fa5-80a6-3ff0a3de6ce6@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 24, 2024 at 02:07:03PM +0800, Billy Tsai wrote:
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

v12 of this patch got a Reviewed-by: tag from Rob.
The tag is gone in this version, presumably meaning that there
was a substantial change.

I don't normally do this, but I downloaded v12 and v13 and did not
find a single change. Why did you drop Rob's Reviewed-by: tag ?

Guenter
