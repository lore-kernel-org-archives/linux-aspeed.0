From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 7 Mar 2024 10:46:47 -0800
Subject: [PATCH v14 1/3] dt-bindings: hwmon: fan: Add fan binding to
 schema
In-Reply-To: <20240221104025.1306227-2-billy_tsai@aspeedtech.com>
References: <20240221104025.1306227-1-billy_tsai@aspeedtech.com>
 <20240221104025.1306227-2-billy_tsai@aspeedtech.com>
Message-ID: <11ad14bd-bf25-4c07-b704-46a744071ead@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 21, 2024 at 06:40:23PM +0800, Billy Tsai wrote:
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
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Applied to hwmon-next. There have been a couple of questions, specifically:

- min-rpm of 1000 seems low. Fans with higher minimum RPM
  are known to exist.
- A default value of '2' was suggested for pulses-per-revolution.

Those questions can be addressed with subsequent patches if needed.

Guenter
